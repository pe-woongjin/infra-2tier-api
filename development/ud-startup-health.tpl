#!/bin/bash

# userdata script for AIP installation

# runuser -l ec2-user -c 'java -jar /home/ec2-user/health-api.jar &'
nohup java -jar /home/ec2-user/health-api.jar > /dev/null &

