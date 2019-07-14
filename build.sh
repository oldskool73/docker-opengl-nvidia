#!/bin/sh

## This will build a docker image from the local ./Dockerfile
## With nvidia drivers installed matching the current host version
## And tag it with the driver version number

# Get your current host nvidia driver version, e.g. 390.48
nvidia_version=$(cat /proc/driver/nvidia/version | head -n 1 | awk '{ print $8 }')

# We must use the same driver in the image as on the host
if test ! -f nvidia-driver.${nvidia_version}.run; then
  nvidia_driver_uri=http://us.download.nvidia.com/XFree86/Linux-x86_64/${nvidia_version}/NVIDIA-Linux-x86_64-${nvidia_version}.run
  wget -O nvidia-driver.${nvidia_version}.run ${nvidia_driver_uri}
fi

docker build --build-arg nvidia_version=${nvidia_version} -t opengl-nvidia:${nvidia_version} .
docker tag opengl-nvidia:${nvidia_version} opengl-nvidia:latest
