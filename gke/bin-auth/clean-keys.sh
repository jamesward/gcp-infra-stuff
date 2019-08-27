#!/bin/bash

source variables

gpg --delete-secret-keys "${ATTESTOR}@example.com"
gpg --delete-keys "${ATTESTOR}@example.com"

gpg --delete-secret-keys "${ATTESTOR}@example.com"
gpg --delete-keys "${ATTESTOR}@example.com"

gpg --delete-secret-keys "${ATTESTOR}@example.com"
gpg --delete-keys "${ATTESTOR}@example.com"

gpg --delete-secret-keys "${ATTESTOR}@example.com"
gpg --delete-keys "${ATTESTOR}@example.com"


PUBKEY=`gcloud beta container binauthz attestors  describe test-attestor | grep "id:" | tail -1 | awk '{print $2}'``
gcloud beta container binauthz attestors public-keys remove $PUBKEY --attestor=test-attestor

PUBKEY=`gcloud beta container binauthz attestors  describe test-attestor | grep "id:" | tail -1 | awk '{print $2}'``
gcloud beta container binauthz attestors public-keys remove $PUBKEY --attestor=test-attestor

PUBKEY=`gcloud beta container binauthz attestors  describe test-attestor | grep "id:" | tail -1 | awk '{print $2}'``
gcloud beta container binauthz attestors public-keys remove $PUBKEY --attestor=test-attestor