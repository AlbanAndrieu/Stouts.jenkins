# This file was generated by ansible for {{ansible_fqdn}}
# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
#FROM        ubuntu:latest
FROM        ubuntu:14.04

# Volume can be accessed outside of container
VOLUME      [/var/lib/jenkins]

MAINTAINER  Alban Andrieu "https://github.com/AlbanAndrieu"

ENV			DEBIAN_FRONTEND noninteractive
ENV         JENKINS_HOME /var/lib/jenkins
ENV         WORKDIR /home/vagrant
ENV         ANSIBLE_LIBRARY {{ docker_working_directory }}/library
ENV         PYTHONPATH {{ docker_working_directory }}/lib:$PYTHON_PATH
ENV         PATH {{ docker_working_directory }}/bin:/sbin:/usr/sbin:/usr/bin:/bin:$PATH

# Working dir
WORKDIR /home/vagrant

# Because docker replaces /sbin/init: https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl

# Make sure the package repository is up to date.
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
#RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get clean && apt-get -y update

RUN         pwd
RUN         ls -lrta

ADD roles $WORKDIR/roles

RUN ls -lrta $WORKDIR/roles/*

#ADD defaults $WORKDIR/ansible-jenkins-master/defaults
#ADD meta $WORKDIR/ansible-jenkins-master/meta
#ADD files $WORKDIR/ansible-jenkins-master/files
##ADD handlers $WORKDIR/ansible-jenkins-master/handlers
#ADD tasks $WORKDIR/ansible-jenkins-master/tasks
#ADD templates $WORKDIR/ansible-jenkins-master/templates
#ADD vars $WORKDIR/ansible-jenkins-master/vars

# Here we continue to use add because
# there are a limited number of RUNs
# allowed.
ADD hosts /etc/ansible/hosts
ADD jenkins-master.yml $WORKDIR/jenkins-master.yml

# Install ansible
RUN apt-get install -y python-dev python-yaml python-jinja2 git unzip python-pip
RUN pip install paramiko PyYAML jinja2 httplib2 boto && pip install ansible
#RUN git clone http://github.com/ansible/ansible.git {{ docker_working_directory }}
#RUN mkdir {{ docker_working_directory }}

# Install JDK 7 (latest edition)
#RUN apt-get install -y --no-install-recommends openjdk-7-jdk

# Add user jenkins to the image
#RUN         adduser --quiet jenkins --home {{ jenkins_home }}
# Set password for the jenkins user (you may want to alter this).
#RUN         echo jenkins:jenkins | chpasswd

# Execute
RUN         pwd
RUN         ls -lrta
RUN         ansible-playbook $WORKDIR/jenkins-master.yml -c local -vvvv

# Install a basic SSH server
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
#RUN         apt-get update && \
#            apt-get install -y openssh-server openjdk-7-jre-headless

# Clean up APT when done.
RUN         apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Standard SSH port
#EXPOSE      22
# Standard MySQL port for Sonar
#EXPOSE      3306

#TODO improve below port range
EXPOSE 21:9999
ENTRYPOINT  ["/etc/init.d/jenkins", "start"]
CMD ["-g", "deamon off;"]
#CMD ["/usr/sbin/sshd", "-D"]
