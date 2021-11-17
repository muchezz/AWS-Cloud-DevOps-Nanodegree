#!/usr/bin/env sh
set -e

REGION="us-west-2"
ECR_URL="910756530301.dkr.ecr.us-west-2.amazonaws.com/L"
BUILD_NUMBER="${BUILD_NUMBER:-$(date +%s)}"
# JAR_PATH=Dockerfile

echo "Building $BUILD_NUMBER" 

# log docker into eks using aws cli
$(aws ecr get-login --no-include-email --region $REGION)
# build a docker image with a unique build number
docker build -t $ECR_URL:$BUILD_NUMBER \
#   --build-arg JAR_PATH="$JAR_PATH" \
  --build-arg VERSION="$BUILD_NUMBER" \
  .

# push to ecr
docker push $ECR_URL:$BUILD_NUMBER

#tag for "latest" and also push that
docker tag $ECR_URL:$BUILD_NUMBER $ECR_URL:latest
docker push $ECR_URL:latest