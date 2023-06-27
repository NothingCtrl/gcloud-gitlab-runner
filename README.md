# GCloud Gitlab Runner

A docker image with `gitlab-runner`, `gcloud` and `kubeclt`, this image can use for build, push image to GCloud registry, update pods image in Kubernetes or Cloud Run.

### Example usage:

* with `docker`:
  * Build image: `docker build --tag local/gloud-gitlab-runner .`
  * Run container `docker run --name gcloud-gitlab-runner local/gloud-gitlab-runner`
* with `docker-compose` with custom script in `data/scripts/init_script.sh`:
  * Run container: `docker-compose up --build -d`

* Login and register runner with gitlab: 
  ```
  docker exec -ti gcloud-gitlab-runner /bin/bash
  gitlab-runner register
  # note: choose `shell` as executor
  ```
* Auth with Google Cloud using key file: `gcloud auth activate-service-account --key-file=/path/to/key.json`
* Set project: `gcloud config set project your-project-name`
* Set cluster: `gcloud config set container/cluster your-cluster-name`
* Set compute/zone: `gcloud config set compute/zone your-computer-zone`
* Config auth using plugin: `export USE_GKE_GCLOUD_AUTH_PLUGIN=True`
* Load cluster credential: `gcloud container clusters get-credentials your-cluster-name`

* Now, build and deploy new image for your app:
  * Build and submit image: `gcloud builds submit --gcs-log-dir gs://deploy-logs/demo-app-test --tag gcr.io/your-project-name/demo-app-test:0.1.1 .`
  * Deploy image: `kubectl set image deployment demo-app-test-deploy demo-app-test-deploy=gcr.io/your-project-name/demo-app-test:0.1.1 -n default`

