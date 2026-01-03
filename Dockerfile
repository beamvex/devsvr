FROM lscr.io/linuxserver/baseimage-debian:trixie

RUN apt-get update
RUN apt-get install -y wget gpg
RUN apt-get install -y net-tools inetutils-tools inetutils-ping nano unzip libfuse2 openssh-server openssh-client

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
RUN apt-get install -y nodejs

COPY root/ /

RUN chmod 600 /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh

RUN curl -fsSL https://code-server.dev/install.sh | sh   
RUN curl -s https://raw.githubusercontent.com/PumpkinSeed/windsurf-installer/refs/heads/main/install.sh | sh   

RUN apt-get install -y git openssl pkg-config libssl-dev


EXPOSE 2222
