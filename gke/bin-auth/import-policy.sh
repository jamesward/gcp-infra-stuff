#!/bin/bash

source variables

cat > /tmp/policy.yaml << EOM
    admissionWhitelistPatterns:
    - namePattern: gcr.io/google_containers/*
    - namePattern: gcr.io/google-containers/*
    - namePattern: k8s.gcr.io/*
    - namePattern: gcr.io/stackdriver-agents/*
    defaultAdmissionRule:
      evaluationMode: REQUIRE_ATTESTATION
      enforcementMode: ENFORCED_BLOCK_AND_AUDIT_LOG
      requireAttestationsBy:
        - projects/${PROJECT_ID}/attestors/${ATTESTOR}
    name: projects/${PROJECT_ID}/policy
EOM

echo "gcloud beta container binauthz policy import example-policy.yaml"
gcloud beta container binauthz policy import /tmp/policy.yaml

echo "gcloud beta container binauthz policy export"
gcloud beta container binauthz policy export
