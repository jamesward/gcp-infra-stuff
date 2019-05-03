# gcp-infra-stuff

## Getting the Goodies ##

### Pre-requisite for running the scripts ###

* install few updates and stuff..

```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install git -y 
pip install --user --upgrade google-api-python-client 

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py

```
* get the files using this command:
```
git clone https://github.com/amiteinav/image-processing.git
```

## Preemptible VMs ##

### Making sure to have enough preemptible VMs on your Managed Instance Group ###
Google Cloud's [Preemptible VMs](https://cloud.google.com/preemptible-vms) are awesome - if you have a stateless workload, you should definitely try these out.  


There are two scripts to use - **pvm/calc_ig.py** and **pvm/monitor_ig.bash** 


The logic is to check every 60 seconds if a managed instances group of Preemptible VMs is as big as it should be and enlarging it based on the ratio of the lacking.

Once the group is too big, it is bringing it back to the regular size. So if you have 60 pre-emptible VMs out of 90 pre-emptible, the script will add 45 more (1/(60/90)x90).


In GCP we implement that using a startup script on a small server that runs in an instance group in three separate regions that should suffice for 100% availability 


## Counting lines in python - count_lines.py

In the file **count_lines.py** there are **Functions to count lines**

**bufcount** took 5401.664 ms for 35M rows whilw **simplecount** took 3287.357 ms for 35M rows

targetting a 35M rows and getting a specific line took 15560.325 ms with this command:
```
print linecache.getline(filename, line_no)
```

the file **create_lines.bash** is a super-simple bash script that i used to create non-random lines

