#!/bin/bash

# Replace the two build args to change the installed IDE.

docker build --build-arg JETBRAINS_IDE_URL='https://download.jetbrains.com/idea/ideaIC-2021.2.2.tar.gz' --build-arg JETBRAINS_IDE_SHORTNAME='idea' -t blar/intellij:latest -f ./Dockerfile .