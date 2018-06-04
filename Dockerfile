FROM debian:stretch

LABEL maintainer="Ig Pl, <justgbox1@gmail.com>"
LABEL version="0.1"

ENV LIBRESWAN_VER="3.23"

RUN apt-get -y update && apt-get -y install libnss3-dev libnspr4-dev pkg-config libpam-dev \
    libcap-ng-dev libcap-ng-utils libselinux-dev \
    libcurl3-nss-dev flex bison gcc make libldns-dev \
    libunbound-dev libnss3-tools libevent-dev xmlto \
    libsystemd-dev

COPY ./run.sh /opt/src/run.sh
RUN chmod 755 /opt/src/run.sh

EXPOSE 500/udp 4500/udp

VOLUME ["/lib/modules"]

CMD ["/opt/src/run.sh"]
