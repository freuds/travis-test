#!/usr/bin/env bash

set -e
set -x

SERVICE_NAME=$1
AWS_ECR_URI=$2
TAG=$3

if [[ "${TRAVIS_PULL_REQUEST}" = "false" ]]
then

  echo "EVENT_TYPE=${TRAVIS_EVENT_TYPE}"
  echo "TRAVIS_BRANCH=${TRAVIS_BRANCH}"
  echo "IMAGE_TAG=${IMAGE_TAG}"
  echo "TAG=${TAG}"
  echo "TRAVIS_PULL_REQUEST_BRANCH=${TRAVIS_PULL_REQUEST_BRANCH}"

  # at this point TRAVIS_BRANCH could be only : master or develop or release/x.x.x or hotfix/x.x.x
  IMAGE_TAG=$(echo ${TRAVIS_BRANCH} | sed s#\/#-#)
  docker build -f ${TRAVIS_BUILD_DIR}/docker/phenix/Dockerfile --no-cache --tag ${SERVICE_NAME} .
  docker tag ${SERVICE_NAME}:latest ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}
  docker push ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}

  if [[ "${TRAVIS_BRANCH}" = "master" ]]
  then
    docker tag ${SERVICE_NAME}:latest ${AWS_ECR_URI}/${SERVICE_NAME}:latest
    docker push ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}
  fi
fi


#docker build -f ${TRAVIS_BUILD_DIR}/Dockerfile --no-cache --tag ${SERVICE_NAME} .
#docker tag ${SERVICE_NAME}:latest ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}
#docker push ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}

exit 0
