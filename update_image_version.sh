#!/bin/bash
imageVersion="danle360/python-dan-framwork:v$BUILD_NUMBER"
sed -i "s#image_version_update#${imageVersion}#g" framwork-deployment.yml
cat framwork-deployment.yml |grep  'danle'
