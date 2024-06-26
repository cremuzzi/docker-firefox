FROM docker.io/library/debian:12.5-slim as base

LABEL org.opencontainers.image.authors="Carlos Remuzzi <carlosremuzzi@gmail.com>"
LABEL org.opencontainers.image.description="Dockerized Firefox"
LABEL org.opencontainers.image.title="firefox"
LABEL org.opencontainers.image.source="https://github.com/cremuzzi/docker-firefox"

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    bzip2 \
    ca-certificates \
    dbus \
    libavcodec-dev \
    libdbus-glib-1-2 \
    libgl1-mesa-dri \
    libgtk-3-0 \
    libxt6 \
    mesa-utils \
    pulseaudio \
    fonts-dejavu \
  && useradd -m -u 1000 -s /bin/sh firefox \
  && mkdir -p /home/firefox/.mozilla/ \
  && mkdir -p /home/firefox/Downloads/ \
  && mkdir -p /home/firefox/.config/pulse \
  && echo "default-server = unix:/run/user/1000/pulse/native" > /home/firefox/.config/pulse/client.conf \
  && echo "autospawn = no" >> /home/firefox/.config/pulse/client.conf \
  && echo "daemon-binary = /bin/true" >> /home/firefox/.config/pulse/client.conf \
  && echo "enable-shm = false" >> /home/firefox/.config/pulse/client.conf \
  && chown -R firefox:firefox /home/firefox/ \
  && rm -rf /var/lib/apt/lists/*

FROM base as runtime
ARG VERSION=126.0
LABEL version=$VERSION
ADD https://download-installer.cdn.mozilla.net/pub/firefox/releases/${VERSION}/linux-x86_64/en-US/firefox-${VERSION}.tar.bz2 firefox.tar.bz2
RUN tar -C /usr/lib/ -xf firefox.tar.bz2 \
  && rm firefox.tar.bz2 \
  && cd /usr/bin \
  && ln -s ../lib/firefox/firefox firefox
USER firefox
WORKDIR /home/firefox
VOLUME ["/home/firefox/.mozilla","/home/firefox/Downloads"]
CMD ["/usr/bin/firefox","--new-instance"]
