#!/bin/bash

REGISTRY=gcr.io
PROJECT_ID=`gcloud config get-value project`
IMAGE=go-figure

echo "gcloud beta container images describe ${REGISTRY}/${PROJECT_ID}/${IMAGE} --show-package-vulnerability"

gcloud beta container images describe ${REGISTRY}/${PROJECT_ID}/${IMAGE} --show-package-vulnerability
