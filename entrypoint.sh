#!/usr/bin/env sh

set -e

DEV_SND=/dev/snd

if [ -d "$DEV_SND" ]; then
  chown -R root:audio $DEV_SND
fi

su-exec browser "$@"
