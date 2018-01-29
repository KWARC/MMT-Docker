FROM openjdk:jre-alpine

# Configure sbt
ENV SBT_URL=https://dl.bintray.com/sbt/native-packages/sbt \
    SBT_RELEASE=0.13.15 \
    PATH=/opt/sbt/bin:${PATH}

# Install sbt
RUN apk --no-cache --no-progress add --virtual build-deps curl wget \
  && mkdir -p /opt && cd /opt \
  && curl -jksSL "${SBT_URL}/${SBT_RELEASE}/sbt-${SBT_RELEASE}.tgz" | tar -xzf - \
  && apk --no-progress del build-deps \
  && rm -rf /var/cache/apk/*

# Install git
RUN apk --no-cache --no-progress add bash git \
    && rm -rf /var/cache/apk/*

# Configure MMT
ENV MMT_BRANCH master

# Install MMT
RUN git clone -b $MMT_BRANCH --depth 1 https://github.com/UniFormal/MMT /tmp/MMT \
  && cd /tmp/MMT/src && sbt deploy && cd /root/ \
  && mkdir -p /root/MMT/deploy \
  && cp /tmp/MMT/deploy/mmt.jar /root/MMT/deploy/mmt.jar \
  && cp /tmp/MMT/deploy/mmt /root/MMT/deploy/mmt \
  && ln -s /root/content/MathHub/mmtrc /root/MMT/deploy/mmtrc \
  && rm -rf /tmp/MMT

VOLUME /root/content/MathHub
ENTRYPOINT /root/MMT/deploy/mmt