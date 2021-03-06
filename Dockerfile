FROM jenkins/jenkins:lts-jdk11 as RUNTIME

#RUN mkdir $JENKINS_HOME/configs
#COPY ./jenkins.yaml $JENKINS_HOME/configs/jenkins.yaml
#ENV CASC_JENKINS_CONFIG=$JENKINS_HOME/configs

ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

ENV JENKINS_OPTS --httpPort=-1 --httpsPort=8686
ENV JENKINS_SLAVE_AGENT_PORT 50000

RUN unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy \
  && /usr/local/bin/install-plugins.sh \
#  groovy-events-listener-plugin:latest \ # warning about groovy version
  configuration-as-code \
  configuration-as-code-support \
  blueocean \
  job-dsl \
  cloudbees-folder \
  workflow-aggregator \
  pipeline-utility-steps \
  generic-webhook-trigger \
  git-changelog

RUN apt-get update && apt-get install -y ruby make 

COPY files/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# drop back to the regular jenkins user - good practice
USER jenkins

EXPOSE 8686 50000
