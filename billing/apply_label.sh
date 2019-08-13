#!/bin/bash

PROJECT=`gcloud config get-value project`

if [ "${1}" != "" ] ; then
	export PROJECT=${1}
fi

export instances=`gcloud compute instances list --project=$PROJECT`
skip_rows=4

for instance in $instances ; do
	if [ $skip_rows -gt 0] ; then
	echo $instance
	fi
done