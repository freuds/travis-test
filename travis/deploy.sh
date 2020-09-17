#!/usr/bin/env bash

set -e

HELM_VERSION=2.12.3

SERVICE_NAME=$1
AWS_ECR_URI=$2
TAG=$3
#K8S_CLUSTER_ZONE=$4
#GCLOUD_PROJECT_ID=$5
ENVIRONMENT=${6:-'qa'}

if ! [[ "$ENVIRONMENT" =~ ^(qa|staging|prod)$ ]]; then
    echo "Wrong environment : ${ENVIRONMENT}"
    echo "This should be one of these : qa, staging or prod"
    exit
fi

echo "SERVICE_NAME=${SERVICE_NAME}"
echo "AWS_ECR_URI=${AWS_ECR_URI}"
echo "TAG=${TAG}"
echo "TRAVIS_BRANCH=${TRAVIS_BRANCH}"
echo "ENVIRONMENT=${ENVIRONMENT}"