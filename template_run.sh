#!/bin/bash

# Launches a Jetbrains IDE in a docker container.

CONTAINER=jetbrains_env

# Change this variable to change the ide used.
IDE=idea

IMAGE=${1:-blar/${CONTAINER}:${IDE}}

DOCKER_GROUP_ID=$(cut -d: -f3 < <(getent group docker))
USER_ID=$(id -u $(whoami))
GROUP_ID=$(id -g $(whoami))
HOME_DIR=$(cut -d: -f6 < <(getent passwd ${USER_ID}))

# Need to give the container access to your windowing system
export DISPLAY=:0
xhost +

CMD="docker run --detach=true \
                --group-add ${DOCKER_GROUP_ID} \
                --env DISPLAY=unix${DISPLAY} \
                --interactive \
                --name ${CONTAINER}_${IDE} \
                --net "host" \
                --rm \
                --tty \
                --user=${USER_ID}:${GROUP_ID} \
                --volume ${HOME}:${HOME}
                --volume intellij_config:/home/powerless/.config/JetBrains/ \
                --volume intellij_cache:/home/powerless/.cache/JetBrains/ \
                --volume intellij_plugins:/home/powerless/.local/share/JetBrains/ \
                --volume intellij_java:/home/powerless/.java/ \
                --volume /tmp/.X11-unix:/tmp/.X11-unix \
                --volume /var/run/docker.sock:/var/run/docker.sock \
                ${IMAGE}"

$CMD

# Minor post-configuration
docker exec --user=root -it ${CONTAINER}_${IDE} groupadd -g $DOCKER_GROUP_ID docker

docker attach ${CONTAINER}_${IDE}
