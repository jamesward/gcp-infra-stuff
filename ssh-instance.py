#!/usr/bin/python

import os, sys, getopt, google.cloud 
import googleapiclient.discovery
from google.cloud import resource_manager


def message(msg, level="Info"):
  logfile = '/tmp/ssh-instance.log'
  now = datetime.datetime.now()
  time =  now.isoformat()
  str = level + "|" + time + "|" + msg + "\n"
  with open(logfile, "a") as myfile:
    myfile.write(str)
    myfile.close()
  if (level == "Error"):
    print (str)

def list_instances(compute, project, zone):
    #result = compute.instances().list(project=project, zone=zone).execute()
    result = compute.instances().list(project=project).execute()
    return result['items'] if 'items' in result else None

def main(argv):
    
	is_list_instances = False
	try:
		opts, args = getopt.getopt(argv,"li:p:z:")
	except getopt.GetoptError:
		sys.exit(42)
	for opt, arg in opts:
		if opt == "-l":
			is_list_instances = True
		elif opt == "-i":
			instance = arg
		elif opt == "-p":
			project = arg
		elif opt == "-z":
			zone = arg

	#compute = googleapiclient.discovery.build('compute', 'v1')

	import subprocess
	import commands
	status, output = commands.getstatusoutput("gcloud compute instances list --format=csv")

	for line in output:
		print line
		print ' '

	#proc = subprocess.Popen(['gcloud compute instances list --format=csv(name,zone)'], stdout=subprocess.PIPE, shell=True)
	#(out, err) = proc.communicate()
	#print "program output:", out

	#if (list_instances):
	#	instances=os.system('gcloud compute instances list --format="csv(name,zone)"')
		#instances = list_instances(compute, project, zone)

		#client = resource_manager.Client()

		# List all projects you have access to
		#client = resource_manager.Client()
    		#for project_name in client.list_projects():
        		#print (project_name.project_id)

		#for instance in instances:
		#	print('instance: {}, zone: {}'.format(instance['name'], instance['zone'].split('/')[-1]))


if __name__ == "__main__":
    script_name=sys.argv[0]
    arguments = len(sys.argv) - 1

    if (arguments == 0):
        sys.exit(42)

    main(sys.argv[1:])
