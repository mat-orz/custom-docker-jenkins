#!/bin/bash
file="/jenkinsready"

while true
do
if [ -f "$file" ]
	then
		echo "$file found. Launching jenkins"
		/sbin/tini -- /usr/local/bin/jenkins-init.sh
	else
		echo "$file not found."
		sleep 3
	fi
done
