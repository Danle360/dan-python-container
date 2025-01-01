#!/bin/bash

#k8s-deployment.sh
mss_pod_app="python-app-pod"
mss_con_app="python-app-con"
serviceName="python-app-svc"
#imageName="eagunuworld/numeric-app:docker pull eagunuworld/numeric-app:ddba18bd401f3eeb0ee097eb56dd8f76d1953e0b"
imageName="danle360/python-dan-framwork:v$BUILD_NUMBER"

#sed -i "s#replace#${imageName}#g" k8s_deployment_service.yaml
echo $mss_pod_app
echo $mss_con_app
echo $serviceName
echo $imageName
#kubectl create ns python-app-prod
kubectl -n ibm-ucd get deploy ${mss_pod_app} > /dev/null

if [[ $? -ne 0 ]]; then
    echo "mss pod Dployment ${mss_pod_app} doesn't exist,Appying kubectl commands"
    kubectl -n ibm-ucd apply -f framwork-deployment.yml
else
echo "Deploying latest version while older version is up and running"
 kubectl -n ibm-ucd apply -f framwork-deployment.yml
fi
