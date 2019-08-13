#!/bin/bash

export PROJECT_ID=`gcloud config get-value project`
export INSTANCE_NAME=$1
export IMAGE=$2
export IMAGE_PROJECT=$3


# Create VM
gcloud beta compute --project=$PROJECT_ID instances create $INSTANCE_NAME \
--zone=europe-west1-b \
--machine-type=n1-standard-1 \
--subnet=privatenet-eu --no-address \
--image=$IMAGE --image-project=$IMAGE_PROJECT  

