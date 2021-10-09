FROM debian:10-slim as base
LABEL maintainer="Carlos Remuzzi <carlosremuzzi@gmail.com>"
LABEL org.label-schema.description="Dockerized Firefox"
LABEL org.label-schema.name="firefox"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.vcs-url="https://github.com/cremuzzi/docker-firefox"

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
    ttf-dejavu \
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
ARG VERSION=93.0
LABEL version=$VERSION
ADD https://download-installer.cdn.mozilla.net/pub/firefox/releases/${VERSION}/linux-x86_64/en-US/firefox-${VERSION}.tar.bz2 firefox.tar.bz2
RUN tar -C /usr/lib/ -xf firefox.tar.bz2 \
  && rm firefox.tar.bz2 \
  && cd /usr/bin \
  && ln -s ../lib/firefox/firefox firefox
USER firefox
WORKDIR /home/firefox
VOLUME ["/home/firefox/.mozilla","/home/firefox/Downloads"]
CMD ["firefox"]
