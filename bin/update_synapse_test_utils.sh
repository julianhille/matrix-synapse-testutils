#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
WORK_DIR="$(pwd)"
BUILD_DIR="${SCRIPT_DIR}/../build/"
SYNAPSE_BUILD_TEST="${BUILD_DIR}/synapse"
SRC_NAME='matrix_synapse_testutils'
OUTPUT_DIR="${SCRIPT_DIR}/../${SRC_NAME}/"
VERSION=${1:-1.68.0}

echo 'Building test package for Synapse: '$VERSION

if [ -d "${SYNAPSE_BUILD_TEST}" ]; then
 mkdir -p "${BUILD_DIR}"
fi

if [ -d "${SYNAPSE_BUILD_TEST}" ]; then
  rm -R "${SYNAPSE_BUILD_TEST}"
fi

mkdir -p "${SYNAPSE_BUILD_TEST}"

echo 'Downloading ...'
python -m pip download matrix-synapse=="${VERSION}" --no-binary=matrix-synapse --no-deps -d "${BUILD_DIR}"

echo 'Unpacking ...'
tar -C "${SYNAPSE_BUILD_TEST}" --strip-components 2 -xvzf "${BUILD_DIR}"/*-"${VERSION}.tar.gz" --wildcards "*-${VERSION}/tests/"

echo 'Syncing files'
rsync -zarhv --delete --delete-excluded \
  --include="*/" \
  --include='/unittest.py' \
  --include='/__init__.py' \
  --include='/server.py' \
  --include='utils.py' \
  --include='/test_utils/*' \
  --exclude="*" \
  --prune-empty-dirs \
  "${BUILD_DIR}/synapse/" "${OUTPUT_DIR}"

echo 'Patching files ...'
find "${OUTPUT_DIR}" -type f -name "*.py" -print0 | xargs -0 sed -E -i 's/(from|import) tests/\1 '${SRC_NAME}'/g'

echo 'Add init py to included directories'
find "${OUTPUT_DIR}" -type d -exec touch {}/"__init__.py"  \;