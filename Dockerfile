FROM ubuntu:16.04

ENV C9UID        1000
ENV C9USER       c9user
ENV C9PASSWORD   c9user

ENV C9GID        1000
ENV C9GROUP      c9user

ENV C9HOME       /home/c9user
ENV C9PORT       8181

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    sudo \
    vim \
    whois \
    nodejs npm \
    wget \
    curl \
    locales \
    build-essential \
    python \
    git
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY ./entrypoint.sh /entrypoint.sh

EXPOSE $C9PORT
VOLUME $C9HOME

ENTRYPOINT ["/entrypoint.sh"]
