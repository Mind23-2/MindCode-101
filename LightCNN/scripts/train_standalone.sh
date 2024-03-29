#!/bin/bash
# Copyright 2021 Huawei Technologies Co., Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================

if [ $# != 1 ]; then
  echo "Usage: bash train_standalone.sh [DEVICE_ID]"
  exit 1
fi

export DEVICE_ID=$1
export DEVICE_NUM=1
export RANK_ID=0

python3 train.py \
          --device_target Ascend \
          --device_id "$DEVICE_ID" \
          --ckpt_path ./ckpt_files > train_standalone_log.log 2>&1 &

echo "run standalone training on device ${DEVICE_ID}"
