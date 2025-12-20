FROM genjiohara/rye AS rye-env

FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04
ENV PATH /root/.rye/shims:${PATH}
COPY --from=rye-env /root/.rye /root/.rye
