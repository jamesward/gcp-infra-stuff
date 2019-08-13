#!/bin/bash -x

gcloud beta compute --project=run-intro firewall-rules create allow-ssh \
--direction=INGRESS \
--priority=900 \
--network=default \
--action=ALLOW \
--rules=tcp:22 \
--source-ranges=0.0.0.0/0 \
--enable-logging