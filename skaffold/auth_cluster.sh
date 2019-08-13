export PROJECT_ID=`gcloud config get-value project`
export CLUSTER=`gcloud container clusters list --format="value(name)" --filter="name:${PROJECT_ID}-cluster"`
export ZONE=`gcloud container clusters list --format="value(zone)" --filter="name:${PROJECT_ID}-cluster"`

gcloud config set project $PROJECT_ID

echo "running : gcloud container clusters get-credentials $CLUSTER --zone $ZONE "
gcloud container clusters get-credentials $CLUSTER --zone $ZONE 

