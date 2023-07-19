#!/bin/sh
# one-liner to use mpv to as a webcam viewer
mpv av://v4l2:/dev/video0 --profile=low-latency --untimed
