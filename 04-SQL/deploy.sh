#!/bin/bash

# -- Variaveis AWS
uri='ssh -i /var/lib/jenkins/.ssh/id_rsa ubuntu@52.67.249.96'

export TF_VAR_vpcId=$($uri 'aws --region sa-east-1 ec2 describe-vpcs --filters Name=tag:Name,Values=vpc-Team4-JB --query "Vpcs[*].VpcId" --output text')
export TF_VAR_subnetPrivada=$($uri 'aws --region sa-east-1 ec2 describe-subnets --filters "Name=vpc-id,Values='$TF_VAR_vpcId'" "Name=tag:Name,Values=*Priv*" --query "Subnets[1].SubnetId" --output text')
export TF_VAR_keyPrivate='jb-key'
export TF_VAR_amiId='ami-0e66f5495b4efdd0f'

echo $TF_VAR_vpcId
echo $TF_VAR_subnetPrivada
echo $TF_VAR_keyPrivate
echo $TF_VAR_amiId
# --