FROM cwlf/minecraft-sponge:latest
MAINTAINER Chip Wolf <hello@chipwolf.uk>

EXPOSE 25565

WORKDIR /opt/app

ENV PO3_ZIP PO3+v.3.0.38+Server.zip
ENV PO3_URL https://media.forgecdn.net/files/2676/712/${PO3_ZIP}

RUN curl -sLo ${PO3_ZIP} ${PO3_URL} && \
  unzip -qqn ${PO3_ZIP} && \
  rm -f ${PO3_ZIP}

RUN ["java", \
  "-Xms8G", \
  "-Xmx16G", \
  "-XX:+UseParNewGC", \
  "-XX:+CMSIncrementalPacing", \
  "-XX:+CMSClassUnloadingEnable", \
  "-XX:ParallelGCThreads=5", \
  "-XX:MinHeapFreeRatio=5", \
  "-XX:MaxHeapFreeRatio=10", \
  "-Dfml.readTimeout=512", \
  "-jar", \
  "forge-1.12.2-14.23.5.2808-universal.jar", \
  "nogui"]

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.vcs-url="https://github.com/dockerwolf/minecraft-sponge.git"
LABEL org.label-schema.name="Minecraft Sponge"
LABEL org.label-schema.vendor="Chip Wolf"
LABEL org.label-schema.schema-version="1.0"
