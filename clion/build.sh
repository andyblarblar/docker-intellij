#!/bin/bash

# Replace the two build args to change the installed IDE.

JETBRAINS_IDE_URL='https://download.jetbrains.com/cpp/CLion-213.4293.2.tar.gz'
JETBRAINS_IDE_SHORTNAME='clion'

docker build --build-arg JETBRAINS_IDE_URL=${JETBRAINS_IDE_URL} --build-arg JETBRAINS_IDE_SHORTNAME=${JETBRAINS_IDE_SHORTNAME} -t blar/jetbrains_env:${JETBRAINS_IDE_SHORTNAME} -f ../Dockerfile .