#!/bin/bash

source variables.sh

gpg --batch --gen-key <(
  cat <<- EOF
    Key-Type: RSA
    Key-Length: 2048
    Name-Real: "Test Attestor"
    Name-Email: "${ATTESTOR}@example.com"
    %commit
EOF
)

export FINGERPRINT=`gpg --list-keys "${ATTESTOR}@example.com" | grep pub -A1 | grep -v pub | awk '{print $1}'`