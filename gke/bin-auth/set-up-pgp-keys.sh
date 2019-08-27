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

#capture the fingerprint
export FINGERPRINT=`gpg --list-keys "${ATTESTOR}@example.com" | grep pub -A1 | grep -v pub | tail -1 | awk '{print $1}'`

#export the piblic key
gpg --armor --export ${FINGERPRINT} > /tmp/generated-key.pgp

# Cleanup commands
#gpg --delete-keys "test-attestor@example.com"
#gpg --delete-secret-keys "test-attestor@example.com"