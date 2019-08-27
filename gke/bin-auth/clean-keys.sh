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
