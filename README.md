# ubuntu-dev

`Dockerfile.dev`: Simple image to get started quickly for local dev or debug network activity.

- use a simple port listener to avoid having running the image interactively and prevent automatic exit (useuful for k8s).
    - `nc -l -k 1337`
- no care for image size optimization, this is not meant for production.
## Publish

```bash
# Replace with your own docker credentials
docker login

# # for macos m1 users, create multi-arch build
# docker buildx create --name mybuilder --use
# docker buildx inspect --bootstrap
# docker buildx build --platform linux/amd64,linux/arm64 --push -t docker.io/deeeed/ubuntu-dev:latest .

# or if you don't care for multi-arch
docker build -f Dockerfile.dev -t docker.io/deeeed/ubuntu-dev:latest .
# docker push docker.io/deeeed/ubuntu-dev:latest
# github actions will automatically publish multi-arch images

# try it on interactively
docker run -it deeeed/ubuntu-dev bash

# or let it run in the background
docker run -d deeeed/ubuntu-dev
```

# github runner

Extend default github runner `summerwind/actions-runner:latest` to add node16 + yarn support.

```bash
docker build -f Dockerfile.runner -t docker.io/deeeed/runner:latest .

docker run -it deeeed/runner bash
```