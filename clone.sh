#!/bin/sh
set -euo pipefail
set -x

: "${BRIGADE_WORKSPACE:=/src}"
: "${BRIGADE_REMOTE_URL:?}"
: "${BRIGADE_COMMIT_ID:?}"

if sha=$(git ls-remote --exit-code "${BRIGADE_REMOTE_URL}" "${BRIGADE_COMMIT_ID}" | cut -f1); then
  BRIGADE_COMMIT_ID="${sha}"
fi

git clone --depth=50 "${BRIGADE_REMOTE_URL}" "${BRIGADE_WORKSPACE}"
cd "${BRIGADE_WORKSPACE}"

git fetch origin "${BRIGADE_COMMIT_ID}"
git checkout -qf FETCH_HEAD
git reset --hard -q "${BRIGADE_COMMIT_ID}"

if [ "${BRIGADE_SUBMODULES:=}" = "true" ]; then
    git submodule update --init --recursive
fi
