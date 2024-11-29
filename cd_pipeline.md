# Continuous Development (CD) Pipeline

### **1. Install FluxCD CLI**

Run the following command to install the FluxCD CLI:

```bash
curl -s https://fluxcd.io/install.sh | sudo bash
```

Verify the installation:

```bash
flux --version
```

---

### **2. Pre-check Cluster Compatibility**

Check if your cluster meets the prerequisites for installing FluxCD:

```bash
flux check --pre
```

---

### **3. Bootstrap FluxCD**

Bootstrap FluxCD in your GitHub repository to manage the cluster state:

#### **Basic Bootstrap**
Run the following command, replacing `<your-github-username>` with your GitHub username:

```bash
flux bootstrap github \
  --owner=<your-github-username> \
  --repository=fleet-infra \
  --branch=main \
  --path=./clusters/my-cluster \
  --personal
```

#### **Custom Components**
To include additional components like `image-reflector-controller`, `image-automation-controller`, and `helm-controller`, use:

```bash
flux bootstrap github \
  --owner=<your-github-username> \
  --repository=fleet-infra \
  --branch=main \
  --path=./clusters/my-cluster \
  --components=source-controller,image-reflector-controller,image-automation-controller,kustomize-controller,helm-controller
```

---

### **4. Verify Installation**

Check the status of the installed FluxCD components:

```bash
kubectl get pods -n flux-system
```

---

### **5. Install CRDs**

Apply the required Custom Resource Definitions (CRDs) for FluxCD components:

```bash
kubectl apply -f https://github.com/fluxcd/flux2/releases/download/v0.38.0/install.yaml
```
