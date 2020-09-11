#!/usr/bin/env bash

set -euv

SERVICE_NAME=$1
AWS_ECR_URI=$2
TAG=$3

if [[ "${TRAVIS_PULL_REQUEST}" = "false" ]]
then

  # TRAVIS_BRANCH can be : develop or release/x.x.x or hotfix/x.x.x
  if [[ $TRAVIS_BRANCH = develop ]]; then
    IMAGE_TAG=$TRAVIS_BRANCH
  else
    IMAGE_TAG=$(echo ${TRAVIS_BRANCH} | sed s#\/#-#)
  fi

  echo "EVENT_TYPE=${TRAVIS_EVENT_TYPE}"
  echo "TRAVIS_BRANCH=${TRAVIS_BRANCH}"
  echo "IMAGE_TAG=${IMAGE_TAG}"
  echo "TAG=${TAG}"
  echo "TRAVIS_PULL_REQUEST_BRANCH=${TRAVIS_PULL_REQUEST_BRANCH}"

  if docker build -f ${TRAVIS_BUILD_DIR}/Dockerfile --no-cache --tag ${SERVICE_NAME} .
  then
    echo "tag"
    echo "push"
  fi

  #docker tag ${SERVICE_NAME}:latest ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}
  #docker push ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}

fi
