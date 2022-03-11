# dump1090 OCI image

![pipeline status](https://github.com/chimbosonic/dump1090-container/actions/workflows/main.yml/badge.svg?branch=main)

This is a dump1090 with SDRplay support OCI image built using https://github.com/SDRplay/dump1090.

Base image is `debian:buster-slim`.

The image is available on Docker Hub [here](https://hub.docker.com/repository/docker/chimbosonic/dump1090)

Source code and pipeline can be found [here](https://github.com/chimbosonic/dump1090-container)

## Image Verification

The image is signed using [cosign](https://github.com/sigstore/cosign) from sigstore.

You can verify the signature with:

```bash
cosign verify --key cosign.pub chimbosonic/dump1090:latest
```

## Running it

### plain docker

Dump1090 needs access to your USB devices

```bash
docker run --rm -it --device /dev/bus/usb chimbosonic/dump1090:latest
```

### How to build

This will build the container.

```bash
make build
```

All credit to the maintainers of [dump1090](https://github.com/SDRplay/dump1090).