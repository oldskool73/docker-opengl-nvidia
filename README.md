docker-opengl-nvidia
====================

Builds a Docker image that allows sharing the local X display for graphical
apps on a system that uses the Nvidia proprietary driver. OpenGL and DRI
direct hardware acceleration are supported.

## Usage

### Build image

First you must build the Nvidia image using the build script:

```
./build.sh
```

This will create and tag a `opengl-nvidia` image corresponding to the current host Nvidia driver version.

### Run container

Then you can run the container:

```
./run.sh
```

This will setup the local X Server correctly then launch the container in interactive mode.

You can then launch a X or GL application from the container with e.g.:

```
glxgears
```

This should display the `glxgears` app on the host.

### Creating application containers

If you want to package up an application to run in this way, you should create a `Dockerfile` that extends the `opengl-nvidia` image and `ADD` your app:

```
## Dockerfile.myapp

FROM opengl-nvidia

COPY ./app /app

CMD /app/myapp.x86_64

```

Then build it:

```
 docker build -t opengl-nvidia-myapp -f ./Dockerfile.myapp .
```

Then run it:

```
./run.sh opengl-nvidia-myapp
```

## Notes

.. attention::

  This approach for using graphical applications in Docker is highly
  discouraged. The resulting Docker image will not be portable; it depends
  both on the host graphics device and the graphics driver version. Instead
  the `thewtex/opengl <https://github.com/thewtex/docker-opengl>` Docker image
  is recommended.

  ...Saying that, as long as you are aware of this limitation, the framerate doing it the way this repo does is *much* better!
