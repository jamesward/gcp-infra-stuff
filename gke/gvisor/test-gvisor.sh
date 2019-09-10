export POD_NAME=`kubectl get pods --output="name" | grep fedora`
kubectl exec -it $POD_NAME /bin/sh
curl -s "http://metadata.google.internal/computeMetadata/v1/instance/attributes/kube-env" -H "Metadata-Flavor: Google"

#remove the runtimeclass from the sandbox-metadata-test.yaml file and apply 

#Test again 

