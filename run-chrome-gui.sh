#!/bin/bash
DEBUG_PORT=$1
VNC_PORT=$2

if [ -z $DEBUG_PORT ]; then
	echo "Debug port and VNC port must be passed as positional args and cannot be null";
	exit 1;
fi;

if [ -z $VNC_PORT ]; then
	echo "Debug port and VNC port must be passed as positional args and cannot be null";
	exit 1;
fi;


VNC_PASSWORD=hyperaccs

xhost + > /dev/null

# Launch the container detached on X server
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -e DISPLAY=$DISPLAY \
containerId=$(docker run \
	--rm \
	--detach \
	-it \
	-e DEBUG_PORT=$DEBUG_PORT \
	-e VNC_PASSWORD=$VNC_PASSWORD \
	-e VNC_PORT=$VNC_PORT \
	--network host \
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
