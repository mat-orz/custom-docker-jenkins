#!/bin/bash
set -x
python --version
usermod -a -G jenkins jenkins
groupadd root_host -g $(ls -la /var/run/docker.sock | awk '{ print $4 }')
usermod -a -G $(ls -la /var/run/docker.sock | awk '{ print $4 }') jenkins
id jenkins
chown -R jenkins:jenkins /var/jenkins_home 

su -c /usr/local/bin/jenkins.sh jenkins
