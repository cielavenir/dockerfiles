docker build -t index.docker.io/cielavenir/qhull:buster           --target qhull     --build-arg BASE=debian:buster-slim qhull_buster
docker build -t index.docker.io/cielavenir/qhull:buster_scipy     --target scipy     --build-arg BASE=debian:buster-slim qhull_buster
docker build -t index.docker.io/cielavenir/qhull:buster_scipy9025 --target scipy9025 --build-arg BASE=debian:buster-slim qhull_buster
