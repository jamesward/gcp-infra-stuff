#!/usr/bin/env python

import os, sys, getopt

def main(argv):
	skip_menu = False

	try:
		opts, args = getopt.getopt(argv,"p:")
	except getopt.GetoptError:
		sys.exit(42)
	for opt, arg in opts:
		if opt == '-p':
			choice = int(arg)
			skip_menu = True
    

	projectsListFile = "/Users/amiteinav/Downloads/projects.txt"

	print ("\ndata file is " + projectsListFile + "\n")

	i = 0

	with open(projectsListFile,"r") as f:
		data = f.readlines()

	#f=open(projectsListFile,"r")
	for line in data:
		words = str(line.split())
		i = str(i)
		option = "[" + i + "] " + words +"."
		print(option)
		i = int(i)
		i+=1

	print ("[99] exit")

	if ( not skip_menu):
		choice = raw_input("Choose a project: ")
		choice = int(choice)

	if choice == 99:
		print "Bye!"
		exit()

	#print lines[0]


	file = open(projectsListFile,"r")
	lines = file.readlines()

	string = "You chose " + lines[choice]

	print (string)

	cli = "gcloud config set project " + lines[choice]
	string = "Running: " + cli 

	print (string)
	os.system(cli)


	cli = "gcloud auth list"

	os.system(cli)


if __name__ == "__main__":
  script_name=sys.argv[0]
  arguments = len(sys.argv) - 1
  main(sys.argv[1:])

