FROM alpine:latest

COPY jdk.tar.gz /tmp/jdk.tar.gz

RUN apk --no-cache add tar ca-certificates wget  && \
     wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
     wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.32-r0/glibc-2.32-r0.apk && \
     apk add glibc-2.32-r0.apk && \
     rm -rf add glibc-2.32-r0.apk &&\
     cd /tmp && \
     mkdir -p /opt &&\
     tar -xvzf /tmp/jdk.tar.gz -C /opt  && \
     cd /opt && \
     mv jdk1.8.0_261 jdk && \
     rm -rf /tmp/* && \
     rm -rf $JAVA_HOME/bin/javaws \
           $JAVA_HOME/bin/jjs \
           $JAVA_HOME/bin/keytool \
           $JAVA_HOME/bin/orbd \
           $JAVA_HOME/bin/pack200 \
           $JAVA_HOME/bin/policytool \
           $JAVA_HOME/bin/rmid \
           $JAVA_HOME/bin/rmiregistry \
           $JAVA_HOME/bin/servertool \
           $JAVA_HOME/bin/tnameserv \
           $JAVA_HOME/bin/unpack200 \
           $JAVA_HOME/lib/amd64/libdecora_sse.so \
           $JAVA_HOME/lib/amd64/libprism_*.so \
           $JAVA_HOME/lib/amd64/libfxplugins.so \
           $JAVA_HOME/lib/amd64/libglass.so \
           $JAVA_HOME/lib/amd64/libgstreamer-lite.so \
           $JAVA_HOME/lib/amd64/libjavafx*.so \
           $JAVA_HOME/lib/amd64/libjfx*.so \
           $JAVA_HOME/lib/deploy* \
           $JAVA_HOME/lib/desktop \
           $JAVA_HOME/lib/ext/nashorn.jar \
           $JAVA_HOME/lib/ext/jfxrt.jar \
           $JAVA_HOME/lib/*javafx* \
           $JAVA_HOME/lib/javaws.jar \
           $JAVA_HOME/lib/jfr.jar \
           $JAVA_HOME/lib/jfr \
           $JAVA_HOME/lib/*jfx* \
           $JAVA_HOME/lib/oblique-fonts \
           $JAVA_HOME/lib/plugin.jar \
           $JAVA_HOME/plugin \
        && apk del tar ca-certificates wget\   
        && ln -s $JAVA_HOME/bin/* /usr/bin/ \
        && ls -ltr /usr/bin 
ENV JAVA_HOME /opt/jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin