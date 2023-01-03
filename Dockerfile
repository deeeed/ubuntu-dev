FROM summerwind/actions-runner:latest

SHELL ["/bin/bash", "-c"]

WORKDIR /home/runner

ENV NODE_VERSION 16.16.0
ENV NVM_DIR $HOME/.nvm

RUN sudo apt update -y \
  && umask 0002 \
  && sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg \
  && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install v$NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && npm install --location=global yarn


ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN sudo rm -rf /var/lib/apt/lists/*
