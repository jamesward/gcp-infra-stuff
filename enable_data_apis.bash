#!/bin/bash

# This should enable all APIs that are relevant to data products

export PROJECT=$DEVSHELL_PROJECT_ID
gcloud services enable --project $PROJECT composer.googleapis.com &
gcloud services enable --project $PROJECT bigtable.googleapis.com &
gcloud services enable --project $PROJECT bigtableadmin.googleapis.com &
gcloud services enable --project $PROJECT compute.googleapis.com &
gcloud services enable --project $PROJECT bigquery-json.googleapis.com &
gcloud services enable --project $PROJECT dataproc.googleapis.com &
gcloud services enable --project $PROJECT cloudmonitoring.googleapis.com &
gcloud services enable --project $PROJECT pubsub.googleapis.com &
gcloud services enable --project $PROJECT storage-api.googleapis.com &
gcloud services enable --project $PROJECT dataflow.googleapis.com &
gcloud services enable --project $PROJECT drive.googleapis.com &
gcloud services enable --project $PROJECT stackdriver.googleapis.com &
gcloud services enable --project $PROJECT logging.googleapis.com &
gcloud services enable --project $PROJECT monitoring.googleapis.com &
gcloud services enable --project $PROJECT spanner.googleapis.com &
gcloud services enable --project $PROJECT datafusion.googleapis.com &
