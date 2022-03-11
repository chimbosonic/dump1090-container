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

### NOTES

dump1090's internal webserver is bad and currently broken. This container includes the HTML stuff but I wouldn't recommend it.
You could host the `js` and `index.html` on its own http server and refer to the `data/*.json` endpoint.
I run `mikenye/readsb-protobuf` from https://github.com/sdr-enthusiasts/docker-readsb-protobuf and have it connect to dump1090 (sadly it can't use the RSP1A directly). I then have readsb host the webserver and also push the metrics to influx and grafana.
I also had luck with https://github.com/claws/dump1090-exporter allowing to export dump1090's data to prometheus.
I would share how all of this connects but all my code is specific to my environment. If you have any questions I can try and answer them.


All credit to the maintainers of [dump1090](https://github.com/SDRplay/dump1090).