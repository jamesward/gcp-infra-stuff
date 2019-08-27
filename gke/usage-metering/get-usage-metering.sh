#!/bin/bash

export PROJECT_ID=`gcloud config get-value project`
if [ "${1}" == "" ] ; then
	export CLUSTER=`gcloud container clusters list --format="value(name)" --filter="name:${PROJECT_ID}-cluster"`
else
	export CLUSTER=$1
fi

export ZONE=`gcloud container clusters list --format="value(zone)" --filter="name:${CLUSTER}"`
gcloud container clusters get-credentials $CLUSTER --zone $ZONE 

gcloud --project ${PROJECT_ID} \
	beta container clusters describe ${CLUSTER} --zone ${ZONE} \
       	--format="value(resourceUsageExportConfig)"
