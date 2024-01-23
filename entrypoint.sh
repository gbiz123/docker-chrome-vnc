#!/bin/bash

Xvfb $DISPLAY -ac -listen tcp -screen 0 1920x1080x16 &
while ! pgrep "Xvfb" > /dev/null; do
    sleep .1
done

/usr/bin/fluxbox -display $DISPLAY -screen 0 &
while ! pgrep "fluxbox" > /dev/null; do
    sleep .1
done

x11vnc -display $DISPLAY -forever -passwd $VNC_PASSWORD &
while ! pgrep "x11vnc" > /dev/null; do
    sleep .1
done

google-chrome --no-sandbox \
	--disable-dev-shm-usage \
	--disable-gpu \
	--remote-debugging-port=$DEBUG_PORT \
	--no-default-browser-check
