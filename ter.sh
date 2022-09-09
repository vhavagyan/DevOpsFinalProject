#!/bin/bash

#default variables
#for apply type "apply", for destroy type "destroy"


task=apply

#=====================================================


#terraform -chdir=/home/levon/main/terraform_ec2 init
apply () { 
terraform -chdir=/home/levon/main/terraform_final apply -auto-approve  

#terraform -chdir=terraform apply -auto-approve
}


destroy () {
terraform -chdir=/home/levon/main/terraform_final destroy -auto-approve 

}



if [[ $task = apply ]]
 then apply 
 echo "Creating done"

 else destroy 
 echo "Destroying complete"

fi 

errcode=$?
if [[ $errcode != 0 ]]
then
	echo "error creating infrastructure"
	exit $errcode
else 
       echo "all ok"

fi

#=====================================================
#check connection

check () {
sudo ansible /home/levon/main/ansible/hosts -m ping
}
check


run_playbook () {
ansible-playbook /home/levon/main/ansible/playbook2.yaml 
}

if [[ $? = 0 ]]
then
        echo "Unreacheble"
        exit 1 
else 
       echo "status up"
       then run_playbook

fi

