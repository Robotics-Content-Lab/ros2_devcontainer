#!/bin/bash

set -eou pipefail

ROS_DISTROS=("rolling" "jazzy" "iron")
BASE_DIR=$(git rev-parse --show-toplevel)
if [ $? -ne 0 ]; then
    echo "Error: Could not find base directory of repository."
    exit 1
fi

cd $BASE_DIR/.devcontainer

for ROS_DISTRO in "${ROS_DISTROS[@]}"; do
    echo "Building and pushing ${ROS_DISTRO}..."
    docker build --build-arg=ROS_DISTRO=${ROS_DISTRO} --tag ghcr.io/roboticscontentlab/ros2:${ROS_DISTRO}-base -f Dockerfile.base .
    docker build --build-arg=ROS_DISTRO=${ROS_DISTRO} --tag ghcr.io/roboticscontentlab/ros2:${ROS_DISTRO}-full -f Dockerfile.full .
    # docker push ghcr.io/roboticscontentlab/ros2:${ROS_DISTRO}-base
done
