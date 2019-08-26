#!/bin/bash

set -e

echo "kubectl config use-context secrets-default"
kubectl config use-context secrets-default

kubectl create secret generic demo \
--from-literal username=amiteinav
--from-literal password=s3cr3t