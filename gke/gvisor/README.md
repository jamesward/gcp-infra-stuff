# gVisor Demo

## Preperation for the Demo
* Install git, and clone this repository 
```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git
git clone https://github.com/amiteinav/gcp-infra-stuff.git
```

## Deploying on a gVisor node-pool
* Authenticate the cluster
```
bash auth_cluster.sh
```
* Create a new nodepool for gVisor (if not exists already) [takes around 80 seconds]
```

export NODE_POOL_NAME=gvisor-pool
export PROJECT_ID=`gcloud config get-value project`
export CLUSTER=`gcloud container clusters list --format="value(name)" --filter="name:${PROJECT_ID}-cluster"`
export ZONE=`gcloud container clusters list --format="value(zone)" --filter="name:${PROJECT_ID}-cluster"`

gcloud beta container node-pools create ${NODE_POOL_NAME} \
  --cluster=${CLUSTER} \
  --image-type=cos_containerd \
  --sandbox type=gvisor \
  --enable-autoupgrade \
  --num-nodes=2 \
  --machine-type=n1-standard-1 \
  --zone ${ZONE}
```
* Check if the gvisor-admission-webhook-config webhook configuration and the gvisor RuntimeClass are created
```
kubectl get mutatingwebhookconfiguration gvisor-admission-webhook-config
kubectl get runtimeclass gvisor
```
* Create deployment
```
kubectl create -f httpd.yaml
```
* List the pod
```
kubectl get pods
```
* Find the name of the Pod in the output, then run the following command to check its value for RuntimeClass
```
export POD_NAME=`kubectl get pods --output="name" | grep httpd | grep -v "no-sandbox"`
echo $POD_NAME
kubectl get $POD_NAME -o jsonpath='{.spec.runtimeClassName}'
```
* List Athe RuntimeClass of each Pod
```
kubectl get pods -o jsonpath=$'{range .items[*]}{.metadata.name}: {.spec.runtimeClassName}\n{end}'
```
* Apply a deployment of a non-gvisor pod on a gvisor node
```
kubectl apply -f httpd-no-sandbox.yaml 
```
* verify that the Deployment is not running in a sandbox
```
kubectl get pods -o jsonpath=$'{range .items[*]}{.metadata.name}: {.spec.runtimeClassName}\n{end}'
```
* Verify that the non-sandboxed Deployment is running on a node with GKE Sandbox 
```
kubectl get pod -o jsonpath=$'{range .items[*]}{.metadata.name}: {.spec.nodeName}\n{end}'
```

## Test gVisor effectiveness 
* Apply a deployment of a gvisor pod
```
kubectl apply -f sandbox-metadata-test.yaml
```
* Connect to the Pod interactively
```
export POD_NAME=`kubectl get pods --output="name" | grep fedora`
kubectl exec -it $POD_NAME /bin/sh
```
* Within the interactive session, attempt to access a URL that returns cluster metadata
```
curl -s "http://metadata.google.internal/computeMetadata/v1/instance/attributes/kube-env" -H "Metadata-Flavor: Google"
```
* remove the runtmie class from the sandbox-metadata-test.yaml file and apply the file again

* log into the pod and check access to metadata again
