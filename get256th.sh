#!/bin/bash

source /Users/jonjagger/Applications/google-cloud-sdk/path.bash.inc

readonly PROJECT=cyber-dojo
readonly INSTANCE=ssd-server
readonly ZONE=europe-west1-b

echo "creating katas_$1.tgz on server..."
gcloud compute --project "${PROJECT}" ssh --zone "${ZONE}" "${INSTANCE}" \
  --command "sudo ./backup256th.sh $1"

echo "copying katas_$1.tgz off server..."
gcloud compute --project "${PROJECT}" scp --zone "${ZONE}" \
  jonjagger@${INSTANCE}:/home/jonjagger/katas_$1.tgz .

echo "removing katas_$1.tgz from server..."
gcloud compute --project "${PROJECT}" ssh --zone "${ZONE}" "${INSTANCE}" \
  --command "rm ./katas_$1.tgz"
