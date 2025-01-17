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

# TODO(frec): rename: run_kokoro_tests.sh

pip3 install --requirement "requirements.txt"

#TODO(frec): re-enable quantization/keras:quantize_models_test
bazel test \
  --test_verbose_timeout_warnings \
  //tensorflow_model_optimization/python/core/... \
  -- \
  -//tensorflow_model_optimization/python/core/quantization/keras:quantize_models_test


# //tensorflow_model_optimization/python/core/sparsity/keras:prune_test
