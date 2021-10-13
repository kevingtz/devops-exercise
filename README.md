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


## Monitoring proposal


1. For infrastructure monitoring I suggest the following:

- For a simple monitoring of resources, the native services of the providers such as Cloudwatch or Stackdriver can be used.

- In case the economic budget is not a priority, I suggest using services such as Datadog, New Relic or Splunk that can greatly facilitate the initial configuration and that nevertheless perform a very complete job in terms of infrastructure monitoring.

- In case the economic budget is a priority, I recommend using services such as the ELK stack with Fluentd and / or Prometheus with Grafana, which are services that, although they require a somewhat complex initial configuration, are services that cover the monitoring of Cloud-based infrastructure.

- For all the above cases, I highly recommend using Pagerduty to support the alerting system that is implemented, since it is one of the best tools on the market to alert, according to a personalized scalability strategy, the indicated people.


2. For the monitoring of the applications I suggest the following:

- Use provider code tracing services to locate code that is causing problems in the operation of the services.

- Sentry is a very good alert service that notifies you when an incident occurs during the execution time of a service and provides you with the location within the code where this error arose.


