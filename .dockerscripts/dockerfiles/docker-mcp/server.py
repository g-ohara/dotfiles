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


def _validate_workspace_path(path: str) -> tuple[str | None, str | None]:
    if not path:
        return None, "workspace_path is required"
    resolved = os.path.realpath(path)
    if resolved != WORKSPACE_ROOT and not resolved.startswith(WORKSPACE_ROOT + os.sep):
        return None, f"'{path}' resolves outside of {WORKSPACE_ROOT}; refusing"
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
def run_test_container(
    image_name: str,
    command: str,
    timeout_seconds: int = DEFAULT_RUN_TIMEOUT_SECONDS,
    network: str | None = None,
) -> dict:
    """Run a command inside a throwaway container and return its output.

    Args:
        image_name: Image to run, typically one produced by build_docker_image.
        command: Shell command to execute inside the container.
        timeout_seconds: Max seconds to allow the container to run before it is
            killed (default 60, capped at 300).
        network: Optional network (from create_network) to attach the
            container to, so it can reach other containers on that network
            by name.
    """
    if not image_name:
        return {"success": False, "error": "image_name is required"}
    if not command:
        return {"success": False, "error": "command is required"}

    timeout_seconds = max(1, min(timeout_seconds, MAX_RUN_TIMEOUT_SECONDS))
    container_name = f"mcp-test-{uuid.uuid4().hex[:12]}"

    docker_command = ["docker", "run", "--rm", "--name", container_name]
    if network:
        docker_command.extend(["--network", network])
    docker_command.extend([image_name, "sh", "-c", command])

    try:
        result = subprocess.run(
            docker_command,
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


@mcp.tool()
def docker_cp(container_name: str, container_path: str, workspace_path: str, direction: str) -> dict:
    """Copy a file or directory between /workspace and a running container.

    Args:
        container_name: Name of an existing (running) container.
        container_path: Path inside the container.
        workspace_path: Path under /workspace to read from or write to.
        direction: "to_container" copies workspace_path into the container,
            "from_container" copies container_path out to workspace_path.
    """
    if direction not in ("to_container", "from_container"):
        return {"success": False, "error": "direction must be 'to_container' or 'from_container'"}
    if not container_name:
        return {"success": False, "error": "container_name is required"}
    if not container_path:
        return {"success": False, "error": "container_path is required"}

    resolved_ws, error = _validate_workspace_path(workspace_path)
    if error:
        return {"success": False, "error": error}

    if direction == "to_container":
        src, dest = resolved_ws, f"{container_name}:{container_path}"
    else:
        src, dest = f"{container_name}:{container_path}", resolved_ws

    try:
        result = subprocess.run(
            ["docker", "cp", src, dest],
            capture_output=True,
            text=True,
            timeout=DEFAULT_RUN_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker cp timed out after {DEFAULT_RUN_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


@mcp.tool()
def start_container(
    image_name: str,
    name: str | None = None,
    command: str | None = None,
    network: str | None = None,
    ports: dict[str, str] | None = None,
) -> dict:
    """Start a background container that keeps running until stop_container is called.

    Unlike run_test_container, the container is not removed when the started
    process exits, so it can be inspected with container_logs, driven with
    exec_in_container, and used as a docker_cp target.

    Args:
        image_name: Image to run, typically one produced by build_docker_image.
        name: Optional container name. A unique name is generated if omitted.
        command: Optional shell command to run as the container's process; if
            omitted, the image's own default command/entrypoint is used.
        network: Optional network (from create_network) to attach the
            container to, so it can reach other containers on that network
            by name. Pass the same network to multiple containers to link
            them (e.g. an nginx container and the app it proxies to).
        ports: Optional host_port -> container_port mapping (e.g.
            {"8080": "80"}) published on docker-mcp's own network namespace.
            Since docker-mcp's Docker daemon runs nested inside the
            docker-mcp container rather than behind a separate network, a
            published port is reachable as docker-mcp:<host_port> from any
            other service on the compose network (e.g. opencode itself),
            with no extra port mapping needed in compose.yaml.
    """
    if not image_name:
        return {"success": False, "error": "image_name is required"}

    container_name = name or f"mcp-bg-{uuid.uuid4().hex[:12]}"
    docker_command = ["docker", "run", "-d", "--name", container_name]
    if network:
        docker_command.extend(["--network", network])
    for host_port, container_port in (ports or {}).items():
        docker_command.extend(["-p", f"{host_port}:{container_port}"])
    docker_command.append(image_name)
    if command:
        docker_command.extend(["sh", "-c", command])

    try:
        result = subprocess.run(
            docker_command,
            capture_output=True,
            text=True,
            timeout=DEFAULT_RUN_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker run timed out after {DEFAULT_RUN_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "container_name": container_name if result.returncode == 0 else None,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


@mcp.tool()
def container_logs(container_name: str, tail: int | None = None) -> dict:
    """Fetch logs from a container started with start_container.

    Args:
        container_name: Name of the container.
        tail: Optional number of trailing log lines to return; omit for the
            full log.
    """
    if not container_name:
        return {"success": False, "error": "container_name is required"}

    command = ["docker", "logs"]
    if tail is not None:
        command.extend(["--tail", str(tail)])
    command.append(container_name)

    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            timeout=DEFAULT_RUN_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker logs timed out after {DEFAULT_RUN_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


@mcp.tool()
def exec_in_container(
    container_name: str, command: str, timeout_seconds: int = DEFAULT_RUN_TIMEOUT_SECONDS
) -> dict:
    """Run a command inside an already-running container.

    Args:
        container_name: Name of a running container, typically one started
            with start_container.
        command: Shell command to execute inside the container.
        timeout_seconds: Max seconds to allow the command to run before it is
            killed (default 60, capped at 300).
    """
    if not container_name:
        return {"success": False, "error": "container_name is required"}
    if not command:
        return {"success": False, "error": "command is required"}

    timeout_seconds = max(1, min(timeout_seconds, MAX_RUN_TIMEOUT_SECONDS))

    try:
        result = subprocess.run(
            ["docker", "exec", container_name, "sh", "-c", command],
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
        return {
            "success": False,
            "error": f"exec timed out after {timeout_seconds}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
            "timed_out": True,
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}


@mcp.tool()
def stop_container(container_name: str) -> dict:
    """Stop and remove a background container started with start_container.

    Args:
        container_name: Name of the container to stop and remove.
    """
    if not container_name:
        return {"success": False, "error": "container_name is required"}

    try:
        result = subprocess.run(
            ["docker", "rm", "-f", container_name],
            capture_output=True,
            text=True,
            timeout=DEFAULT_RUN_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker rm timed out after {DEFAULT_RUN_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


@mcp.tool()
def list_images() -> dict:
    """List Docker images present in the docker-mcp daemon (`docker images`)."""
    try:
        result = subprocess.run(
            ["docker", "images"],
            capture_output=True,
            text=True,
            timeout=DEFAULT_RUN_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker images timed out after {DEFAULT_RUN_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


@mcp.tool()
def list_containers(all_containers: bool = True) -> dict:
    """List containers in the docker-mcp daemon (`docker ps`).

    Args:
        all_containers: Include stopped containers as well as running ones
            (default True). Set False to see only running containers.
    """
    command = ["docker", "ps"]
    if all_containers:
        command.append("-a")

    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            timeout=DEFAULT_RUN_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker ps timed out after {DEFAULT_RUN_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


@mcp.tool()
def inspect_object(name: str) -> dict:
    """Return `docker inspect` output for an image or container.

    Args:
        name: Image tag/ID or container name/ID to inspect.
    """
    if not name:
        return {"success": False, "error": "name is required"}

    try:
        result = subprocess.run(
            ["docker", "inspect", name],
            capture_output=True,
            text=True,
            timeout=DEFAULT_RUN_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker inspect timed out after {DEFAULT_RUN_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


@mcp.tool()
def create_network(name: str) -> dict:
    """Create a Docker network for linking multiple containers.

    Pass the resulting name as `network` to start_container/run_test_container
    for each container that needs to reach the others by container name
    (e.g. an nginx container proxying to an app container).

    Args:
        name: Name for the network.
    """
    if not name:
        return {"success": False, "error": "name is required"}

    try:
        result = subprocess.run(
            ["docker", "network", "create", name],
            capture_output=True,
            text=True,
            timeout=DEFAULT_RUN_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker network create timed out after {DEFAULT_RUN_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "network_name": name if result.returncode == 0 else None,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


@mcp.tool()
def remove_network(name: str) -> dict:
    """Remove a Docker network created with create_network.

    Args:
        name: Name of the network to remove. Fails if containers are still
            attached to it; stop_container them first.
    """
    if not name:
        return {"success": False, "error": "name is required"}

    try:
        result = subprocess.run(
            ["docker", "network", "rm", name],
            capture_output=True,
            text=True,
            timeout=DEFAULT_RUN_TIMEOUT_SECONDS,
        )
    except subprocess.TimeoutExpired as exc:
        return {
            "success": False,
            "error": f"docker network rm timed out after {DEFAULT_RUN_TIMEOUT_SECONDS}s",
            "stdout": exc.stdout or "",
            "stderr": exc.stderr or "",
        }
    except FileNotFoundError:
        return {"success": False, "error": "docker CLI not found in the docker-mcp container"}

    return {
        "success": result.returncode == 0,
        "exit_code": result.returncode,
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


if __name__ == "__main__":
    mcp.run(transport="sse")
