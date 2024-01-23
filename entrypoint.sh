#!/bin/bash

Xvfb $DISPLAY -ac -listen tcp -screen 0 1920x1080x16 &
sleep 3
/usr/bin/fluxbox -display $DISPLAY -screen 0 &
sleep 3
x11vnc -display $DISPLAY -forever -passwd $VNC_PASSWORD &
sleep 5
google-chrome --no-sandbox \
	--disable-dev-shm-usage \
	--disable-gpu \
	--remote-debugging-port=$DEBUG_PORT \
	--no-default-browser-check
