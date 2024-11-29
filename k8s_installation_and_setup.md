# Kubernetes Installation and Setup

To deploy the Node.js Express MySQL application on a Kubernetes cluster, we start by setting up a Kubernetes environment using **kubeadm**. Below are the steps performed so far to prepare the infrastructure:

### **1. Install Docker and Kubernetes Tools**

Install Docker and Kubernetes components on the master and worker nodes:

#### **Docker Installation**
```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo systemctl enable docker
sudo systemctl start docker
```
Verify Docker:
```bash
docker --version
```

#### **Kubernetes Tools Installation**
```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF'
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```
Verify Kubernetes components:
```bash
kubeadm version
kubectl version --client
kubelet --version
```

### **2. Initialize the Kubernetes Cluster**

On the master node, initialize the Kubernetes cluster:
```bash
sudo kubeadm init --upload-certs --cri-socket=unix:///var/run/cri-dockerd.sock
```
Set up `kubectl` for the master node:
```bash
mkdir -p $HOME/.kube
sudo touch /etc/kubernetes/admin.conf
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo mkdir -p /root/.kube/
sudo cp ~/.kube/config /root/.kube/config
sudo chown root: /root/.kube/config
```
Verify cluster status:
```bash
kubectl get nodes
```

Remove taint from master node:
```bash
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```

### **3. Deploy a Pod Network**

Install a network plugin to enable communication between pods. For this setup, we chose Calico:
```bash
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```
Verify the pods are running:
```bash
kubectl get pods --all-namespaces
```

### **4. Install Helm**

Helm is used as the Kubernetes package manager for deploying applications:
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version
```
Add stable Helm repositories:
```bash
helm repo add stable https://charts.helm.sh/stable
helm repo update
```
