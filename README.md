# SETUP

This repository creates and deploy two docker images `deeeed/ubuntu-dev` and `deeeed/runner`:

CICD pipeline will automatically publish to:
- [https://hub.docker.com/repository/docker/deeeed/ubuntu-dev]
- [https://hub.docker.com/repository/docker/deeeed/runner]

## ubuntu-dev

`Dockerfile.dev`: Simple image to get started quickly for local dev or debug network activity.

- use a simple port listener to avoid having running the image interactively and prevent automatic exit (useuful for k8s).
    - `nc -l -k 1337`
- no care for image size optimization, this is not meant for production.

```bash
# Replace with your own docker credentials
docker login

# # for macos m1 users, create multi-arch build
# docker buildx create --name mybuilder --use
# docker buildx inspect --bootstrap
# docker buildx build --platform linux/amd64,linux/arm64 --push -t docker.io/deeeed/ubuntu-dev:latest .

# or if you don't care for multi-arch
docker build -f Dockerfile.dev -t docker.io/deeeed/ubuntu-dev:latest . --no-cache
# docker push docker.io/deeeed/ubuntu-dev:latest
# github actions will automatically publish multi-arch images

# try it on interactively
docker run -it deeeed/ubuntu-dev bash

# or let it run in the background
docker run -d deeeed/ubuntu-dev
```

## github runner

`Dockerfile.runner`: Image to get started quickly for custom github runner.

Extend default github runner `summerwind/actions-runner:latest` to add:
- node16 
- yarn + pnpm
- nvm
- latest docker
- kubectl
- helm

```bash
docker build -f Dockerfile.runner -t docker.io/deeeed/runner:latest . --no-cache

docker run -it deeeed/runner bash
```