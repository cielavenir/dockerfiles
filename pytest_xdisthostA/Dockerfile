FROM index.docker.io/library/debian:stretch
RUN apt-get update && apt-get -y install nfs-common git gettext locales python-pip
RUN sed -i 's/# en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen --purge en_US.UTF-8 && update-locale LANG=en_US.UTF-8
RUN python -m pip install requests ujson pathlib2 zmq numpy pytest==4.6.11 pytest-xdist==1.29.0 weakrefmethod pytz tzlocal python-dateutil logutils flake8==3.6.0
