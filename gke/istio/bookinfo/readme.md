# Bookinfo Demo

Follow the steps at https://istio.io/docs/examples/bookinfo/


*  Label the namespace that will host the application with istio-injection=enabled:
```
kubectl label namespace default istio-injection=enabled
```

* Deploy your application 
```
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.2/samples/bookinfo/platform/kube/bookinfo.yaml
```

* Confirm all services and pods are correctly defined and running
```
kubectl get services,pods
```

* Make sure the service runs
```
kubectl exec -it \
$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') \
-c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
```
* Define the ingress gateway for the application:
```
$ kubectl apply -f \
https://raw.githubusercontent.com/istio/istio/release-1.2/samples/bookinfo/networking/bookinfo-gateway.yaml
```
* Determining the ingress IP and ports
```
kubectl get svc istio-ingressgateway -n istio-system
```
* If the TYPE is LoadBalancer use these
```
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
```
* If INGRESS_HOST is empty - use this (using hostname instead of IP)
```
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
```
* Set the GATEWAY URL
```
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
```
* Confirm, that the Bookinfo application is accesible from outside the cluster
```
curl -s http://${GATEWAY_URL}/productpage | grep -o "<title>.*</title>"
```