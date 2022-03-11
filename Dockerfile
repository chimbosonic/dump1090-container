FROM debian:buster-slim as builder

ARG DUMP_1090_REPO=https://github.com/SDRplay/dump1090.git
ARG SDRPLAY_API=https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-3.07.1.run

RUN apt-get -y update \
&& apt-get -y install librtlsdr-dev libudev-dev git libusb-1.0-0-dev pkg-config debhelper \
&& mkdir -p /opt/dump1090


WORKDIR /opt/dump1090

RUN git clone --depth 1 ${DUMP_1090_REPO} /opt/dump1090 && rm -rf /opt/dump1090/Makefile
COPY scripts/Makefile /opt/dump1090/Makefile
RUN curl ${SDRPLAY_API} -o SDRplay_RSP_API.run \
&& chmod +x SDRplay_RSP_API.run \
&& ./SDRplay_RSP_API.run --tar -xvf \
&& cp /opt/dump1090/x86_64/libsdrplay_api.so.3.07  /usr/local/lib/libsdrplay_api.so \
&& cp /opt/dump1090/x86_64/libsdrplay_api.so.3.07 /usr/local/lib/libsdrplay_api.so.3.07 \
&& chmod 644 /usr/local/lib/libsdrplay_api.so /usr/local/lib/libsdrplay_api.so.3.07 \
&& ldconfig \
&& make

FROM debian:buster-slim

COPY  --from=builder /opt/dump1090/dump1090 /opt/dump1090/dump1090
COPY  --from=builder /opt/dump1090/x86_64/libsdrplay_api.so.3.07 /usr/local/lib/libsdrplay_api.so
COPY  --from=builder /opt/dump1090/x86_64/libsdrplay_api.so.3.07  /usr/local/lib/libsdrplay_api.so.3.07
COPY  --from=builder /opt/dump1090/x86_64/sdrplay_apiService /opt/dump1090/sdrplay_apiService
COPY scripts/entrypoint.sh /opt/dump1090/entrypoint.sh

WORKDIR /opt/dump1090
RUN apt-get -y update && apt-get -y install tini librtlsdr0 libusb-1.0-0 rtl-sdr && chmod +x /opt/dump1090/entrypoint.sh /opt/dump1090/dump1090 /opt/dump1090/sdrplay_apiService

ENTRYPOINT ["/usr/bin/tini", "--", "/opt/dump1090/entrypoint.sh"]
CMD ["--dev-sdrplay","--net","--oversample"]