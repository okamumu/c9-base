FROM ubuntu:16.04

ENV SUDOUSER_UID       1000
ENV SUDOUSER_NAME      docker
ENV SUDOUSER_HOMEDIR   /home/docker
ENV SUDOUSER_PASSWORD  docker

ENV C9USER       c9user
ENV C9PASSWORD   c9user
ENV C9PORT       8181

RUN apt-get update
RUN apt-get install -y \
    sudo \
    wget curl \
    build-essential \
    python \
    git-core
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN useradd -d $SUDOUSER_HOMEDIR -m -u $SUDOUSER_UID -p $SUDOUSER_PASSWORD $SUDOUSER_NAME &&\
  echo "$SUDOUSER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$SUDOUSER_NAME

COPY ./entrypoint.sh /entrypoint.sh

EXPOSE $C9PORT
VOLUME $SUDOUSER_HOMEDIR

USER $SUDOUSER_NAME
ENTRYPOINT ["/entrypoint.sh"]
