ARG BASE=debian:jammy-slim
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

# cython3
RUN apt-src install cython && \
    cd cython-3.0.8 && \
    debuild -uc -us && \
    cd .. && \
    sudo dpkg -i cython3_3.0.8-1ubuntu1_amd64.deb && \
    rm -rf cython-3.0.8

# python3-numpy
RUN apt install -y gfortran libblas-dev liblapack-dev meson python3-scipy python3-pytest
RUN git clone https://salsa.debian.org/python-team/packages/numpy && \
    cd numpy && \
    git checkout debian/1%1.26.3-1 && \
    echo 11 > debian/compat && \
    sed -i '/debhelper-compat/d' debian/control && \
    apt install -y tzdata-legacy || sed -i '/tzdata-legacy/d' debian/control && \
    for file in `cat debian/patches/series`;do patch -p1 <debian/patches/$file;done && \
    debuild -b -uc -us && \
    cd .. && \
    dpkg -i python3-numpy_1.26.3-1_amd64.deb && \
    rm -rf numpy && \
    rm -rf /tmp/pytest-of-root

# python3-matplotlib
RUN apt install -y cm-super-minimal dvipng ffmpeg fonts-noto-cjk fonts-wqy-zenhei ghostscript graphviz imagemagick libfreetype6-dev libpng-dev libqhull-dev locales-all python3-cairo python3-cairocffi python3-colorspacious python3-cxx-dev python3-fonttools python3-gi python3-ipywidgets python3-numpydoc python3-pandas python3-pikepdf python3-pil.imagetk python3-pyqt5 python3-tk python3-tornado python3-wxgtk4.0 python3-xarray tcl8.6-dev texlive-base texlive-fonts-recommended texlive-latex-extra texlive-latex-recommended texlive-luatex texlive-science texlive-xetex tk8.6-dev xvfb
RUN git clone https://salsa.debian.org/cielavenir/matplotlib && \
    cd matplotlib && \
    git checkout build3.8.3 && \
    for file in `cat debian/patches/series|sed '/^#/d'`;do patch -p1 <debian/patches/$file;done && \
    debuild -b -uc -us && \
    cd .. && \
    dpkg -i python3-matplotlib_3.8.3-1_amd64.deb python-matplotlib-data_3.8.3-1_all.deb && \
    rm -rf matplotlib && \
    rm -rf /tmp/pytest-of-root
