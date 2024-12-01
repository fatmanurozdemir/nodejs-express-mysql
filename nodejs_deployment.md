# Node.js Express Application Deployment

### **1. Create Node.js Application Secret**

In the `nodejs-express-mysql/manifest` directory, create a **Secret** for the Node.js Express app configuration. This secret will store the database credentials.

**`mysql-secret.yaml`**:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
type: Opaque
data:
  DB_HOST: <base64_encoded_db_host>
  DB_USER: <base64_encoded_db_user>
  DB_PASSWORD: <base64_encoded_db_password>
  DB_NAME: <base64_encoded_db_name>
```

Again, replace the values with base64-encoded versions of the database connection details.

### **2. Docker Image for Node.js Application**

The Docker image for the Node.js Express application is built and pushed to Docker Hub. The image is then pulled from Docker Hub when deploying the application using Helm.

To build the Docker image, navigate to the directory where your `Dockerfile` is located and run:
```bash
docker build -t your_dockerhub_username/nodejs-express-mysql-app:latest .
docker push your_dockerhub_username/nodejs-express-mysql-app:latest
```

### **3. Configure Environment Variables for Database Connection**

The Node.js application is configured to connect to the MySQL database via environment variables. Instead of using `localhost`, the application uses the MySQL **service** name, `mysql-service`, in the **DB_HOST** environment variable. This ensures that the Node.js application connects to the MySQL database using Kubernetes' internal service networking, rather than directly via `localhost`.

In the Node.js application, the environment variable **DB_HOST** is set to `mysql-service`, allowing the application to connect to the MySQL service within the Kubernetes cluster. The other database-related environment variables such as **DB_USER**, **DB_PASSWORD**, and **DB_NAME** are also configured via Kubernetes secrets.

Here is an example of what **`db.config.js`** might look like:
```javascript
module.exports = {
  HOST: process.env.DB_HOST,
  USER: process.env.DB_USER,
  PASSWORD: process.env.DB_PASSWORD,
  DB: process.env.DB_NAME
};
```

### **4. Deploy the Node.js Application using Helm**

After setting up the secrets and Docker image, you can deploy the Node.js Express application using a Helm chart:

```bash
mkdir helmchart
cd helmchart
helm create nodejs-express-mysql
```
`values.yaml` and `templates/deployment.yaml` files are utilized for the environment variables.

```bash
helm package nodejs-express-mysql/
helm install -n flux-system nodejs-express-mysql ./nodejs-express-mysql
```
This command installs the application, connecting it to the MySQL database. Ensure that the Helm chart configuration files are correctly pointing to the database secrets and pulling the correct Docker image from Docker Hub.


### **5. Delete Deployment**

Delete deployment, since it will be installed with "HelmRelease" later:
```bash
helm uninstall -n flux-system nodejs-express-app
```

