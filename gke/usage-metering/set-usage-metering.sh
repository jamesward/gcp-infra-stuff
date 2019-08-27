
#!/bin/bash

export PROJECT_ID=`gcloud config get-value project`
if [ "${1}" == "" ] ; then
	export CLUSTER=`gcloud container clusters list --format="value(name)" --filter="name:${PROJECT_ID}-cluster"`
else
	export CLUSTER=$1
fi

export ZONE=`gcloud container clusters list --format="value(zone)" --filter="name:${CLUSTER}"`
export DATASET_NAME=gke_metering
gcloud container clusters get-credentials $CLUSTER --zone $ZONE 

bash bq_safe_mk.sh ${DATASET_NAME}

echo "gcloud --project ${PROJECT_ID} \
beta container clusters update ${CLUSTER}\
--zone $ZONE \
--resource-usage-bigquery-dataset ${DATASET_NAME} "

time gcloud --project ${PROJECT_ID} \
beta container clusters update ${CLUSTER} \
--zone $ZONE \
--resource-usage-bigquery-dataset ${DATASET_NAME}
