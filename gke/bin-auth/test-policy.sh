#!/bin/bash

kubectl run hello-server --image gcr.io/google-samples/hello-app:1.0 --port 8080

sleep 2

kubectl get pods | grep hello-server

sleep 2

kubectl get event --template \
'{{range.items}}{{"\033[0;36m"}}{{.reason}}:{{"\033[0m"}}\{{.message}}{{"\n"}}{{end}}'

sleep 2

kubectl delete deployment hello-server

