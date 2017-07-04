# Building: docker build -t zephyr .
# Running:  docker run -v $PWD:/zephyr -ti zephyr
# Debug:    docker run -v $PWD:/zephyr -ti --entrypoint="/bin/bash" zephyr

FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y wget git make gcc g++ python3-ply ncurses-dev python3-yaml dfu-util device-tree-compiler xz-utils
RUN wget https://github.com/zephyrproject-rtos/meta-zephyr-sdk/releases/download/0.9.1/zephyr-sdk-0.9.1-setup.run
RUN chmod +x zephyr-sdk-0.9.1-setup.run
RUN ./zephyr-sdk-0.9.1-setup.run --quiet --target /opt/zephyr-sdk/
ENV ZEPHYR_GCC_VARIANT=zephyr
ENV ZEPHYR_SDK_INSTALL_DIR=/opt/zephyr-sdk/
WORKDIR /zephyr
ENTRYPOINT ["/bin/bash", "-c", "source zephyr-env.sh && make -C samples/synchronization BOARD=qemu_x86 run"]
