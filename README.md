# Yelb Application to Yandex Managed Service for Kubernetes deploy via Gitlab CI/CD pipeline
## The [Yelb Application](https://github.com/mreferre/yelb) made by mreferre is used. The rights to the application belong to them.
## Pipeline stages overview:
- lint: yaml, dockerfile and helm lints;
- build: building frontend and backend parts of the application using docker build;
- test: launching the application in docker-compose and testing it;
- cleanup: deleting the test application;
- push: pushing the previously collected and tested images in Docker Registry;
- deploy: getting Kubernetes credentials; creating a namespace; creating two secrets: with Docker Registry credentials and with a SSL certificate; deploying applications using helm chart.

## Gitlab CI/CD variables:
| Variable                | Descrtiption                                           |
|-------------------------|--------------------------------------------------------|
| IMAGE_BACKEND           | Backend image name                                     |
| IMAGE_FRONTEND          | Frontend image name                                    |
| K8S_APP_NAMESPACE       | The application namespace                              |
| K8S_CLUSTER_NAME        | variable for accessing the k8s cluster in the pipeline |
| K8S_PULL_EMAIL          | Docker registry email                                  |
| K8S_PULL_PASSWORD       | Docker registry password                               |
| K8S_PULL_TOKEN          | Docker registry pull token                             |
| YC_CLOUD_ID             | Yandex CLoud credenatials (yc config get cloud-id)     |
| YC_FOLDER_ID            | Yandex CLoud credenatials (yc config get folder-id)    |
| YC_TOKEN                | Yandex CLoud credenatials (yc config get token)        |
| YELB_DB_NAME            | Specify a database name for the chart                  |
| YELB_DB_SERVER_ENDPOINT | Specify PostgreSQL host for the chart                  |
| YELB_DB_SERVER_PASSWORD | Specify PostgreSQL password fot the chart              |
| YELB_DB_SERVER_PORT     | Specify PostgreSQL port for the chart                  |
| YELB_DB_SERVER_USER     | Specify PostgreSQL user for the chart                  |
| YELB_RACK_ENV           | Specify Ruby environment value                         |
| YELB_REDIS_ENDPOINT     | Specify Redis host for the chart                       |
| YELB_REDIS_PASSWORD     | Specify Redis password for the chart                   |
| YELB_REDIS_PORT         | Specify Redis port for the chart                       |
