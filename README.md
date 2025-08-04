# Sarix

Immutable Linux distro for low-end PCs.

Gentoo is used as a build tool and base.

## Build

```sh
docker build -t sarix .
```

## Run

```sh
docker run -it sarix
```
```

### Run the Image

```sh
docker run -it sarix
```

## Dockerfile Overview

- Uses multi-stage build to copy the base Gentoo filesystem to `/mnt/target`
- Installs and removes packages to optimize the image
- Cleans up documentation and man pages

## Requirements

- Docker

## License

MIT
