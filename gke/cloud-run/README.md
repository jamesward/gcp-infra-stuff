# Cloud Run

## There are actually two kinds
1. CCloud Run as a Managed Service - as a Managed service
2. Cloud Run on your own GKE cluster

## Preperation for the Demo
* Install git, and clone this repository 
```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git
git clone https://github.com/amiteinav/gcp-infra-stuff.git
```

## Cloud Run as a Managed Service
* Let's build an app - the docx-to-pdf service
```
cd gsp-infra-stuff/gke/cloud-run/pdf
```
* Instead of building the image as always, with docker build, and then push to the registry, let's use Tekton!
* Authenticate the GKE cluster
```
bash ../../gke/auth_cluster.sh
```

### Installing tekton
* Check if you should be added as a cluster-admin
```
kubectl describe clusterrolebinding cluster-admin-binding
```
* Set yourself as a cluster-admin
```
kubectl create clusterrolebinding cluster-admin-binding \
--clusterrole=cluster-admin \
--user=$(gcloud config get-value core/account)
```
* Install/update tekton
```
kubectl apply --filename https://storage.googleapis.com/tekton-releases/latest/release.yaml
```
* Check the latest namespace added 
```
kubectl get pods --namespace tekton-pipelines
```

### Building an image (Using Tekton) and pushing to Google Contrainer Registry
* This task has one step that uses the kaniko project to build a docker image from source and push it to a registry.
```
kubectl create -f gcp-infra-stuff/gke/tekton/taskrun.yaml
```

### deploying to Cloud Run
* Since this is a manged service, use the gcloud to deploy 
```
gcloud beta run deploy pdf-tekton-svc \
--image gcr.io/`gcloud config get-value project`/pdf-tekton \
--platform managed \
--region us-central1 \
 --allow-unauthenticated
```
* review the deployment
```
gcloud beta run routes describe pdf-tekton-svc --platform=managed --region us-central1
```


