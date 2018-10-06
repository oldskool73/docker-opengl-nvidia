FROM nvidia/cuda:9.0-base

RUN apt-get update
RUN apt-get install -y x-window-system
RUN apt-get install -y binutils
RUN apt-get install -y mesa-utils
RUN apt-get install -y module-init-tools

ADD nvidia-driver.run /tmp/nvidia-driver.run
RUN sh /tmp/nvidia-driver.run -a -N -q --ui=none --no-kernel-module --install-libglvnd
RUN rm /tmp/nvidia-driver.run

CMD /bin/bash
