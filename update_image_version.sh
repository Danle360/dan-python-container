#!/bin/bash
imageVersion="danle360/python-dan-framwork:v$BUILD_NUMBER"
sed -i "s#image_version_update#${imageVersion}#g" java_web_manifestFile.yml
cat java_web_manifestFile.yml |grep  'danle'
