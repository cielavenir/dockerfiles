ARG BASE=debian:buster-slim
FROM index.docker.io/library/${BASE} as qhull

RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

RUN apt-get update -y && \
    apt-get -y install dirmngr apt-transport-https python3-dev apt-src git devscripts debhelper-compat && \
    echo deb http://ftp.debian.org/debian buster-backports main contrib non-free >> /etc/apt/sources.list.d/debian_addition.list && \
    echo deb-src http://ftp.debian.org/debian bullseye main contrib non-free >> /etc/apt/sources.list.d/debian_addition.list && \
    apt-get update -y

RUN apt-get -y install debhelper/buster-backports

RUN apt-src install qhull && \
    cd qhull-2020.2 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i libqhull-dev_2020.2-3_amd64.deb libqhull8.0_2020.2-3_amd64.deb libqhull-r8.0_2020.2-3_amd64.deb libqhullcpp8.0_2020.2-3_amd64.deb qhull-bin_2020.2-3_amd64.deb

FROM qhull AS scipy
RUN apt-get -y install python3-pip python3-numpy cython3 libblas-dev liblapack-dev gfortran
RUN git clone https://github.com/cielavenir/scipy && \
    cd scipy && \
    git checkout v1.1.0 && \
    python3 setup.py bdist_wheel

RUN mv scipy/dist /
RUN cd scipy && \
    git checkout 1.1.0-externalqhull && \
    python3 setup.py bdist_wheel

FROM scipy AS scipy9025
RUN apt-get -y install wget p7zip-full
RUN wget https://github.com/scipy/scipy/files/2190403/segfault_files.zip && 7z x segfault_files.zip
