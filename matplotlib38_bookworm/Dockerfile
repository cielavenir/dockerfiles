ARG BASE=debian:bookworm-slim
FROM index.docker.io/library/${BASE}

RUN apt-get update -y && \
    apt-get -y install dirmngr apt-transport-https python3-dev apt-src git devscripts debhelper-compat && \
    apt-get update -y

RUN apt install -y python3-setuptools dh-python python3-build pybuild-plugin-pyproject python3-setuptools-scm flit && \
    apt install -y python3-typing-extensions python3-contourpy python3-flit-scm cython3 python3-exceptiongroup python3-hypothesis

# python3-matplotlib
RUN apt install -y gfortran libblas-dev liblapack-dev meson python3-all-dev python3-pytest python3-scipy python3-tz python3-numpy && \
    apt install -y cm-super-minimal dvipng ffmpeg fonts-noto-cjk fonts-wqy-zenhei ghostscript graphviz imagemagick libfreetype6-dev libpng-dev libqhull-dev locales-all python3-cairo python3-cairocffi python3-colorspacious python3-cxx-dev python3-cycler python3-fonttools python3-gi python3-ipywidgets python3-kiwisolver python3-numpydoc python3-pandas python3-pikepdf python3-pil.imagetk python3-pyparsing python3-pyqt5 python3-tk python3-tornado python3-wxgtk4.0 python3-xarray tcl8.6-dev texlive-base texlive-fonts-recommended texlive-latex-extra texlive-latex-recommended texlive-luatex texlive-science texlive-xetex tk8.6-dev xvfb python3-pybind11
RUN git clone https://salsa.debian.org/cielavenir/matplotlib && \
    cd matplotlib && \
    git checkout build3.8.3 && \
    for file in `cat debian/patches/series|sed '/^#/d'`;do patch -p1 <debian/patches/$file;done && \
    debuild -b -uc -us && \
    cd .. && \
    dpkg -i python3-matplotlib_3.8.3-1_amd64.deb python-matplotlib-data_3.8.3-1_all.deb && \
    rm -rf matplotlib && \
    rm -rf /tmp/pytest-of-root
