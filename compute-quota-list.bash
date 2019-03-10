#!/bin/bash

# This script if for running across all regions and getting quotas limits and how close they are to be breached

gcloud compute regions list --format="table(description,quotas:format='table(metric,limit,usage)')"

