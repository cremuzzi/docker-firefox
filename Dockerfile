FROM alpine:3.9

RUN apk add --no-cache \
        alsa-lib \
        alsa-utils \
        alsaconf \
        dbus \
        ffmpeg-libs \
        firefox-esr \
        ttf-dejavu \
    && addgroup -g 1000 firefox \
    && adduser -u 1000 -G firefox -s /bin/sh -D firefox \
    && mkdir -p /home/firefox/.mozilla/ \
    && chown -R firefox:firefox /home/firefox/.mozilla/

USER firefox

WORKDIR /home/firefox

VOLUME ["/home/firefox/.mozilla","/home/firefox/Downloads"]

CMD ["firefox"] 
