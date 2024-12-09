ARG BASE=debian:bullseye-slim
FROM index.docker.io/library/${BASE}

# Install base
RUN apt-get update -y && \
    apt-get -y install dirmngr apt-transport-https python3-dev apt-src git devscripts debhelper-compat && \
    echo deb-src http://ftp.debian.org/debian bookworm main contrib non-free >> /etc/apt/sources.list.d/debian_addition.list && \
    echo deb-src http://ftp.debian.org/debian bookworm-backports main contrib non-free >> /etc/apt/sources.list.d/debian_addition.list && \
    echo deb http://apt.llvm.org/bullseye/ llvm-toolchain-bullseye-15 main >> /etc/apt/sources.list.d/llvm-15.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 15CF4D18AF4F7421 && \
    apt-get update -y

# Install LLVM
RUN apt-get -y install clang-15 llvm-15-dev libclang-15-dev libclang-cpp15-dev libclc-15-dev libclc-15
RUN apt-get -y install cmake

RUN apt-src install pkg-kde-tools && \
    cd pkg-kde-tools-0.15.38 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i pkg-kde-tools_0.15.38_all.deb

RUN apt-src install spirv-headers && \
    cd spirv-headers-1.6.1+1.3.239.0 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i spirv-headers_1.6.1+1.3.239.0-1_all.deb

RUN apt-src install spirv-tools && \
    cd spirv-tools-2023.1 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i spirv-tools_2023.1-2_arm64.deb

RUN apt-src install spirv-llvm-translator-15 && \
    cd spirv-llvm-translator-15-15.0.0 && \
    rm debian/libllvmspirvlib15.symbols && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i libllvmspirvlib15_15.0.0-2_arm64.deb libllvmspirvlib-15-dev_15.0.0-2_arm64.deb

# Install Mesa
RUN apt-get -y install glslang-tools pkgconf libx11-dev libxxf86vm-dev libsensors-dev libxfixes-dev libxext-dev libva-dev libvdpau-dev libvulkan-dev x11proto-dev libx11-xcb-dev libxcb-dri2-0-dev libxcb-glx0-dev libxcb-xfixes0-dev libxcb-dri3-dev libxcb-present-dev libxcb-randr0-dev libxcb-shm0-dev libxcb-sync-dev libxrandr-dev libxshmfence-dev libzstd-dev python3-mako python3-ply python3-yaml python3-setuptools flex bison libelf-dev libwayland-dev libwayland-egl-backend-dev wayland-protocols libglvnd-core-dev valgrind 

# RUN apt-src install meson && \
#     cd meson-1.5.1 && \
#     debuild -uc -us && \
#     cd .. && \
#     dpkg -i meson_1.5.1-1~bpo12+1_all.deb

# meson source package has weird deps. maybe using package directly is better.
RUN apt-get -y install wget ninja-build
RUN wget http://ftp.debian.org/debian/pool/main/m/meson/meson_1.5.1-1~bpo12+1_all.deb && dpkg -i meson_1.5.1-1~bpo12+1_all.deb

RUN apt-src install libdrm && \
    cd libdrm-2.4.123 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i libdrm-common_2.4.123-1~bpo12+1_all.deb libdrm2_2.4.123-1~bpo12+1_arm64.deb libdrm-*_2.4.123-1~bpo12+1_arm64.deb

RUN apt-src install directx-headers && \
    cd directx-headers-1.614.1 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i directx-headers-dev_1.614.1-1~bpo12+1_arm64.deb

RUN apt-src install libvdpau && \
    cd libvdpau-1.5 && \
    DEB_BUILD_OPTIONS=nodoc debuild -uc -us && \
    cd .. && \
    dpkg -i libvdpau1_1.5-2_arm64.deb libvdpau-dev_1.5-2_arm64.deb

RUN apt-src install wayland && \
    cd wayland-1.23.0 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i libwayland-*_1.23.0-1~bpo12+1_arm64.deb

RUN apt-src install wayland-protocols && \
    cd wayland-protocols-1.37 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i wayland-protocols_1.37-1~bpo12+1_all.deb

# Somehow apt.llvm.org's libclc-15 does not provide spirv, copy from Debian bookworm binary
COPY spirv-mesa3d-.spv spirv64-mesa3d-.spv /usr/lib/clc/

RUN apt-src install xtl && \
    cd xtl-0.7.2 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i xtl-dev_0.7.2-2.1_all.deb

RUN apt-src install xtensor && \
    cd xtensor-0.24.3 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i libxtensor-dev_0.24.3-1_arm64.deb

RUN apt-src install flatbuffers && \
    cd flatbuffers-2.0.8+dfsg1 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i libflatbuffers2_2.0.8+dfsg1-2_arm64.deb libflatbuffers-dev_2.0.8+dfsg1-2_arm64.deb flatbuffers-compiler_2.0.8+dfsg1-2_arm64.deb flatbuffers-compiler-dev_2.0.8+dfsg1-2_arm64.deb

RUN apt-src install mesa
RUN cd mesa-24.2.4 && \
    debuild -uc -us && \
    cd ..

# no need to dpkg -i mesa as it is the final product
