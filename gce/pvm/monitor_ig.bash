#!/bin/bash
instance_group="instance-group-1-test"
region="us-east4"
target_number=90
new_number=90
sleep_time=60
while true
do	
	current_number=`gcloud compute instance-groups managed list-instances ${instance_group} --region ${region} | grep -v NAME | grep RUNNING | wc -l | sed 's/ //g'`
	
	if [ ${current_number} -lt ${target_number} ] ; then 
		new_number=`python /usr/bin/calc_ig.py -a ${target_number} -b ${current_number}` 
	fi	

	gcloud compute instance-groups managed resize ${instance_group} --size=${new_number} --region ${region} 
	
	sleep ${sleep_time}

done