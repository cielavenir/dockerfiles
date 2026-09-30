## openrave

With ones with viewer support, you can invoke

```
docker run -it --rm --env DISPLAY --device /dev/dri --volume /tmp/.X11-unix:/tmp/.X11-unix docker.io/cielavenir/openrave:focal openrave.py -i
```

### Features

|Debian/Ubuntu|Codename|Python|Viewer|
|:--|:--|:--|:--|
|Debian 9|stretch|2|x|
|Ubuntu 18|bionic|2|x|
|Debian 10|buster|2|x|
|Ubuntu 20|focal|2|o|
|Debian 11|bullseye|2/3|x|
|Ubuntu 22|jammy|2/3|o|
|Debian 12|bookworm|3|o|
|Ubuntu 24|noble|3|o|
|Debian 13|trixie|3|o|
|Ubuntu 26|resolute|3|o|

### Image IDs

```
$ pulldockerimage.py index.docker.io/cielavenir/openrave
```

```
bionic
bookworm
bullseye
bullseye-python2
buster
focal
jammy
jammy-python2
noble
resolute
stretch
trixie
```
