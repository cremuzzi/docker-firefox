FROM debian:9.9-slim

LABEL maintainer="Carlos Remuzzi <carlosremuzzi@gmail.com>"

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        alsa-utils \
        dbus \
        libavcodec-dev \
        firefox-esr \
        ttf-dejavu \
        tzdata \
    && useradd -m -u 1000 -s /bin/sh firefox \
    && mkdir -p /home/firefox/.mozilla/ \
    && chown -R firefox:firefox /home/firefox/.mozilla/ \
    && rm -rf /var/lib/apt/lists/*

USER firefox

WORKDIR /home/firefox

VOLUME ["/home/firefox/.mozilla","/home/firefox/Downloads"]

CMD ["firefox"] 
