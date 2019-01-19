# gcp-infra-stuff


## Counting lines in python

in the file **count_lines.py** i have:

**Functions to count lines**

**bufcount** took 5401.664 ms for 35M rows
**simplecount** took 3287.357 ms for 35M rows


getting a specific line took 15560.325 ms :
```
print linecache.getline(filename, line_no)
```
