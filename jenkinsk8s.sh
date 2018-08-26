#!/usr/bin/env/ bash


set -ev

 echo "Start of jenkins script and exports variables"
runk8sdeploy() {

  export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY}"
  export AWS_SECRET_KEY_ID="${AWS_SECRET_KEY}"
  export region="${REGION}"


  echo "create cluster"
  sudo kops create cluster --node-count=2 --node-size=t2.micro --master-size=t2.micro  --zones=eu-west-1a --name=lms.k8s.local --state=s3://lms-test-state

  sudo kops update cluster --name=${KOPS_CLUSTER_NAME} --yes

  echo "Cluster created and updated "
  sudo docker login -u idreeskun -p ${DOCKER_HUB}

  echo "deploy docker app to cluster"
  sudo kubectl run sample-deployment --image=idreeskun/payment:latest --replicas=2 --port=80

  sudo kubectl expose deployment sample-deployment --port=80 --type=LoadBalancer

  sudo kubectl get services -o wide
}


run() {
  runk8sdeploy
}

run