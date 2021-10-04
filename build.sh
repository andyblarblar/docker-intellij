#!/bin/bash

# Replace the two build args to change the installed IDE.

JETBRAINS_IDE_URL='https://download.jetbrains.com/idea/ideaIC-2021.2.2.tar.gz'
JETBRAINS_IDE_SHORTNAME='idea'

docker build --build-arg JETBRAINS_IDE_URL=${JETBRAINS_IDE_URL} --build-arg JETBRAINS_IDE_SHORTNAME=${JETBRAINS_IDE_SHORTNAME} -t blar/intellij:latest -f ./Dockerfile .