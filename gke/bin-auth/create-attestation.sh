#!/bin/bash

source variables

IMAGE_PATH="gcr.io/google-samples/hello-app"
IMAGE_DIGEST="sha256:c62ead5b8c15c231f9e786250b07909daf6c266d0fcddd93fea882eb722c3be4"

echo "gcloud beta container binauthz create-signature-payload \
--artifact-url=${IMAGE_PATH}@${IMAGE_DIGEST} > /tmp/generated_payload.json"

gcloud beta container binauthz create-signature-payload \
--artifact-url=${IMAGE_PATH}@${IMAGE_DIGEST} > /tmp/generated_payload.json

echo "cat /tmp/generated_payload.json"
cat /tmp/generated_payload.json

echo "gpg \
    --local-user ${ATTESTOR}@example.com \
    --armor \
    --output /tmp/generated_signature.pgp \
    --sign /tmp/generated_payload.json"

gpg \
    --local-user "${ATTESTOR}@example.com" \
    --armor \
    --output /tmp/generated_signature.pgp \
    --sign /tmp/generated_payload.json

echo "gcloud beta container binauthz attestations create \
    --artifact-url=${IMAGE_PATH}@${IMAGE_DIGEST} \
    --attestor=projects/${PROJECT_ID}/attestors/${ATTESTOR} \
    --signature-file=/tmp/generated_signature.pgp \
    --pgp-key-fingerprint=${FINGERPRINT}"

gcloud beta container binauthz attestations create \
    --artifact-url="${IMAGE_PATH}@${IMAGE_DIGEST}" \
    --attestor="projects/${PROJECT_ID}/attestors/${ATTESTOR}" \
    --signature-file=/tmp/generated_signature.pgp \
    --pgp-key-fingerprint="${FINGERPRINT}"

echo "gcloud beta container binauthz attestations list \
    --attestor=$ATTESTOR --attestor-project=$PROJECT_ID"

gcloud beta container binauthz attestations list \
    --attestor=$ATTESTOR --attestor-project=$PROJECT_ID