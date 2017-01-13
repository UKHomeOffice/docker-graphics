FROM alpine:3.5

MAINTAINER stefan.cocora@gmail.com

ARG PLANTUML_VERSION
ARG CONTAINER_NONPRIVILEDGED_USER

ENV PLANTUML_VER=$PLANTUML_VERSION \
    USER=$CONTAINER_NONPRIVILEDGED_USER

RUN \
  apk add --no-cache wget ca-certificates && \
  wget "https://downloads.sourceforge.net/project/plantuml/plantuml.${PLANTUML_VERSION}.jar" -O plantuml.jar && \
  apk del --purge wget ca-certificates


RUN apk --update add bash make
RUN apk --update add graphviz openjdk8 ttf-dejavu

# add non-root user
RUN adduser -u 1000 -G users  -s /bin/sh -D -h /home/${USER} ${USER}

USER $USER
WORKDIR /home/$USER
