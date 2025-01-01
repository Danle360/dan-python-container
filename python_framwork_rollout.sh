#!/bin/bash
mss_pod_app="python-app-pod"
imageName="danle360/python-dan-framwork:v$BUILD_NUMBER"

sleep 50s

if [[ $(kubectl -n python-ns get deploy ${mss_pod_app} --timeout 5s) = *"successfully rolled out"* ]];
then
	echo "Deployment ${mss_pod_app} was successful"
    exit 0;
else
	echo "mss pod Dployment ${mss_pod_app} exist"
	echo "Here is the image: ${imageName}"
	#kubectl -n python-ns rollout undo deploy ${deploymentName}
fi

#
# if [[ $(kubectl -n python-ns rollout status deploy ${deploymentName} --timeout 5s) != *"successfully rolled out"* ]];
# then
# 	echo "Deployment ${deploymentName} Rollout has Failed"
#     kubectl -n python-ns rollout undo deploy ${deploymentName}
#     exit 1;
# else
# 	echo "Deployment ${deploymentName} Rollout is Success"
# fi
