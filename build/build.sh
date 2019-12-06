#!/bin/sh

# Run this script: buildah unshare build.sh

echo "Build server.go"

GOOS=linux CGO_ENABLED=0 go build -a -ldflags="-s -w" ../mg.ru/hello/server/server.go

echo "Build server container using ./buildah"

container=$(buildah from scratch)
echo "Create container $container"
mnt=$(buildah mount $container)
echo "Mount container filesystem to $mnt"

buildah copy $container server /
buildah config --entrypoint "/server" $container
buildah config --port 10000 $container
buildah umount $container 


img=$(buildah commit --squash --rm $container grpc-hello-server)
echo "Create image $img from container"
