#!/bin/bash
DEBUG_PORT=$1
VNC_PORT=$2
DISPLAY=$3

if [ -z $DEBUG_PORT ]; then
	echo "Debug port must be passed as first positional argument (e.g. 9222)"
	exit 1;
fi;

if [ -z $VNC_PORT ]; then
	echo "VNC port must be passed as second positional argument (e.g. 5900)"
	exit 1;
fi;

if [ -z $DISPLAY ]; then
	echo "Display var must be passed as third positional argument (e.g. :99)"
	exit 1;
fi;

# Check if DISPLAY is already in use to avoid multiple vnc servers on a single display (that would be bad)
xvfbProcessCount=$(ps -ef | grep -c "Xvfb $DISPLAY")
if [ "$xvfbProcessCount" -ge 2 ]; then
	echo "There is already an Xvfb process running on display $DISPLAY. Choose a different value for the display positional argument."
	exit 1;
fi;

containerId=$(docker run \
	--rm \
	--detach \
	-it \
	-e DEBUG_PORT=$DEBUG_PORT \
	-e VNC_PORT=$VNC_PORT \
	-e DISPLAY=$DISPLAY \
	--network=host \
	chrome-gui-hyperaccs)

if [ -z $containerId ]; then
	echo "Could not get containerId";
	exit 1;
fi;

# Wait for 200 status from json/version
until curl -I -s http://localhost:$DEBUG_PORT/json/version | grep -q '200 OK' 
do
    sleep 0.5
done;

# Get the websocket debugger URL
wsEndpoint=$(curl -s http://localhost:$DEBUG_PORT/json/version | jq -r '.webSocketDebuggerUrl')

if [ -z $wsEndpoint ]; then
	echo "Could not get wsEndpoint";
	exit 1;
fi;

echo "{\"containerId\":\"$containerId\",\"wsEndpoint\":\"$wsEndpoint\"}"
