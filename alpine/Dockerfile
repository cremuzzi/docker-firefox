FROM alpine:3.15

LABEL org.opencontainers.image.authors="Carlos Remuzzi <carlosremuzzi@gmail.com>"
LABEL org.opencontainers.image.description="Containerized Firefox based on alpine linux"
LABEL org.opencontainers.image.title="firefox"
LABEL org.opencontainers.image.source="https://github.com/cremuzzi/docker-firefox"

RUN apk add --no-cache \
    dbus \
    ffmpeg-libs \
    firefox \
    mesa-demos \
    mesa-dri-intel \
    pulseaudio \
    ttf-dejavu \
    tzdata \
  && adduser -u 1000 -D firefox \
  && mkdir -p /home/firefox/.config/pulse \
  && mkdir -p /home/firefox/.mozilla/ \
  && mkdir -p /home/firefox/Downloads/ \
  && echo "default-server = unix:/run/user/1000/pulse/native" > /home/firefox/.config/pulse/client.conf \
  && echo "autospawn = no" >> /home/firefox/.config/pulse/client.conf \
  && echo "daemon-binary = /bin/true" >> /home/firefox/.config/pulse/client.conf \
  && echo "enable-shm = false" >> /home/firefox/.config/pulse/client.conf \
  && chown -R firefox:firefox /home/firefox

USER firefox

WORKDIR /home/firefox

VOLUME ["/home/firefox/.mozilla","/home/firefox/Downloads"]

CMD ["firefox"]
