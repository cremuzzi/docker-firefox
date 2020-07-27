# How to use this image

## Start a Firefox instance

```sh
docker run \
    --network host \
    --shm-size=2g \
    -e DISPLAY \
    -v $HOME/.Xauthority:/home/firefox/.Xauthority:ro \
    cremuzzi/firefox
```

The flag `--shm-size=2g` sets 2GB as the size of `/dev/shm` available to the container.
By default Docker will set it to 64MB, leading to frequent crashes of Firefox.
Further detail on this issue can be found [here](https://bugzilla.mozilla.org/show_bug.cgi?id=1338771#c10)

## Audio support with Pulseaudio

Since tag `78.0.2-buster` we switched from alsa to **pulseaudio** for better and simpler audio support.
The container will just act as a client to your host's pulseaudio server.
Just run a container with the additional volume `/run/user/1000/pulse` like this:

```sh
docker run \
    --network host \
    --shm-size=2g \
    -e DISPLAY \
    -v $HOME/.Xauthority:/home/firefox/.Xauthority:ro \
    -v /run/user/1000/pulse:/run/user/1000/pulse:ro \
    cremuzzi/firefox
```

## Hardware acceleration with mesa

Since tag `firefox:68.8.0` we enabled mesa drivers for intel graphics cards, **mesa-dri-intel**.
This solves the WebGL issue from the previous versions of this image.

To enable hardware acceleration in your dockerized firefox just share /dev/dri with your container with the `--device /dev/dri` run option.

## Start with persistent storage

1. Create a data directory on a suitable volume on your host system, e.g. `/my/own/mozilla` and `/my/own/downloads`

2. Start your `firefox` container like this:

```sh
docker run \
    --network host \
    --shm-size=2g \
    -e DISPLAY \
    -v $HOME/.Xauthority:/home/firefox/.Xauthority:ro \
    -v /run/user/1000/pulse:/run/user/1000/pulse:ro \
    -v /my/own/downloads:/home/firefox/Downloads \
    -v /my/own/mozilla:/home/firefox/.mozilla \
    cremuzzi/firefox
```
