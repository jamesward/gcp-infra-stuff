#!/bin/bash

# set variables
source variables.sh
PROJECT_ID=`gcloud config get-value project`

# Create the attestor

echo "gcloud beta container binauthz attestors create ${ATTESTOR} \
--attestation-authority-note=${NOTE_ID} \
--attestation-authority-note-project=${PROJECT_ID}"

gcloud beta container binauthz attestors create ${ATTESTOR} \
--attestation-authority-note=${NOTE_ID} \
--attestation-authority-note-project=${PROJECT_ID}