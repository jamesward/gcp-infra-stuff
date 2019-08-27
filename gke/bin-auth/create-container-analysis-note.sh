#!/bin/bash

source variables.sh
PROJECT_ID=`gcloud config get-value project`


# Create Container Analisys note

# Create a JSON file in /tmp/note_payload.json that describes the Container Analysis note
cat > /tmp/note_payload.json << EOM
{
  "name": "projects/${PROJECT_ID}/notes/${NOTE_ID}",
  "attestation_authority": {
    "hint": {
      "human_readable_name": "Attestor Note"
    }
  }
}
EOM

cat /tmp/note_payload.json 

#Create the note by sending an HTTP request to the Container Analysis REST API

echo "curl -X POST \
    -H Content-Type: application/json \
    -H Authorization: Bearer $(gcloud auth print-access-token)  \
    --data-binary @/tmp/note_payload.json  \
    https://containeranalysis.googleapis.com/v1beta1/projects/${PROJECT_ID}/notes/?noteId=${NOTE_ID}"

curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $(gcloud auth print-access-token)"  \
    --data-binary @/tmp/note_payload.json  \
    "https://containeranalysis.googleapis.com/v1beta1/projects/${PROJECT_ID}/notes/?noteId=${NOTE_ID}"


# Verify that the node was created
echo "curl \
-H Authorization: Bearer $(gcloud auth print-access-token) \
https://containeranalysis.googleapis.com/v1beta1/projects/${PROJECT_ID}/notes/${NOTE_ID}"

curl \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
"https://containeranalysis.googleapis.com/v1beta1/projects/${PROJECT_ID}/notes/${NOTE_ID}"


