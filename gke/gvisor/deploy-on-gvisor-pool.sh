#!/bin/bash

kubectl apply -f sandbox-metadata-test.yaml

kubectl apply -f httpd-no-sandbox.yaml 

kubectl get pod -o jsonpath=$'{range .items[*]}{.metadata.name}: {.spec.nodeName}\n{end}'
