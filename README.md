# gcp-infra-stuff


## Counting lines in python - count_lines.py

In the file **count_lines.py** there are **Functions to count lines**

**bufcount** took 5401.664 ms for 35M rows
**simplecount** took 3287.357 ms for 35M rows

targetting a 35M rows and getting a specific line took 15560.325 ms with this command:
```
print linecache.getline(filename, line_no)
```
