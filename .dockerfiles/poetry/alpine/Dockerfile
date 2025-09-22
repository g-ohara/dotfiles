FROM python:3.14.0rc3-alpine3.22
ENV SHELL /bin/sh

RUN apk add gcc musl-dev
RUN adduser -D user
USER user
RUN python3 -m pip install --user pipx
RUN python3 -m pipx ensurepath
RUN python3 -m pipx install poetry
ENV PATH $PATH:/home/user/.local/bin
