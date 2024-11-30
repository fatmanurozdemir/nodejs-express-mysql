# **Continuous Integration (CI) Pipeline**

### **1. Setting Up GitLab CI**

The CI pipeline automates the process of building and pushing Docker images to Docker Hub every time a change is pushed to the GitHub repository.

#### **Steps to Configure GitLab CI/CD Integration**

1. **Create a GitLab Repository**:
   - Start by creating a new repository in GitLab. This will be used to host the CI/CD pipeline configuration.

2. **Add the `.gitlab-ci.yml` File**:
   - Create a `.gitlab-ci.yml` file in the GitLab repository. This file defines the stages and steps of the pipeline, such as building and pushing Docker images.

3. **Set Environment Variables in GitLab**:
   - Navigate to **Settings → CI/CD → Variables** in your GitLab project.
   - Add the following variables securely:
     - `DOCKER_USERNAME`: Your Docker Hub username.
     - `DOCKER_PASSWORD`: Your Docker Hub password.

4. **Generate a Pipeline Trigger Token in GitLab**:
   - Go to **Settings → CI/CD → Pipeline trigger tokens** in your GitLab project.
   - Create a new trigger token. Copy this token for use in the webhook configuration.

5. **Set Up a GitHub Webhook**:
   - Go to your GitHub repository's **Settings → Webhooks**.
   - Click **Add Webhook** and fill in the following details:
     - **Payload URL**:  
       ```
       https://gitlab.com/api/v4/projects/<project-id>/ref/<gitlab-repo-branch>/trigger/pipeline?token=<gitlab-trigger-token>
       ```
       Replace `<project-id>` with the ID of your GitLab project, `<gitlab-repo-branch>` with the branch name in GitLab, and `<gitlab-trigger-token>` with the token created in the previous step.
     - **Content Type**: Set this to `application/json`.
     - **Events**: Select "Just the push event."

6. **Verify Webhook Integration**:
   - Push a change to your GitHub repository and ensure it triggers the GitLab CI pipeline.

---

### **2. CI Pipeline Stages**

The `.gitlab-ci.yml` file defines the following stages:

1. **Build**:
   - This stage builds the Docker image for the application using the specified `Dockerfile`.
2. **Push**:
   - This stage pushes the built image to Docker Hub.

