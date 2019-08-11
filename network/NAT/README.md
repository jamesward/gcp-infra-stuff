# NAT Demo

## What are we going to do?

Google Cloud’s Network Address Translation (NAT) service enables you to provision your application instances without public IP addresses while also allowing them to access the internet for updates, patching, config management, and more in a controlled and efficient manner.

In this lab, you will configure Private Google Access and Cloud NAT for a VM instance that doesn't have an external IP address. Then, you will verify access to public IP addresses of Google APIs and services and other connections to the internet. Finally, you will use Cloud NAT logging to record connections made in your gateway.

## Configure a VM in a private network 
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

## Create a bastion host and use it to connect to a private-ip VM
```
gcloud beta compute --project=$PROJECT_ID instances create vm-bastion --zone=us-central1-c --machine-type=g1-small --subnet=privatenet-us  --maintenance-policy=MIGRATE --scopes=https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.read_only  --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=vm-bastion 
```

* connect to the bastion host using SSH (can also be using the Google Cloud Console)
```
gcloud compute ssh vm-bastion --zone us-central1-c
```
* verify external connectivity
```
ping -c 2 www.google.com
```
* Connect to the VM without the public IP (from the bastion host)
```
gcloud compute ssh vm-internal --zone=us-central1-c --internal-ip
```
* verify external connectivity (This time it won't work)
```
ping -c 2 www.google.com
```

## Enable Private Google Access on a subnet
VM instances that have no external IP addresses can use Private Google Access to reach external IP addresses of Google APIs and services. By default, Private Google Access is disabled on a VPC network.

* Create a Cloud Storage bucket to test access to Google APIs and services
gsutil ls -b gs://${PROJECT_ID} > /dev/null 2>&1 || gsutil mb gs://${PROJECT_ID}

* copy an image
```
gsutil cp gs://cloud-training/gcpnet/private/access.png gs://${PROJECT_ID}
```

* at this point, you cannot even list the buckets from the internal-ip VM

* configure the Private Google Access to the subnet
```
gcloud compute networks subnets update  privatenet-us \
--region us-central1 \
--enable-private-ip-google-access
```
* verify that it is privateIpGoogleAccess is true
```
gcloud compute networks subnets describe  privatenet-us --region us-central1 --format="get(privateIpGoogleAccess)"
```

* now, the private-ip VM can access APIs and services by google (https://cloud.google.com/vpc/docs/private-access-options#pga-supported) 

## Configure a Cloud NAT gateway
* try running the following on each server (privatevm and the bastion) - it will succeed only on the bastion. the private-vm will succeed only for the google part
```
sudo apt-get update
``` 

* create a cloud router for the NAT service
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

* Now this command will work for the priave-ip VM
```
sudo apt-get update
```



## Verify access to public IP addresses of Google APIs and services and other connections to the internet.
## Log NAT connections with Cloud NAT logging.

```
export PROJECT_ID=`gcloud config get-value project`
VPC_NAME=privatenet

gcloud compute --project=$PROJECT_ID networks create privatenet --subnet-mode=custom

gcloud beta compute --project=amiteinav-sandbox networks subnets create privatenet-us --network=privatenet --region=us-central1 --range=10.130.0.0/20 --enable-flow-logs

```
