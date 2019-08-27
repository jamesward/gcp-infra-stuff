#!/bin/bash

#enable the API
gcloud services enable binaryauthorization.googleapis.com


export PROJECT_ID=`gcloud config get-value project`
if [ "${1}" == "" ] ; then
	export CLUSTER=`gcloud container clusters list --format="value(name)" --filter="name:${PROJECT_ID}-cluster"`
else
	export CLUSTER=$1
fi

export ZONE=`gcloud container clusters list --format="value(zone)" --filter="name:${CLUSTER}"`

#update the cluster to use Binary Authorization
gcloud beta container clusters update $CLUSTER \
--enable-binauthz \
--zone $ZONE \

