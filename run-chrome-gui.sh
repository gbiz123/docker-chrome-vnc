DEBUG_PORT=$1
VNC_PORT=$2

VNC_PASSWORD=hyperaccs

xhost + > /dev/null

# Launch the container detached on X server
# -v /tmp/.X11-unix:/tmp/.X11-unix \
# -e DISPLAY=$DISPLAY \
container_id=$(docker run \
	--rm \
	--detach \
	-it \
	-e DEBUG_PORT=$debug_port \
	-e VNC_PASSWORD=$VNC_PASSWORD \
	-e VNC_PORT=$VNC_PORT \
	--network host \
	chrome-gui)

# Wait for 200 status from json/version
# until curl -I -s http://localhost:$DEBUG_PORT/json/version | grep -q '200 OK' 
# do
#     sleep 0.5
# done;
#
# # Get the websocket debugger URL
# curl -s http://localhost:$DEBUG_PORT/json/version | jq -r '.webSocketDebuggerUrl'
