#!/bin/bash
# shellcheck disable=SC2086,SC2181
usage() {
    echo "Usage: $0 [-d <rolling, jazzy, iron>] [-p <base, full>] [-h]"
    echo "  -d: ROS distro (default: jazzy)"
    echo "  -p: Base image (default: full)"
    echo "  -h: Help"
}

BASE_DIR=$(git rev-parse --show-toplevel)
if [ $? -ne 0 ]; then
    echo "Error: Could not find base directory of repository."
    exit 1
fi

pushd ${BASE_DIR}/ || exit 1
SHARED_DIR=/home/ros_user/ros2_ws/src
HOST_DIR=$BASE_DIR/src

if [ ! -d $HOST_DIR ] && [ ! -f $HOST_DIR ] && [ -z $HOST_DIR ]; then
    echo "Error: Could not find ROS2 workspace: $HOST_DIR. Creating new workspace."
    mkdir -p $BASE_DIR/ros2_src
fi

ROS_DISTRO="jazzy"
BASE="full"


while getopts d:p:t:g:r:h flag
do
    case "${flag}" in
        d) # CHECK IF ROS_DISTRO IS VALID [iron, humble]
            if [ ${OPTARG} == "rolling" ] || [ ${OPTARG} == "jazzy" ] || [ ${OPTARG} == "iron" ]; then
                ROS_DISTRO=${OPTARG}
            else
                echo "Invalid ROS_DISTRO: ${OPTARG}"
                exit 1
            fi
            ;;
        p) # CHECK IF BASE IS VALID [base, full]
            if [ ${OPTARG} == "base" ] || [ ${OPTARG} == "full" ]; then
                BASE=${OPTARG}
            else
                echo "Invalid BASE: ${OPTARG}"
                exit 1
            fi
            ;;

        h) # HELP
            usage
            exit 0
            ;;
        *) # DEFAULT
            echo "Usage: ./run_docker.sh -d [iron, humble] -p [desktop, base] -t [terminal, vnc]"
            exit 1
            ;;
    esac
done

echo -e "\e[32mMounting fodler:
    $HOST_DIR    to
    $SHARED_DIR\e[0m"


IMAGE="ghcr.io/robotics-content-lab/${ROS_DISTRO}:${BASE}"

RUN_ARGS=(--rm \
    --volume="$HOST_DIR:$SHARED_DIR:rw" \
    --volume=/tmp/.X11-unix:/tmp/.X11-unix \
    --env="QT_X11_NO_MITSHM=1" \
    --env="DISPLAY=$DISPLAY"  \
    --name=robotics-content-lab \
    --network=host \
    --cap-add=SYS_PTRACE \
    --security-opt=seccomp:unconfined \
    --security-opt=apparmor:unconfined \
    --ipc=host \
    --device=/dev/dri \
    )


xhost +
docker run -it \
    "${RUN_ARGS[@]}" \
    --name "robotics-content-lab" \
    $IMAGE
    xhost -
popd || exit 1