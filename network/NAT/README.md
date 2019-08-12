# NAT on a GKE

## What are we going to do?
Configure a Cloud NAT with Google Kubernetes Engine. 

NOTE: You must create the Cloud Router in the same region as the instances that use Cloud NAT. This configuration allows all instances in the region to use Cloud NAT for all primary and alias IP ranges.

### Create a Private Cluster
* Create a private VPC
```
export PROJECT_ID=`gcloud config get-value project`

gcloud compute --project=$PROJECT_ID networks create gkeprivatenet --subnet-mode=custom

gcloud beta compute --project=${PROJECT_ID} networks subnets create gkeprivatenet-us --network=gkeprivatenet --region=us-central1 --range=192.168.1.0/24 --enable-flow-logs
```
* Create a bastion host
```
gcloud beta compute --project=$PROJECT_ID instances create gke-vm-bastion --zone=us-central1-c --machine-type=g1-small --subnet=gkeprivatenet-us  --maintenance-policy=MIGRATE --scopes=https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.read_only  --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=gke-vm-bastion    --image-family debian-9  --image-project debian-cloud 
```
* Create a FW for SSH
```
gcloud beta compute --project=$PROJECT_ID firewall-rules create gkeprivatenet-allow-ssh --direction=INGRESS --priority=900 --network=gkeprivatenet --action=ALLOW --rules=tcp:22 --source-ranges=0.0.0.0/0 --enable-logging
```
* Create a private GKE cluster
```
gcloud container --project ${PROJECT_ID} clusters create "nat-test-cluster" \
    --zone "us-central1-c" \
    --username "admin" \
    --cluster-version "latest" \
    --machine-type "n1-standard-1" \
    --image-type "COS" \
    --disk-type "pd-standard" \
    --disk-size "100" \
    --scopes "https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
    --num-nodes "2" \
    --enable-cloud-logging \
    --enable-cloud-monitoring \
    --enable-private-nodes \
    --enable-private-endpoint \
    --master-ipv4-cidr "172.16.0.0/28" \
    --enable-ip-alias \
    --network "projects/${PROJECT_ID}/global/networks/gkeprivatenet" \
    --subnetwork "projects/${PROJECT_ID}/regions/us-central1/subnetworks/gkeprivatenet-us" \
    --max-nodes-per-pool "110" \
    --enable-master-authorized-networks \
    --addons HorizontalPodAutoscaling,HttpLoadBalancing,KubernetesDashboard \
    --enable-autoupgrade \
    --enable-autorepair

```
* Get the list of workers in the GKE cluster
```
gcloud compute instances list | grep gke-nat-test-cluster-default-pool
```
* Add a compute Engine SSH key to your local host
```
ssh-add ~/.ssh/google_compute_engine
```
* Connect to the bastion server (-A' Enables forwarding of the authentication agent connection. This can also be specified on a per-host basis in a configuration file)
```
gcloud compute ssh bastion-4-gke --zone us-central1-c -- -A
```
* Add a compute Engine SSH key to your bastion host
```
ssh-add ~/.ssh/google_compute_engine
```
* Login into a GKE node from the node-pool (you got the list from executing the 'instances list' few steps back)
```
ssh [gke-server-name] -i ~/.ssh/google_compute_engine -A
```
* Access the DNS container
```
sudo nsenter --target `ps aux | grep -i "\s/kube-dns" | awk '{print $2}'` --net /bin/bash
```
* Try accessing the world wide web - this should fail
```
curl www.example.com
```
* Leave the terminal open, you will need this to test connectivity after setting up the NAT

### Create the NAT 
* Create a Cloud Router
```
gcloud compute routers create gke-nat-router \
    --network gkeprivatenet \
    --region us-central1
```
* Add a configuration to the router
```
gcloud compute routers nats create gke-nat-config \
    --router-region us-central1 \
    --router gke-nat-router \
    --nat-all-subnet-ip-ranges \
    --auto-allocate-nat-external-ips
```

* Test connectivity to the WWW from the GKE again - Now it should work
```
curl www.example.com
```

# NAT on Regular VM

## What are we going to do?

Google Cloud’s Network Address Translation (NAT) service enables you to provision your application instances without public IP addresses while also allowing them to access the internet for updates, patching, config management, and more in a controlled and efficient manner.

In this lab, you will configure Private Google Access and Cloud NAT for a VM instance that doesn't have an external IP address. Then, you will verify access to public IP addresses of Google APIs and services and other connections to the internet. Finally, you will use Cloud NAT logging to record connections made in your gateway.

### Configure a VM in a private network 
* Create a VPC
```
export PROJECT_ID=`gcloud config get-value project`

gcloud compute --project=$PROJECT_ID networks create privatenet --subnet-mode=custom

gcloud beta compute --project=amiteinav-sandbox networks subnets create privatenet-us --network=privatenet --region=us-central1 --range=10.130.0.0/20 --enable-flow-logs

```
* Create a FW for SSH
```
gcloud beta compute --project=$PROJECT_ID firewall-rules create privatenet-allow-ssh --direction=INGRESS --priority=900 --network=privatenet --action=ALLOW --rules=tcp:22 --source-ranges=0.0.0.0/0 --enable-logging
```
* Create a VM
```
gcloud beta compute --project=$PROJECT_ID instances create vm-internal --zone=us-central1-c --machine-type=n1-standard-1 --subnet=privatenet-us --no-address --maintenance-policy=MIGRATE --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=vm-internal 
``` 
### Create a bastion host and use it to connect to a private-ip VM
```
gcloud beta compute --project=$PROJECT_ID instances create vm-bastion --zone=us-central1-c --machine-type=g1-small --subnet=privatenet-us  --maintenance-policy=MIGRATE --scopes=https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.read_only  --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=vm-bastion 
```
* Add a compute Engine SSH key to your local host
```
ssh-add ~/.ssh/google_compute_engine
```
* Connect to the bastion host using SSH (can also be using the Google Cloud Console)
```
gcloud compute ssh vm-bastion --zone us-central1-c
```
* Verify external connectivity
```
ping -c 2 www.google.com
```
* Connect to the VM without the public IP (from the bastion host)
```
gcloud compute ssh vm-internal --zone=us-central1-c --internal-ip
```
* Verify external connectivity (This time it won't work)
```
ping -c 2 www.google.com
```

### Enable Private Google Access on a subnet
VM instances that have no external IP addresses can use Private Google Access to reach external IP addresses of Google APIs and services. By default, Private Google Access is disabled on a VPC network.

* Create a Cloud Storage bucket to test access to Google APIs and services
gsutil ls -b gs://${PROJECT_ID} > /dev/null 2>&1 || gsutil mb gs://${PROJECT_ID}

* Copy an image
```
gsutil cp gs://cloud-training/gcpnet/private/access.png gs://${PROJECT_ID}
```
* At this point, you cannot even list the buckets from the internal-ip VM
* Configure the Private Google Access to the subnet
```
gcloud compute networks subnets update  privatenet-us \
--region us-central1 \
--enable-private-ip-google-access
```
* Verify that it is privateIpGoogleAccess is true
```
gcloud compute networks subnets describe  privatenet-us --region us-central1 --format="get(privateIpGoogleAccess)"
```
* Now, the private-ip VM can access APIs and services by google (https://cloud.google.com/vpc/docs/private-access-options#pga-supported) 

### Configure a Cloud NAT gateway
* Try running the following on each server (privatevm and the bastion) - it will succeed only on the bastion. the private-vm will succeed only for the google part
```
sudo apt-get update
``` 
* Create a cloud router for the NAT service
```
gcloud compute routers create nat-router --network privatenet --region us-central1
```
* Configure the NAT service
```
gcloud compute routers nats create nat-config \
    --router=nat-router \
    --auto-allocate-nat-external-ips \
    --nat-all-subnet-ip-ranges \
    --enable-logging
```

### Verify access to public IP addresses of Google APIs and services and other connections to the internet.
* Now this command will work for the priave-ip VM
```
sudo apt-get update
```
