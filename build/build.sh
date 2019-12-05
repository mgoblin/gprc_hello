#!/bin/sh

# Run this script: buildah unshare build.sh

echo "Build server.go"

GOOS=linux CGO_ENABLED=0 go build -a ../mg.ru/hello/server/server.go

echo "Build server container using buildah"

container=$(buildah from scratch)
echo "Create container $container"
mnt=$(buildah mount $container)
echo "Mount container filesystem to $mnt"

buildah copy $container server
buildah config --entrypoint "/server" $container
echo "Try to run"
buildah run $container /server



img=$(buildah commit --squash $container grpc-hello-server)
echo "Create image $img from container"


buildah umount $container > /dev/null


buildah rm $container > /dev/null
buildah rmi $img > /dev/null