FROM ubuntu

RUN apt update && apt install -y pipx

USER ubuntu
RUN pipx ensurepath
RUN pipx install poetry
ENV PATH $PATH:/home/ubuntu/.local/bin
