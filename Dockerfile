FROM ubuntu:16.04

RUN apt-get update && apt-get -y install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping libsdl1.2-dev xterm tar locales vi

RUN rm /bin/sh && ln -s bash /bin/sh

RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV USER_NAME sjgarani
ENV PROJECT sjgarani

ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME && useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

USER $USER_NAME

# Create the directory structure for the Yocto build in the container. The lowest two directory
# levels must be the same as on the host.
#ENV BUILD_INPUT_DIR /home/$USER_NAME/yocto/input
#ENV BUILD_OUTPUT_DIR /home/$USER_NAME/yocto/output
#RUN mkdir -p $BUILD_INPUT_DIR $BUILD_OUTPUT_DIR

# Clone the repositories of the meta layers into the directory $BUILD_INPUT_DIR/sources/sjgarani.
#WORKDIR $BUILD_INPUT_DIR
#RUN git clone --recurse-submodules https://github.com/bstubert/$PROJECT.git

# Prepare Yocto's build environment. If TEMPLATECONF is set, the script oe-init-build-env will
# install the customised files bblayers.conf and local.conf. This script initialises the Yocto
# build environment. The bitbake command builds the rootfs for our embedded device.
#WORKDIR $BUILD_OUTPUT_DIR
#ENV TEMPLATECONF=$BUILD_INPUT_DIR/$PROJECT/sources/meta-$PROJECT/custom
#CMD source $BUILD_INPUT_DIR/$PROJECT/sources/poky/oe-init-build-env build \
#    && bitbake $PROJECT-image
