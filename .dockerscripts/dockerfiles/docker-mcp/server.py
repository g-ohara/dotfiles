import os
import subprocess
import uuid

from mcp.server.fastmcp import FastMCP

WORKSPACE_ROOT = "/workspace"
BUILD_TIMEOUT_SECONDS = 300
DEFAULT_RUN_TIMEOUT_SECONDS = 60
MAX_RUN_TIMEOUT_SECONDS = 300

mcp = FastMCP(
    "docker-mcp",
    host=os.environ.get("HOST", "0.0.0.0"),
    port=int(os.environ.get("PORT", "3004")),
)


def _validate_workspace_dir(path: str) -> tuple[str | None, str | None]:
    if not path:
        return None, "dockerfile_dir is required"
    resolved = os.path.realpath(path)
    if resolved != WORKSPACE_ROOT and not resolved.startswith(WORKSPACE_ROOT + os.sep):
        return None, f"'{path}' resolves outside of {WORKSPACE_ROOT}; refusing to build"
    if not os.path.isdir(resolved):
        return None, f"'{resolved}' is not a directory"
    return resolved, None


def _force_remove_container(name: str) -> None:
    subprocess.run(["docker", "kill", name], capture_output=True, text=True, timeout=10)
    subprocess.run(["docker", "rm", "-f", name], capture_output=True, text=True, timeout=10)


@mcp.tool()
def build_docker_image(
    dockerfile_dir: str, image_name: str, build_args: dict[str, str] | None = None
) -> dict:
    """Build a Docker image from a Dockerfile located under /workspace.

    Args:
        dockerfile_dir: Absolute path under /workspace containing the Dockerfile
            to build (e.g. "/workspace/projectA").
        image_name: Tag to assign to the built image (e.g. "projectA:test").
        build_args: Optional build-time variables passed via --build-arg
            (e.g. {"NEXT_PUBLIC_BASE_PATH": "/note"}).
    """
    resolved_dir, error = _validate_workspace_dir(dockerfile_dir)
    if error:
        return {"success": False, "error": error}
    if not image_name:
        return {"success": False, "error": "image_name is required"}

    command = ["docker", "build", "-t", image_name]
    for key, value in (build_args or {}).items():
        command.extend(["--build-arg", f"{key}={value}"])
    command.append(resolved_dir)

    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            timeout=BUILD_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker build timed out after {BUILD_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "image_name": image_name if result.returncode == 0 else None,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


@mcp.tool()
def run_test_container(image_name: str, command: str, timeout_seconds: int = DEFAULT_RUN_TIMEOUT_SECONDS) -> dict:
    """Run a command inside a throwaway container and return its output.

    Args:
        image_name: Image to run, typically one produced by build_docker_image.
        command: Shell command to execute inside the container.
        timeout_seconds: Max seconds to allow the container to run before it is
            killed (default 60, capped at 300).
    """
    if not image_name:
        return {"success": False, "error": "image_name is required"}
    if not command:
        return {"success": False, "error": "command is required"}

    timeout_seconds = max(1, min(timeout_seconds, MAX_RUN_TIMEOUT_SECONDS))
    container_name = f"mcp-test-{uuid.uuid4().hex[:12]}"

    try:
        result = subprocess.run(
            ["docker", "run", "--rm", "--name", container_name, image_name, "sh", "-c", command],
            capture_output=True,
            text=True,
            timeout=timeout_seconds,
        )
        return {
            "success": result.returncode == 0,
            "exit_code": result.returncode,
            "stdout": result.stdout,
            "stderr": result.stderr,
            "timed_out": False,
        }
    except subprocess.TimeoutExpired as exc:
        _force_remove_container(container_name)
        return {
            "success": False,
            "error": f"container timed out after {timeout_seconds}s and was killed",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
            "timed_out": True,
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}


if __name__ == "__main__":
    mcp.run(transport="sse")
