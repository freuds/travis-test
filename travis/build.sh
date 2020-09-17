#!/usr/bin/env bash

set -eu
set -x

SERVICE_NAME=$1
AWS_ECR_URI=$2
TAG=$3

if [[ "${TRAVIS_PULL_REQUEST}" = "false" ]]
then

  if [[ "${$TRAVIS_BRANCH}" =~ ^(develop|master)$ ]]; then
    IMAGE_TAG=$TRAVIS_BRANCH
  else
    IMAGE_TAG=$TAG
  fi

  IMAGE_TAG="${TAG:-$TRAVIS_BRANCH}"
  docker build -f ${TRAVIS_BUILD_DIR}/docker/phenix/Dockerfile --no-cache --tag ${SERVICE_NAME} .
  docker tag ${SERVICE_NAME}:latest ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}
  docker push ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}

  if [[ "${TRAVIS_BRANCH}" = "master" ]]
  then
    docker tag ${SERVICE_NAME}:latest ${AWS_ECR_URI}/${SERVICE_NAME}:latest
    docker push ${AWS_ECR_URI}/${SERVICE_NAME}:latest
  fi
fi
