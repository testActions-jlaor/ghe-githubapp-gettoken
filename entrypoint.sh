#!/bin/bash

set -e

if [[ -z "${GITHUB_PRIVATE_KEY}" ]]; then
  echo "This GitHub Action requires the GITHUB_PRIVATE_KEY env variable."
  exit 1
fi

if [[ -z "${GITHUB_APP_IDENTIFIER}" ]]; then
  echo "This GitHub Action requires the GITHUB_APP_IDENTIFIER env variable."
  exit 1
fi


python3 /get_token.py ${INPUT_ARGS}
