FROM lscr.io/linuxserver/baseimage-debian:trixie

RUN apt-get update
RUN apt-get install -y wget gpg git openssl \
    pkg-config libssl-dev net-tools inetutils-tools \
    inetutils-ping nano unzip libfuse2 \
    openssh-server openssh-client

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
RUN apt-get install -y nodejs

COPY root/ /

RUN chmod 600 /usr/tmpl/.ssh/authorized_keys
RUN chmod 700 /usr/tmpl/.ssh

EXPOSE 2222
