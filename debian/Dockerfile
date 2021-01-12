FROM debian:10-slim

ARG VERSION=84.0.2

LABEL maintainer="Carlos Remuzzi <carlosremuzzi@gmail.com>"
LABEL version=$VERSION

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        bzip2 \
        ca-certificates \
        curl \
        dbus \
        libavcodec-dev \
        libdbus-glib-1-2 \
        libgl1-mesa-dri \
        libgtk-3-0 \
        libxt6 \
        mesa-utils \
        pulseaudio \
        ttf-dejavu \
    && curl -fsL https://download-installer.cdn.mozilla.net/pub/firefox/releases/${VERSION}/linux-x86_64/en-US/firefox-${VERSION}.tar.bz2 \
        -o firefox.tar.bz2 \
    && useradd -m -u 1000 -s /bin/sh firefox \
    && tar -C /usr/lib/ -xf firefox.tar.bz2 \
    && rm firefox.tar.bz2 \
    && cd /usr/bin \
    && ln -s ../lib/firefox/firefox firefox \
    && mkdir -p /home/firefox/.mozilla/ \
    && mkdir -p /home/firefox/Downloads/ \
    && mkdir -p /home/firefox/.config/pulse \
    && echo "default-server = unix:/run/user/1000/pulse/native" > /home/firefox/.config/pulse/client.conf \
    && echo "autospawn = no" >> /home/firefox/.config/pulse/client.conf \
    && echo "daemon-binary = /bin/true" >> /home/firefox/.config/pulse/client.conf \
    && echo "enable-shm = false" >> /home/firefox/.config/pulse/client.conf \
    && chown -R firefox:firefox /home/firefox/ \
    && apt-get remove -y \
        bzip2 \
        curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

USER firefox

WORKDIR /home/firefox

VOLUME ["/home/firefox/.mozilla","/home/firefox/Downloads"]

CMD ["firefox"]
