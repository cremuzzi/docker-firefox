FROM debian:10-slim

ARG VERSION=78.0.1

LABEL maintainer="Carlos Remuzzi <carlosremuzzi@gmail.com>"
LABEL version=$VERSION

RUN apt update \
    && apt install --no-install-recommends -y \
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
    && tar -C /home/firefox -xf firefox.tar.bz2 \
    && mkdir -p /home/firefox/.mozilla/ \
    && chown -R firefox:firefox /home/firefox/ \
    && rm -rf /var/lib/apt/lists/*

COPY --chown=firefox:firefox client.conf /home/firefox/.config/pulse/client.conf

USER firefox

WORKDIR /home/firefox

VOLUME ["/home/firefox/.mozilla","/home/firefox/Downloads"]

CMD ["firefox/firefox"]
