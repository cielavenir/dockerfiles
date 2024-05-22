ARG BASE=ubuntu:jammy
FROM index.docker.io/library/${BASE}

RUN apt-get update -y && \
    apt-get -y install dirmngr apt-transport-https python3-dev apt-src git devscripts debhelper-compat && \
    echo deb-src http://ftp.archive.ubuntu.com/ubuntu noble main restricted universe multiverse >> /etc/apt/sources.list.d/ubuntu_addition.list && \
    apt-get update -y

RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

RUN apt install -y python3-setuptools dh-python python3-build pybuild-plugin-pyproject python3-setuptools-scm flit && \
    apt install -y python3-typing-extensions cython3 python3-hypothesis

# python3-typing-extensions
RUN apt-src install python-typing-extensions && \
    cd python-typing-extensions-4.9.0 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i python3-typing-extensions_4.9.0-1_all.deb && \
    rm -rf python-typing-extensions-4.9.0

# python3-setuptools
# oh here noble is too new, we need to borrow bullseye-backports
RUN apt install -y wget && \
    wget http://ftp.debian.org/debian/pool/main/s/setuptools/python3-pkg-resources_66.1.1-1~bpo11+1_all.deb && \
    wget http://ftp.debian.org/debian/pool/main/s/setuptools/python3-setuptools_66.1.1-1~bpo11+1_all.deb && \
    dpkg -i python3-pkg-resources_66.1.1-1~bpo11+1_all.deb python3-setuptools_66.1.1-1~bpo11+1_all.deb

# python3-contourpy
RUN apt-src install contourpy && \
    cd contourpy-1.0.7 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i python3-contourpy_1.0.7-1build2_amd64.deb && \
    rm -rf contourpy-1.0.7

# python3-matplotlib
RUN apt install -y gfortran libblas-dev liblapack-dev meson python3-scipy python3-pytest python3-numpy && \
    apt install -y cm-super-minimal dvipng ffmpeg fonts-noto-cjk fonts-wqy-zenhei ghostscript graphviz imagemagick libfreetype6-dev libpng-dev libqhull-dev locales-all python3-cairo python3-cairocffi python3-colorspacious python3-cxx-dev python3-fonttools python3-gi python3-ipywidgets python3-numpydoc python3-pandas python3-pikepdf python3-pil.imagetk python3-pyqt5 python3-tk python3-tornado python3-wxgtk4.0 python3-xarray tcl8.6-dev texlive-base texlive-fonts-recommended texlive-latex-extra texlive-latex-recommended texlive-luatex texlive-science texlive-xetex tk8.6-dev xvfb
RUN git clone https://salsa.debian.org/cielavenir/matplotlib && \
    cd matplotlib && \
    git checkout build3.8.3 && \
    for file in `cat debian/patches/series|sed '/^#/d'`;do patch -p1 <debian/patches/$file;done && \
    debuild -b -uc -us && \
    cd .. && \
    dpkg -i python3-matplotlib_3.8.3-1_amd64.deb python-matplotlib-data_3.8.3-1_all.deb && \
    rm -rf matplotlib && \
    rm -rf /tmp/pytest-of-root
