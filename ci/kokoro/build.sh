#!/bin/bash

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Fail on any error.
set -e

# Display commands being run.
# WARNING: please only enable 'set -x' if necessary for debugging, and be very
#  careful if you handle credentials (e.g. from Keystore) with 'set -x':
#  statements like "export VAR=$(cat /tmp/keystore/credentials)" will result in
#  the credentials being printed in build logs.
#  Additionally, recursive invocation with credentials as command-line
#  parameters, will print the full command, with credentials, in the build logs.
# set -x

capture_test_logs() {
  # based on http://cs/google3/third_party/fhir/kokoro/common.sh?rcl=211854506&l=18
  mkdir -p "$KOKORO_ARTIFACTS_DIR"
  # copy all test.log and test.xml files to the kokoro artifacts directory
  find -L bazel-testlogs -name "test.log" -o -name "test.xml" -exec cp --parents {} "$KOKORO_ARTIFACTS_DIR" \;
  # Rename the copied test.log and test.xml files to sponge_log.log and sponge_log.xml
  find -L "$KOKORO_ARTIFACTS_DIR" -name "test.log" -exec rename 's/test.log/sponge_log.log/' {} \;
  find -L "$KOKORO_ARTIFACTS_DIR" -name "test.xml" -exec rename 's/test.xml/sponge_log.xml/' {} \;
}

# Run capture_test_logs when the script exits
trap capture_test_logs EXIT

pip3 install --requirement "requirements.txt"

bazel test --python_path=$PYTHON_BIN --test_verbose_timeout_warnings //tensorflow_model_optimization/python/core/...
