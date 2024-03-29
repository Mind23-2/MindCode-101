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

if [ $# != 2 ]; then
  echo "Usage: bash run_standalone_train_gpu.sh [DATASET_PATH] [DEVICE_ID]"
  exit 1
fi

get_real_path(){
  if [ "${1:0:1}" == "/" ]; then
    echo "$1"
  else
    echo "$(realpath -m $PWD/$1)"
  fi
}

DATASET_PATH=$(get_real_path $1)
export DEVICE_ID=$2
export DEVICE_NUM=1

if [ ! -d $DATASET_PATH ]
then
    echo "error: DATASET_PATH=$DATASET_PATH is not a directory"
exit 1
fi

ulimit -u unlimited

if [ -d "train" ];
then
    rm -rf ./train
fi

mkdir ./train
cp ../*.py ./train
cp *.sh ./train
cp -r ../src ./train
cd ./train || exit
echo "start standalone training for device $DEVICE_ID"
env > env.log

python train.py \
          --device_target="GPU" \
          --device_id=$DEVICE_ID \
          --dataset_path=$DATASET_PATH &> log &
