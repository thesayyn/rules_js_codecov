#!/usr/bin/env bash

# NOTE: This script is not necessary for CI to work.
if [ ! -x codecov ]; then
    curl -Os https://uploader.codecov.io/latest/macos/codecov
    chmod +x codecov
fi

if [ ! ${CODECOV_TOKEN:-} ]; then
    echo "CODECOV_TOKEN env var has to be present."
fi 

bazel coverage //...

rm -rf coverage
mkdir -p coverage
cp bazel-out/_coverage/_coverage_report.dat coverage/coverage.info

./codecov --dir coverage