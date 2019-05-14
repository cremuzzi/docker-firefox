# How to use this image

## start a firefox instance

```sh
docker run --name firefox \
    --network host \
    --shm-size=2g \
    -e DISPLAY=$DISPLAY
    -v $HOME/.Xauthority:/home/firefox/.Xauthority \
    cremuzzi/firefox
```

The flag `--shm-size=2g` sets 2GB as the size of `/dev/shm` available to the container.
By default Docker will set it to 64MB, leading to frequent crashes of Firefox.
Further detail on this issue can be found [here](https://bugzilla.mozilla.org/show_bug.cgi?id=1338771#c10)

## audio support

```sh
docker run --name firefox \
    --network host \
    --shm-size=2g \
    --group-add=29 \
    --device /dev/snd \
    -e DISPLAY=$DISPLAY \
    -v $HOME/alsa.conf:/usr/share/alsa/alsa.conf \
    -v $HOME/.Xauthority:/home/firefox/.Xauthority \
    cremuzzi/firefox
```

The flag `--group-add` is necessary to assign the correct `audio` GID from your specific host to the `firefox` user inside the container.
By default Alpine Linux sets `18` as the audio GID (`audio:x:18:`) but this value is usually different depending on your host Linux distro.
Using `--group-add` allows you to take these differences into account and run your container with the right permissions on `/dev/snd`.

You can find the `audio` GID specific to your host by inspecting the `/etc/group` file.
For instance:

```sh
$(awk -F\: '/audio/{print $3}' /etc/group)
```

Here are some common audio GID values:

* Debian based: `--group-add=29`
* Arch Linux: `--group-add=92`
* CentOS: `--group-add=63`

## start with persistent storage

1. Create a data directory on a suitable volume on your host system, e.g. `/my/own/mozilla` and `/my/own/downloads`

2. Start your `firefox` container like this:

```sh
docker run --name firefox \
    --network host \
    --shm-size=2g \
    --group-add=29 \
    --device /dev/snd \
    -e DISPLAY=$DISPLAY \
    -v $HOME/alsa.conf:/usr/share/alsa/alsa.conf \
    -v $HOME/.Xauthority:/home/firefox/.Xauthority \
    -v /my/own/mozilla:/home/firefox/.mozilla \
    -v /my/own/downloads:/home/firefox/Downloads \
    cremuzzi/firefox
```
