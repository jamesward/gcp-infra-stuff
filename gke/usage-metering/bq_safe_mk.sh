#!/bin/bash

# this is how you call the function
#bash bq_safe_mk.sh dataset-name

    dataset=$1
    exists=$(bq ls -d | grep -w $dataset)
    if [ -n "$exists" ]; then
       echo "Not creating $dataset since it already exists"
    else
       echo "Creating $dataset"
       bq mk $dataset
    fi

