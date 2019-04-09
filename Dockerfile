FROM ubuntu:18.04

ENV C9UID        1000
ENV C9USER       c9user
ENV C9PASSWORD   c9user

ENV C9GID        1000
ENV C9GROUP      c9user

ENV C9HOME       /home/c9user
ENV C9PORT       8181

ENV GRANT_SUDO   yes

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
      sudo \
      vim \
      whois \
      wget \
      curl \
      locales \
      build-essential \
      python \
      ca-certificates \
      git
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y --no-install-recommends nodejs npm
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Install pm2
RUN npm install pm2 -g

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY ./entrypoint.sh /entrypoint.sh
COPY ./c9-install.sh /usr/local/bin/c9-install.sh

EXPOSE 80 443 43554 $C9PORT
