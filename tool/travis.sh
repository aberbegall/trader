#!/bin/bash

# Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

# Fast fail the script on failures.
set -e

# Verify that the libraries are error free.
echo "Analyzing sorces..."
dartanalyzer --fatal-warnings \
  bin/main.dart \
  lib/src/marketData.dart \
  test/all_tests.dart

# Run the tests.
echo "Running tests..."
dart test/all_tests.dart

# Install dart_coveralls; gather and send coverage data.
if [ "$COVERALLS_TOKEN" ]; then
  echo "Installing coveralls..."
  pub global activate dart_coveralls
  echo "Running coverage..."
  pub global run dart_coveralls report \
    --retry 2 \
    --exclude-test-files \
    --debug \
    test/all_tests.dart
  echo "Coverage complete."
fi
