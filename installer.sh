#!/bin/bash
# Centos Minikube Local Dev Instructions
# CentOS 7.x

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum --enablerepo=epel install 

cd /etc/yum.repos.d/
wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
yum -y update && yum -y upgrade
yum groupinstall "Development Tools"
yum -y install gcc gcc-c++ kernel-headers kernel-devel git unzip wget 
yum clean all
yum install gcc make patch  dkms qt libgomp
yum install kernel-headers kernel-devel fontforge binutils glibc-headers glibc-devel
yum install VirtualBox-5.1

yum install -y kubectl

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.27.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

/usr/local/bin/minikube start

kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.10 --port=8080
kubectl expose deployment hello-minikube --type=NodePort
kubectl get pod
curl $(minikube service hello-minikube --url)
url $(/usr/local/bin/minikube service hello-minikube --url)
