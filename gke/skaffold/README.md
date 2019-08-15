# Using skaffold on GCP
Skaffold is good for getting rid of the long Cycle of developing with k8s

## Preperation for the Demo
* Install git, and clone this repository 
```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install git
git clone https://github.com/amiteinav/gcp-infra-stuff.git
```
* Optional - to avoid running Docker commands with sudo 
```
sudo groupadd docker
sudo usermod -aG docker $USER
```
* Log out and log back in so that your group membership is re-evaluated 
* Install go (https://golang.org/doc/install)
* set up the Docker credentials for the Google Container Registry
```
gcloud auth configure-docker

sudo curl -fsSL "https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/ \
v${VERSION}/docker-credential-gcr_${OS}_${ARCH}-${VERSION}.tar.gz" \
  | tar xz --to-stdout ./docker-credential-gcr  \
   > /usr/bin/docker-credential-gcr && \
   chmod +x /usr/bin/docker-credential-gcr

docker-credential-gcr configure-docker
```
* Exit after running the command
## the infinite loop
Code change -> run docker build -> run docker push -> patch yaml ->  kubectl apply -> verify -> change code..

* Change directory to skaffold-example
```
cd gke/skaffold/skaffold-example
```

## The development Loop
* Update the code in main.go (change the word 'in' to 'out' or vise versa)
* Test locall using go
```
go run main.go
```
* Build the docker (Dockerfile)
```
docker build . -t gcr.io/`gcloud config get-value project`/anybody:v1
```
* Push the docker to the gcr
```
docker push gcr.io/`gcloud config get-value project`/anybody:v1
```
* Run the docker locally
```
docker run gcr.io/`gcloud config get-value project`/anybody:v1
```
* Deploy in kubernetes (pod.yaml file)
```
kubectl apply -f pod.yaml
```
* Verify 
```
kubectl logs -f hello
```
* Now change the code and start again...

## Now with SKAFFOLD

* Authenticate with container service at google cloud
```
gcloud auth print-access-token | docker login -u oauth2accesstoken --password-stdin https://gcr.io/`gcloud config get-value project`
```
* Install skaffold 
```
https://skaffold.dev/docs/getting-started/#installing-skaffold
```
* Initiate skaffold
```
skaffold init
```
* Build using skaffold
```
skaffold build
```
* Run using skaffold
```
skaffold run 
```
* Run using skaffold tail
```
skaffold run --tail
```
* Run using skaffold dev - this will respond to changes in files immedietly
```
skaffold run dev
```
