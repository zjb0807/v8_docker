#!/bin/bash
set -e

version=1.0.0
docker build . -f Dockerfile -t zjb0807/v8:"$version"
#docker build . -f Dockerfile --no-cache -t zjb0807/v8:"$version"

docker tag zjb0807/v8:"$version" zjb0807/v8:latest

docker login
docker push zjb0807/v8:"$version"
docker push zjb0807/v8:latest
