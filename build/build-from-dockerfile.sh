#!/bin/sh

echo "Build server.go"

GOOS=linux CGO_ENABLED=0 go build -a -ldflags="-s -w" ../mg.ru/hello/server/server.go

echo "Build server container using buildah from dockerfile"

buildah bud 

