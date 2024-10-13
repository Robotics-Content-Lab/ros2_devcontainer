#!/bin/bash
# shellcheck disable=SC1090,SC2086,SC1091
# Helper script to build ROS 2 workspace and install dependencies in the container

source "/opt/ros/$ROS_DISTRO/setup.bash" --

if [ -e ${HOME}/ros2_ws/ ]; then
    pushd ${HOME}/ros2_ws || exit
        echo "Building ROS 2 workspace..."
        sudo apt update -qq >/dev/null 2>&1 || true
        rosdep install --from-paths src --ignore-src -r -y >/dev/null 2>&1 || true
        colcon build --symlink-install  >/dev/null 2>&1  || true
    popd || exit
    source ${HOME}/ros2_ws/install/setup.bash
else
    echo "Error: ROS 2 workspace not found at ${HOME}/ros2_ws."
fi