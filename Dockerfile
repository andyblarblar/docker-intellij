FROM azul/zulu-openjdk:17

MAINTAINER Andrew Ealovega <Andrew@Ealovega.dev>

ENV IDEA_JDK /usr/lib/jvm/zulu-17-amd64

RUN useradd -ms /bin/bash powerless
RUN echo 'powerless:1234' | chgpasswd
RUN echo 'root:1234' | chgpasswd

ENTRYPOINT ["/opt/idea-IC-212.5284.40/bin/idea.sh"]

USER root

ADD https://download.jetbrains.com/idea/ideaIC-2021.2.2.tar.gz /opt/idea.tar.gz

RUN tar --extract --verbose --directory /opt --file /opt/idea.tar.gz && rm -f /opt/idea.tar.gz

USER powerless
