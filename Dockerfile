FROM lscr.io/linuxserver/baseimage-debian:trixie

RUN apt-get update
RUN apt-get install -y wget gpg
RUN apt-get install -y net-tools inetutils-tools inetutils-ping nano unzip libfuse2

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
RUN apt-get install -y nodejs

COPY root/ /


