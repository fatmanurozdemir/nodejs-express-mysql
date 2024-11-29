# **Continuous Integration (CI) Pipeline**

### **1. Setting Up GitLab CI/CD**

The CI/CD pipeline automates the process of building and pushing Docker images to Docker Hub every time a change is pushed to the GitHub repository.

#### **GitLab CI/CD Configuration**

The CI/CD pipeline is configured in `.gitlab-ci.yml`. Below is an overview of the steps:

1. **Webhook Integration**:
   - A GitHub webhook is set up to notify GitLab of new commits in the repository.
   - This triggers the GitLab CI pipeline automatically whenever a commit is pushed.

2. **CI Pipeline Stages**:
   - **Build**: Builds the Docker image for the application.
   - **Push**: Pushes the built image to Docker Hub.

#### **GitLab CI/CD Pipeline Definition**

Here’s an example of the `.gitlab-ci.yml` file:
```yaml
stages:
  - build
  - push

variables:
  DOCKER_IMAGE: your_dockerhub_username/nodejs-express-mysql-app

build:
  stage: build
  script:
    - docker build -t $DOCKER_IMAGE:latest .
  only:
    - main

push:
  stage: push
  script:
    - echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    - docker push $DOCKER_IMAGE:latest
  only:
    - main
```

Replace `your_dockerhub_username` with your actual Docker Hub username. Ensure that `DOCKER_USERNAME` and `DOCKER_PASSWORD` are securely stored in GitLab CI/CD variables.

### **2. Docker Hub Integration**

- The Docker image is built using the CI/CD pipeline and pushed to Docker Hub.
- The Kubernetes cluster pulls the latest image from Docker Hub during deployments.
