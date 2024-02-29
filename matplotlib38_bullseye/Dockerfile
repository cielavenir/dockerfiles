ARG BASE=debian:bullseye-slim
FROM index.docker.io/library/${BASE}

RUN apt-get update -y && \
    apt-get -y install dirmngr apt-transport-https python3-dev apt-src git devscripts debhelper-compat && \
    echo deb http://ftp.debian.org/debian bullseye-backports main contrib non-free >> /etc/apt/sources.list.d/debian_addition.list && \
    echo deb-src http://ftp.debian.org/debian bookworm main contrib non-free >> /etc/apt/sources.list.d/debian_addition.list && \
    apt-get update -y

RUN apt install -y python3-setuptools/bullseye-backports dh-python/bullseye-backports python3-build/bullseye-backports pybuild-plugin-pyproject/bullseye-backports python3-setuptools-scm/bullseye-backports flit/bullseye-backports

# python3-typing-extensions
RUN apt-src install python-typing-extensions && \
    cd python-typing-extensions-4.4.0 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i python3-typing-extensions_4.4.0-1_all.deb && \
    rm -rf python-typing-extensions-4.4.0

# python3-contourpy
RUN apt-src install contourpy && \
    cd contourpy-1.0.7 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i python3-contourpy_1.0.7-1_amd64.deb && \
    rm -rf contourpy-1.0.7

# python3-flit-scm
RUN apt-src install flit-scm && \
    cd flit-scm-1.6.2 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i python3-flit-scm_1.6.2-1_all.deb && \
    rm -rf flit-scm-1.6.2

# cython3
RUN apt-src install cython && \
    cd cython-0.29.32 && \
    debuild -uc -us && \
    cd .. && \
    sudo dpkg -i cython3_0.29.32-2_amd64.deb && \
    rm -rf cython-0.29.32

# python3-exceptiongroup
RUN apt-src install python-exceptiongroup && \
    cd python-exceptiongroup-1.1.0 && \
    debuild -uc -us && \
    cd .. && \
    dpkg -i python3-exceptiongroup_1.1.0-1_all.deb && \
    rm -rf python-exceptiongroup-1.1.0

# python3-hypothesis
RUN apt-src install python-hypothesis && \
    cd python-hypothesis-6.67.1 && \
    DEB_BUILD_OPTIONS=nocheck debuild -uc -us && \
    cd .. && \
    dpkg -i python3-hypothesis_6.67.1-1_all.deb && \
    rm -rf python-hypothesis-6.67.1

# python3-numpy
RUN apt install -y gfortran libblas-dev liblapack-dev meson python3-scipy
RUN git clone https://salsa.debian.org/python-team/packages/numpy && \
    cd numpy && \
    git checkout debian/1%1.26.3-1 && \
    apt install -y tzdata-legacy || sed -i '/tzdata-legacy/d' debian/control && \
    for file in `cat debian/patches/series`;do patch -p1 <debian/patches/$file;done && \
    debuild -b -uc -us && \
    cd .. && \
    dpkg -i python3-numpy_1.26.3-1_amd64.deb && \
    rm -rf numpy && \
    rm -rf /tmp/pytest-of-root

# python3-matplotlib
RUN apt install -y cm-super-minimal dvipng ffmpeg fonts-noto-cjk fonts-wqy-zenhei ghostscript graphviz imagemagick libfreetype6-dev libpng-dev libqhull-dev locales-all python3-cairo python3-cairocffi python3-colorspacious python3-cxx-dev python3-fonttools python3-gi python3-ipywidgets python3-numpydoc python3-pandas python3-pikepdf python3-pil.imagetk python3-pyqt5 python3-tk python3-tornado python3-wxgtk4.0 python3-xarray tcl8.6-dev texlive-base texlive-fonts-recommended texlive-latex-extra texlive-latex-recommended texlive-luatex texlive-science texlive-xetex tk8.6-dev xvfb
# python3-importlib-resources is required additionally for Python3.9
RUN apt install -y python3-importlib-resources
RUN git clone https://salsa.debian.org/cielavenir/matplotlib && \
    cd matplotlib && \
    git checkout build3.8.3 && \
    for file in `cat debian/patches/series|sed '/^#/d'`;do patch -p1 <debian/patches/$file;done && \
    debuild -b -uc -us && \
    cd .. && \
    dpkg -i python3-matplotlib_3.8.3-1_amd64.deb python-matplotlib-data_3.8.3-1_all.deb && \
    rm -rf matplotlib && \
    rm -rf /tmp/pytest-of-root
