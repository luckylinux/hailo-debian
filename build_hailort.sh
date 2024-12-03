#!/bin/bash

source config.sh

git clone https://github.com/hailo-ai/hailort.git

cd hailort
git checkout ${HAILORT_RUNTIME_TAG}

#cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config release

# Include installation in the Machine
cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && sudo cmake --build build --config release --target install

