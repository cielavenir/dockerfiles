ARG BASE=debian:bullseye-slim
FROM index.docker.io/library/${BASE}

RUN apt-get update -y && \
    apt-get -y install dirmngr gnupg apt-transport-https liblog4cxx-dev libopenscenegraph-dev python2-dev python-setuptools python3-dev python3-setuptools python3-pip python3-nose libcoin-dev libsoqt520-dev && \
    apt-get -y install g++ gfortran git pkg-config debhelper gettext zlib1g-dev libminizip-dev libxml2-dev liburiparser-dev libpcre3-dev libgmp-dev libmpfr-dev qtbase5-dev libqt5opengl5-dev libavcodec-dev libavformat-dev libswscale-dev libsimage-dev libode-dev libqhull-dev libann-dev libhdf5-serial-dev liblapack-dev libboost-iostreams-dev libboost-regex-dev libboost-filesystem-dev libboost-system-dev libboost-thread-dev libboost-date-time-dev libboost-test-dev libmpfi-dev ffmpeg libtinyxml-dev libflann-dev sqlite3 libccd-dev libeigen3-dev libgpgme-dev libgpgmepp-dev && \
    apt-get update -y && apt-get -y install cmake-data cmake cmake-curses-gui python3-coverage python3-opengl python3-six ninja-build silversearcher-ag

RUN python2 -m easy_install pip~=20.0 && python2 -m pip install pyopengl numpy==1.16.5 sympy==0.7.1 IPython==5.10.0 && python2 -m pip install scipy==1.2.3
RUN python3 -m pip install numpy==1.21.5 IPython==7.31.1 && python3 -m pip install https://github.com/cielavenir/sympy/releases/download/0.7.1-py3/sympy-0.7.1-py3.tar.gz && python3 -m pip install scipy==1.7.3

RUN git clone https://github.com/bulletphysics/bullet3.git && mkdir bullet3/build && \
    cd bullet3/build && \
    git checkout 2.82 && \
    cmake .. -GNinja -DINSTALL_LIBS=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC && \
    ninja -j4 && ninja install && \
    cd ../.. && rm -rf bullet3

# Use openrave/3rdparty collada-dom
# RUN git clone https://github.com/rdiankov/collada-dom.git && mkdir collada-dom/build && \
#     cd collada-dom/build && \
#     cmake .. -GNinja && \
#     ninja -j4 && ninja install && \
#     cd ../.. && rm -rf collada-dom

# There are no stable version available
RUN git clone https://github.com/Tencent/rapidjson.git && mkdir rapidjson/build && \
    cd rapidjson/build && \
    cmake .. -GNinja -DRAPIDJSON_HAS_STDSTRING=ON -DRAPIDJSON_BUILD_DOC=OFF -DRAPIDJSON_BUILD_EXAMPLES=OFF -DRAPIDJSON_BUILD_TESTS=OFF && \
    ninja -j4 && ninja install && \
    cd ../.. && rm -rf rapidjson

RUN git clone https://github.com/assimp/assimp.git && mkdir assimp/build && \
    cd assimp/build && \
    git checkout v5.2.5 && \
    cmake .. -GNinja && \
    ninja -j4 && ninja install && \
    cd ../.. && rm -rf assimp

RUN git clone https://github.com/rdiankov/fcl.git && mkdir fcl/build && \
    cd fcl/build && \
    git checkout origin/trimeshContactPoints20200813 && \
    cmake .. -GNinja -DFCL_BUILD_TESTS=OFF && \
    ninja -j4 && ninja install && \
    cd ../.. && rm -rf fcl

RUN git clone https://github.com/pybind/pybind11.git && mkdir pybind11/build && \
    cd pybind11/build && \
    git remote add woody https://github.com/woodychow/pybind11.git && \
    git fetch woody && \
    git remote add ciel https://github.com/cielavenir/pybind11.git && \
    git fetch ciel && \
    git checkout ciel/v2.9_ty && \
    cmake .. -GNinja -DPYBIND11_TEST=OFF -DPythonLibsNew_FIND_VERSION=2 && \
    ninja -j4 && ninja install && \
    cd ../.. && rm -rf pybind11

# RUN git clone https://github.com/pybind/pybind11.git && mkdir pybind11/build && \
#     cd pybind11/build && \
#     git checkout v2.9.2 && \
#     cmake .. -GNinja -DPYBIND11_TEST=OFF -DPythonLibsNew_FIND_VERSION=2 && \
#     ninja -j4 && ninja install && \
#     cd ../.. && rm -rf pybind11

RUN git clone https://github.com/msgpack/msgpack-c && mkdir msgpack-c/build && \
    cd msgpack-c/build && \
    git checkout cpp-6.0.0 && \
    cmake .. -GNinja -DMSGPACK_BUILD_EXAMPLES=OFF -DMSGPACK_BUILD_TESTS=OFF && \
    ninja -j4 && ninja install && \
    cd ../.. && rm -rf msgpack-c

RUN git clone https://github.com/rdiankov/openrave.git && mkdir openrave/build && \
    cd openrave/build && \
    git config --local user.email 'dockerfile@vagrant.example.com' && \
    git config --local user.name 'dockerfile' && \
    git checkout origin/production && \
    git cherry-pick cb96ec7318af7753e947a333dafe49bf6cacef01 && \
    git cherry-pick 53b90e081139a8d9c903d2e702322ba97a8bc494 && \
    git cherry-pick bb7e3d83f1bb6e93692f9557c205a7307c4beeb6 && \
    git cherry-pick 4828cebfbcefb1941e6715aef32f54008ed30f8c && \
    FLAG_CMAKE_CXX_STANDARD="" && \
    if grep '^Ubuntu J' /etc/issue >/dev/null || grep '^Ubuntu 22' /etc/issue >/dev/null || grep '^Debian GNU/Linux 12' /etc/issue >/dev/null || grep '^Debian GNU/Linux bookworm' /etc/issue >/dev/null; then \
      FLAG_CMAKE_CXX_STANDARD="-DCMAKE_CXX_STANDARD=17"; \
    fi && \
    cmake .. -GNinja -DUSE_PYBIND11_PYTHON_BINDINGS=ON ${FLAG_CMAKE_CXX_STANDARD} && \
    ninja -j4 && ninja install && \
    cd ../.. && rm -rf openrave

# https://bugs.launchpad.net/ubuntu/+source/python3-stdlib-extensions/+bug/1832215
RUN for ver in 3.8 3.9 3.10 3.11 3.12 3.13; do \
      if [ -d /usr/local/lib/python${ver} ] && [ ! -d /usr/local/lib/python${ver}/dist-packages/openravepy ]; then \
        ln -s /usr/local/lib/python3/dist-packages/openravepy /usr/local/lib/python${ver}/dist-packages/openravepy; \
        ln -s /usr/local/lib/python3/dist-packages/sympy /usr/local/lib/python${ver}/dist-packages/sympy; \
      fi; \
    done

# somehow this is required to load plugins properly
ENV OPENRAVE_PLUGINS=

RUN apt-get update -y && apt-get install -y python-is-python3
