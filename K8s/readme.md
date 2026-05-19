# ClickNCart Kubernetes Deployment

This project demonstrates how to deploy a full-stack application using Kubernetes instead of Docker Compose.

The application contains:

- Frontend
- Backend (Spring Boot)
- MySQL Database

All services are containerized using Docker and deployed into Kubernetes using:

- Namespace
- Deployments
- Services
- Persistent Volumes
- Persistent Volume Claims
- ConfigMaps

---

# Project Architecture

Frontend → Backend → MySQL

Kubernetes internally handles:
- Networking
- DNS
- Service Discovery

---

# Kubernetes Files Structure

```bash
k8s/
├── namespace.yaml
├── mysql.yaml
├── backend.yaml
├── frontend.yaml
├── mysql-pv-pvc.yaml
└── db.sql

MySQL Initialization Flow
db.sql
   ↓
ConfigMap
   ↓
Mounted into container
   ↓
/docker-entrypoint-initdb.d
   ↓
MySQL startup script executes it
   ↓
Database initialized

To Reinitialize Database

Delete PVC and MySQL pod:

kubectl delete pvc mysql-pvc -n clickncart

kubectl delete pod <mysql-pod-name> -n clickncart

---

# Deployment Order

Deploy resources in this order:

kubectl apply -f namespace.yaml

kubectl apply -f mysql-pv-pvc.yaml

kubectl create configmap mysql-initdb-config \
--from-file=db.sql=./db.sql \
-n clickncart

kubectl apply -f mysql.yaml

kubectl apply -f backend.yaml

kubectl apply -f frontend.yaml

---

Verify Deployment
Check Pods
kubectl get pods -n clickncart
Check Services
kubectl get svc -n clickncart
Check PVC
kubectl get pvc -n clickncart

Running on Kubeadm Cluster

For local/self-managed Kubernetes clusters using kubeadm:

Frontend service can remain:

type: ClusterIP

Access application using port forwarding:

kubectl port-forward svc/frontend 3000:3000 -n clickncart

Access:

http://localhost:3000

Running on AWS EKS

In AWS EKS, expose frontend using:

type: LoadBalancer

Example:

spec:
  type: LoadBalancer

AWS automatically provisions:

Elastic Load Balancer (ELB)

Get external endpoint:

kubectl get svc -n clickncart

kubectl get all -n clickncart

