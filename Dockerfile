FROM ubuntu:18.04

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
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
      git &&\
    curl -sL https://deb.nodesource.com/setup_6.x | bash - &&\
    apt-get install -y --no-install-recommends nodejs npm &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Install pm2
RUN npm install pm2 -g &&\
    npm install pm2-gui -g

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# copy scripts for c9 and install c9 to /etc/skel
COPY ./c9mkhomedir_helper.sh /usr/local/bin/c9mkhomedir_helper.sh
COPY ./c9install.sh /usr/local/bin/c9install.sh
RUN HOME=/etc/skel c9install.sh

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

CMD ["/root/entrypoint.sh"]
