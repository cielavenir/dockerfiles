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

# python3-numpy
RUN apt install -y gfortran libblas-dev liblapack-dev python3-all-dev python3-pytest python3-scipy python3-tz cython3 dvisvgm python3-hypothesis
RUN git clone https://salsa.debian.org/python-team/packages/numpy && \
    cd numpy && \
    git checkout debian/1%1.21.5-1 && \
    echo 11 > debian/compat && \
    sed -i '/debhelper-compat/d' debian/control && \
    apt install -y tzdata-legacy || sed -i '/tzdata-legacy/d' debian/control && \
    for file in `cat debian/patches/series`;do patch -p1 <debian/patches/$file;done && \
    sed -i 's/cython3 (>= 0.29.24)/cython3 (>= 0.29.21)/' debian/control && \
    sed -i 's/0.29.24/0.29.21/' pyproject.toml && \
    sed -i 's/0.29.24/0.29.21/' tools/cythonize.py && \
    DEB_BUILD_PROFILES=nodoc DEB_BUILD_OPTIONS=nodoc debuild -b -uc -us && \
    cd .. && \
    dpkg -i python3-numpy_1.21.5-1_amd64.deb && \
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
