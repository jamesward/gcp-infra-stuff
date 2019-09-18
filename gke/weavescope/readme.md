# Weavescope
Ref: https://github.com/weaveworks/scope

## Overview

Weave Scope is a visualization and monitoring tool for Docker and Kubernetes. 
It provides a top down view into your app as well as your entire infrastructure, and allows you to diagnose any problems with your distributed containerized app, in real time, as it is being deployed to a cloud provider.

## Installation instructions on GKE
Ref: https://www.weave.works/docs/scope/latest/installing/#k8s

* To install Weave Scope on your Kubernetes cluster, run
```
kubectl apply -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=\
$(kubectl version | base64 | tr -d '\n')"
```

* To open Scope in Your Browser
```
kubectl port-forward -n weave \
"$(kubectl get -n weave pod --selector=weave-scope-component=app \
-o jsonpath='{.items..metadata.name}')" 4040
```
Note: Do not expose the Scope service to the Internet, e.g. by changing the type to NodePort or LoadBalancer. Scope allows anyone with access to the user interface control over your hosts and containers.


