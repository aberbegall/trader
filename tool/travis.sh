#!/bin/bash

# Fast fail the script on failures, it causes the script to exit as soon as one command returns a non-zero exit code.
set -e

# Verify that the libraries are error free.
dartanalyzer --fatal-warnings \
  bin/main.dart \
  lib/src/marketData.dart \
  test/all_tests.dart

# Run the tests.
dart test

# Install dart_coveralls; gather and send coverage data.
if [ "$COVERALLS_TOKEN" ]; then
    echo "Executing coverage and updating to coveralls..."
    pub global activate dart_coveralls
    pub global run dart_coveralls report \
        --token $COVERALLS_TOKEN \
        --retry 2 \
        --exclude-test-files \
        test/all_tests.dart
fi