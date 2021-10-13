# TD DevOpsExercise

> :warning: **If you want to build the image on the docker env of minikube execute first**: 
```
eval $(minikube docker-env)
```

## Docker



- Build
```
docker build -t td-devopsexercise .
```
- Run 
```
docker run -it -p 5000:5000 td-devopsexercise
```
- Compose
```
docker-compose up -d --build
```

- Test Compose
```
curl -I http://127.0.0.1:5000
```

## Kubernetes (minikube)

- Creating Environment
```
minikube start
eval $(minikube docker-env)
docker build -t td-devopsexercise .
```
- Installing helm chart (were zulu is the deployment name (can be overwritten ))
```
 helm install zulu .
```
- Test svc
```
kubectl run curlpod --image=radial/busyboxplus:curl --rm -it  -- sh -c "curl http://zulu-td-devopsexercise:5000"
```
