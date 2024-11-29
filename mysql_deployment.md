# MySQL Deployment

To deploy MySQL, we use the Bitnami Helm chart. Below are the steps for setting up MySQL:

### **1. Create MySQL Persistent Volume (PV)**

In the `nodejs-express-mysql/manifest` directory, create a **Persistent Volume (PV)** manifest for MySQL:

```bash
kubectl create -f mysql-pv.yaml
```

Ensure the directory exists and has proper permissions:
```bash
sudo mkdir -p /mnt/data/mysql
sudo chmod 777 /mnt/data/mysql
sudo chown 1001:1001 /mnt/data/mysql
```

### **2. Create MySQL Persistent Volume Claim (PVC)**

Create a **Persistent Volume Claim (PVC)** for MySQL in the `nodejs-express-mysql/manifest` directory:

```bash
kubectl create -f mysql-pvc.yaml
```

### **3. Create MySQL Secrets**

Create the MySQL credentials and configuration as a Kubernetes **Secret** in the `nodejs-express-mysql/manifest` directory. Ensure the secrets contain the necessary information such as the database name, username, and password.

```bash
kubectl create -f mysql-db-secret.yaml
```

**`mysql-db-secret.yaml`**:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-db-secret
type: Opaque
data:
  mysql-root-password: <base64_encoded_password>
  mysql-database: <base64_encoded_db_name>
  mysql-user: <base64_encoded_user>
  mysql-password: <base64_encoded_user_password>
```

Replace the values with base64-encoded versions of your desired database password, database name, username, and user password. You can encode them with the following command:
```bash
echo -n 'your_password' | base64
```

### **4. Install MySQL using Helm**

Now, deploy the MySQL Helm chart with the custom values specified in the `mysql-db-secret.yaml`:

```bash
helm install mysql bitnami/mysql -f nodejs-express-mysql/manifest/db-values.yaml
```
