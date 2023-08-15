# generated and modified from ./gradlew dockerFile
# root Dockerfile must be removed for ./gradlew dockerFile to work
FROM amazoncorretto:17-alpine

WORKDIR /home/app

# ssh setup for azure
RUN apk add openssh \
     && echo "root:Docker!" | chpasswd
RUN /usr/bin/ssh-keygen -A
COPY sshd_config /etc/ssh/

# new relic
RUN wget https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip \
     && unzip -j "newrelic-java.zip" "newrelic/newrelic.jar"
ENV JAVA_OPTS="$JAVA_OPTS -javaagent:newrelic.jar"
ADD ./newrelic.yml newrelic.yml

