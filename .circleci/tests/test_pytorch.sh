#!/bin/bash

set -ex

CONFIG_DIR=/tmp/config
LOCAL_REPORTER_DIR=/tmp/reporter
REPO_DIR=/tmp/pytorch
REPO=caffe2

mkdir -p "$CONFIG_DIR"
mkdir -p "$LOCAL_REPORTER_DIR"

echo "
{
  \"--commit\": \"master\",
  \"--exec_dir\": \"${CONFIG_DIR}/exec\",
  \"--framework\": \"${REPO}\",
  \"--local_reporter\": \"${CONFIG_DIR}/reporter\",
  \"--model_cache\": \"${CONFIG_DIR}/model_cache\",
  \"--platforms\": \"host\",
  \"--remote_repository\": \"origin\",
  \"--repo\": \"git\",
  \"--repo_dir\": \"${REPO_DIR}\",
  \"--screen_reporter\": null
}
" > ${CONFIG_DIR}/config.txt

python benchmarking/run_bench.py -b specifications/models/caffe2/squeezenet/squeezenet.json --config_dir "${CONFIG_DIR}"
