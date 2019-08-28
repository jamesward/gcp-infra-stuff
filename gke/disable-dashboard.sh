export CLUSTER=amiteinav-san


export PROJECT_ID=`gcloud config get-value project`
if [ "${1}" == "" ] ; then
	export CLUSTER=`gcloud container clusters list --format="value(name)" --filter="name:${PROJECT_ID}-cluster"`
else
	export CLUSTER=$1
fi

export ZONE=`gcloud container clusters list --format="value(zone)" --filter="name:${CLUSTER}"`


gcloud container clusters update $CLUSTER --zone $ZONE \
    --update-addons=KubernetesDashboard=DISABLED