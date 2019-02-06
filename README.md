# gcp-infra-stuff

## Pre-requisite for running the scripts ##

```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install git -y 
pip install --user --upgrade google-api-python-client 

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py

```

## getting the goodies ##

* get the files using this command:
```
git clone https://github.com/amiteinav/image-processing.git
```

## Counting lines in python - count_lines.py

In the file **count_lines.py** there are **Functions to count lines**

**bufcount** took 5401.664 ms for 35M rows whilw **simplecount** took 3287.357 ms for 35M rows

targetting a 35M rows and getting a specific line took 15560.325 ms with this command:
```
print linecache.getline(filename, line_no)
```

the file **create_lines.bash** is a super-simple bash script that i used to create non-random lines

