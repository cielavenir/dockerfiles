docker build -t index.docker.io/cielavenir/qhull:focal           --target qhull     --build-arg BASE=ubuntu:focal qhull_focal
docker build -t index.docker.io/cielavenir/qhull:focal_scipy     --target scipy     --build-arg BASE=ubuntu:focal qhull_focal
docker build -t index.docker.io/cielavenir/qhull:focal_scipy9025 --target scipy9025 --build-arg BASE=ubuntu:focal qhull_focal
