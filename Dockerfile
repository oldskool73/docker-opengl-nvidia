FROM nvidia/cuda:9.0-base
ARG nvidia_version

RUN apt-get update \
    && apt-get install -y \
        x-window-system \
        binutils \
        mesa-utils \
        module-init-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD nvidia-driver.${nvidia_version}.run /tmp/nvidia-driver.run
RUN sh /tmp/nvidia-driver.run -a -N -q --ui=none --no-kernel-module --install-libglvnd \
    && rm /tmp/nvidia-driver.run

CMD /bin/bash
