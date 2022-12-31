FROM ubuntu:latest
LABEL maintainer="Arthur Breton <abreton@siteed.net>"
ARG DEBIAN_FRONTEND=noninteractive

# default port value, can be overwritten
ARG PORT=1337
EXPOSE ${PORT}

USER root
# Set timezone otherwise image cannot build 
ENV TZ=Asia/Hong_Kong 
# Default dev packages
RUN apt-get update && \
    apt-get install -y tzdata dumb-init curl nodejs wget openjdk-11-jdk-headless hostname openssl netcat npm gcc build-essential net-tools tcpdump

CMD ["dumb-init", "nc", "-lkvv", "1337"]