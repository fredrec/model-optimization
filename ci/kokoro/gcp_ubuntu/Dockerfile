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

# An image for building prerequisites for testing TensorFlow Model Optimization
# on ubuntu.
#
# TODO(b/185727356): generalize to different versions of TensorFlow to
# run CI against.
#
#  Build as follows:
#  docker build --tag={TAG} /path/to/directory/with/this/file
#
#  Run interactively as follows, where WORKDIR is the root directory
#  of the tensorflow model optimization Github repository.
#
#  docker run -it --volume "${WORKDIR}:/usr/src/tfmot" {TAG}


# Latest Ubuntu LTS (Focal), at the moment.
FROM ubuntu:20.04


ARG BAZEL_VERSION=4.2.2
ARG TENSORFLOW_VERSION=2.7.0


RUN apt-get update -y

# Install Python3 and set it as default
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
   python3 \
   python3-pip \
   && update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Install Bazel.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y unzip zip wget \
   && wget -O bazel-installer.sh "https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION?}/bazel-${BAZEL_VERSION?}-installer-linux-x86_64.sh" \
   && chmod +x "bazel-installer.sh" \
   && "./bazel-installer.sh" \
   && rm "bazel-installer.sh"

# Install Clang, which is required by Bazel for building TFMOT.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y clang
ENV CC clang

# Install TensorFlow
RUN pip install "tensorflow==${TENSORFLOW_VERSION}"
