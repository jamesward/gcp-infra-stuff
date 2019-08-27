#!/bin/bash

# set variables
source variables.sh

# Create the attestor

echo "gcloud beta container binauthz attestors create ${ATTESTOR} \
--attestation-authority-note=${NOTE_ID} \
--attestation-authority-note-project=${PROJECT_ID}"

gcloud beta container binauthz attestors create ${ATTESTOR} \
--attestation-authority-note=${NOTE_ID} \
--attestation-authority-note-project=${PROJECT_ID}

# Verify that the attestor was created
echo "gcloud beta container binauthz attestors list"
gcloud beta container binauthz attestors list
