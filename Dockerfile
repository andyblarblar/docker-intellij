FROM azul/zulu-openjdk:17

MAINTAINER Andrew Ealovega <Andrew@Ealovega.dev>

ENV IDEA_JDK=/usr/lib/jvm/zulu-17-amd64

# URL of the IDE to download.
ARG JETBRAINS_IDE_URL

# Shortened name of the ide to run, 'idea', 'clion'
ARG JETBRAINS_IDE_SHORTNAME
ENV JETBRAINS_IDE_SHORTNAME=${JETBRAINS_IDE_SHORTNAME}

RUN useradd -ms /bin/bash powerless
RUN echo 'powerless:1234' | chgpasswd
RUN echo 'root:1234' | chgpasswd

# We rename the ide to 'jetbrains ide' to avoid needing to rename for each version. 
# This shouldnt effect the cache naming, and thus works with updates, and we dont expect 
# multiple IDEs to be installed in one container anyways.
ENTRYPOINT "/opt/jetbrains_ide/bin/${JETBRAINS_IDE_SHORTNAME}.sh"

USER root

RUN apt update && \
    apt install -y wget git && \
    wget -O /opt/idea.tar.gz ${JETBRAINS_IDE_URL}

RUN mkdir /opt/jetbrains_ide && \
    tar --extract --verbose --directory /opt --file /opt/idea.tar.gz -C jetbrains_ide --strip-components 1 && \ 
    rm -f /opt/idea.tar.gz

USER powerless

# Create IDE directories as the volume will create as root if not, causing the IDE to crash.
RUN mkdir -p /home/powerless/.config/JetBrains/ && chown -R 1000 /home/powerless/.config/JetBrains/
RUN mkdir -p /home/powerless/.cache/JetBrains/ && chown -R 1000 /home/powerless/.cache/JetBrains/
RUN mkdir -p /home/powerless/.local/JetBrains/ && chown -R 1000 /home/powerless/.local/JetBrains/