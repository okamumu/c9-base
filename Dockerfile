FROM ubuntu:18.04

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
      tmux \
      git
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y --no-install-recommends nodejs npm
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Install pm2
RUN npm install pm2 -g
RUN npm install pm2-gui -g

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# install c9
COPY ./c9install.sh /usr/local/bin/c9install.sh
RUN HOME=/etc/skel c9install.sh

COPY ./c9start.sh /usr/local/bin/c9start.sh
COPY ./c9mkhomedir_helper.sh /usr/local/bin/c9mkhomedir_helper.sh

ENV PM2PORT     80
ENV PM2PASSWORD pm2
COPY ./pm2-gui.ini /etc/pm2-gui.ini
COPY ./entrypoint.sh /root/entrypoint.sh

ENV C9UID        1000
ENV C9USER       c9user
ENV C9PASSWORD   c9user
ENV C9GID        1000
ENV C9GROUP      c9user
ENV C9HOME       /home/c9user
ENV C9PORT       8181
ENV C9GRANT_SUDO   yes

EXPOSE $PM2PORT

ENTRYPOINT ["/root/entrypoint.sh"]
