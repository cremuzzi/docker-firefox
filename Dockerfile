FROM alpine:3.9

RUN apk add --no-cache \
        alsa-lib \
        alsa-utils \
        alsaconf \
        dbus \
        ffmpeg-libs \
        firefox-esr \
        ttf-dejavu \
        su-exec \
    && addgroup -g 1000 browser \
    && adduser -u 1000 -G browser -s /bin/sh -D browser \
    && addgroup browser audio \
    && addgroup root audio \
    && mkdir -p /home/browser/.mozilla/ \
    && chown -R browser:browser /home/browser/.mozilla/

COPY entrypoint.sh /usr/local/bin/entrypoint 

WORKDIR /home/browser

VOLUME ["/home/browser/.mozilla"]

ENTRYPOINT ["/usr/local/bin/entrypoint"]

CMD ["firefox"] 
