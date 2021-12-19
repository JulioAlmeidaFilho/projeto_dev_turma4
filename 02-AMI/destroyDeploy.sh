#!/bin/bash

# -- Variaveis AWS
uri='ssh -i /home/ubuntu/.ssh/id_rsa ubuntu@52.67.249.96'

export TF_VAR_vpcId=$($uri 'aws --region sa-east-1 ec2 describe-vpcs --filters Name=tag:Name,Values=vpc-Team4-JB --query "Vpcs[*].VpcId" --output text')
export TF_VAR_subnetIdPrivA=$($uri 'aws --region sa-east-1 ec2 describe-subnets --filters "Name=vpc-id,Values=$TF_VAR_vpcId" "Name=tag:Name,Values=*Priv_1a" --query "Subnets[*].SubnetId" --output text')
# -- 

cd 02-AMI/terraform
terraform destroy -auto-approve
