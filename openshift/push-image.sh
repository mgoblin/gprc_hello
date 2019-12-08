#!/bin/sh

echo "Push image from local file system container storage to openshift image registry"

set -e

if [ "$1" == "" ]; then
  echo "You should get imageid"
  exit 1
fi

img=$1


oc login -u kubeadmin -p UMeRe-hBQAi-JJ4Bi-8ynRD
oc project grpc-hello-server
host=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
podman login -u kubadmin -p $(oc whoami -t) --tls-verify=false $host

echo "Pushing $img to image registry $host"