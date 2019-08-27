#!/bin/bash

kubectl run hello-server --generator=run-pod/v1 --image gcr.io/google-samples/hello-app:1.0 --port 8080



# to get last messages
kubectl get event --template \
'{{range.items}}{{"\033[0;36m"}}{{.reason}}:{{"\033[0m"}}\{{.message}}{{"\n"}}{{end}}'

