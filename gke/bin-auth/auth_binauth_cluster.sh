#!/bin/bash

export CLUSTER=binauthz-lab
export PROJECT_ID=`gcloud config get-value project`

gcloud container clusters get-credentials \
     --zone us-central1-a \
     $CLUSTER