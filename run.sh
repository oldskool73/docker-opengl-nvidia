#!/bin/sh

## This will configure the host X server correctly
## then start the container.
##
## Usage:
##
## Start container with interactive shell
## ./run.sh
##
## Start container, run app
## ./run.sh {docker run commands}
##
## Examples:
##
## Run an app built into (a derived) container:
## ./run.sh opengl-nvidia glxgears
##
## Run an app from shared local volume:
## ./run.sh -v ~/path/to/local/app/exe:/app:rw opengl-nvidia /app/exe
##

if test $# -lt 1; then
	# Get the latest opengl-nvidia build
	# and start with an interactive terminal enabled
	args="-i -t $(docker images | grep ^opengl-nvidia | head -n 1 | awk '{ print $1":"$2 }')"
else
    # Use this script with derived images, and pass your 'docker run' args
	args="$@"
fi

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

# allow XServer connections
xhost +

docker run \
	--runtime=nvidia \
	-v $XAUTH:$XAUTH:rw \
	-e DISPLAY=$DISPLAY \
	-e XAUTHORITY=$XAUTH \
	--net=host \
	$args
