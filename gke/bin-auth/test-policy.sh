#!/bin/bash

IMAGE_PATH="gcr.io/google-samples/hello-app"
IMAGE_DIGEST="sha256:c62ead5b8c15c231f9e786250b07909daf6c266d0fcddd93fea882eb722c3be4"

#kubectl run hello-server --generator=run-pod/v1 --image gcr.io/google-samples/hello-app:1.0 --port 8080

kubectl run hello-server --generator=run-pod/v1 --image ${IMAGE_PATH}@${IMAGE_DIGEST} --port 8080

# to get last messages
kubectl get event --template \
'{{range.items}}{{"\033[0;36m"}}{{.reason}}:{{"\033[0m"}}\{{.message}}{{"\n"}}{{end}}'

