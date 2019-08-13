kubectl delete PipelineResource pdf-image-amiteinav > /dev/null 2&>1
kubectl delete PipelineResource pdf-git > /dev/null 2&>1
kubectl delete Task build-push-kaniko > /dev/null 2&>1
kubectl delete taskrun build-push-run > /dev/null 2&>1
kubectl delete task deploy-using-kubectl > /dev/null 2&>1
kubectl delete task source-to-image > /dev/null 2&>1
kubectl delete pipeline build-and-deploy-pipeline > /dev/null 2&>1
kubectl delete pipeline build-pipeline > /dev/null 2&>1
kubectl delete pipelineresources skaffold-image-leeroy-web > /dev/null 2&>1
kubectl delete pipelineresources skaffold-git > /dev/null 2&>1
kubectl delete tasks build-push-run > /dev/null 2&>1
kubectl delete taskrun build-push-run > /dev/null 2&>1

