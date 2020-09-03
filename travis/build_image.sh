#!/usr/bin/env bash

SERVICE_NAME=$1
AWS_ECR_URI=$2

if [[ $TRAVIS_BRANCH = develop ]]; then
  IMAGE_TAG=$TRAVIS_BRANCH
fi
if [[ $TRAVIS_BRANCH =~ ^release\/.*$ ]]; then
  IMAGE_TAG=release
fi

echo "EVENT_TYPE=${TRAVIS_EVENT_TYPE})"
echo "TRAVIS_BRANCH=${TRAVIS_BRANCH})"
echo "TRAVIS_PULL_REQUEST_BRANCH=${TRAVIS_PULL_REQUEST_BRANCH}"

#docker build -f ${TRAVIS_BUILD_DIR}/Dockerfile --no-cache --tag ${SERVICE_NAME} .
#docker tag ${SERVICE_NAME}:latest ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}
#docker push ${AWS_ECR_URI}/${SERVICE_NAME}:${IMAGE_TAG}

exit 0
