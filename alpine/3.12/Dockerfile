FROM alpine:3.12

LABEL maintainer="Carlos Remuzzi <carlosremuzzi@gmail.com>"

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
    && mkdir -p /home/firefox/.mozilla/ \
    && mkdir -p /home/firefox/.config/pulse \
    && chown -R firefox:firefox /home/firefox/

COPY --chown=firefox:firefox client.conf /home/firefox/.config/pulse/client.conf

USER firefox

WORKDIR /home/firefox

VOLUME ["/home/firefox/.mozilla","/home/firefox/Downloads"]

CMD ["firefox"] 
