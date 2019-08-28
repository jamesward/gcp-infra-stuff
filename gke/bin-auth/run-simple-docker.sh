export PROJECT_ID=`gcloud config get-value project`
export CONTAINER_PATH=us.gcr.io/$PROJECT_ID/hello-world
docker build -t $CONTAINER_PATH ./
gcloud auth configure-docker --quiet
docker push $CONTAINER_PATH