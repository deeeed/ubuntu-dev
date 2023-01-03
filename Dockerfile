FROM ubuntu:latest
LABEL maintainer="Arthur Breton <abreton@siteed.net>"
ARG DEBIAN_FRONTEND=noninteractive

# default port value, can be overwritten
ARG PORT=1337
EXPOSE ${PORT}
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV NODE_VERSION 16.16.0
ENV NVM_DIR /root/.nvm

USER root
# Set timezone otherwise image cannot build 
ENV TZ=Asia/Hong_Kong 
# Default dev packages
RUN apt-get update && apt-get install -y curl vim \
    tzdata dumb-init wget openjdk-11-jdk-headless \
    hostname openssl netcat npm gcc build-essential net-tools tcpdump \
    iputils-ping 
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install v$NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

#RUN nvm install 16.16.0
CMD ["dumb-init", "nc", "-lkvv", "1337"]