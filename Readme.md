# ROS 2 Devcontainer Setup

[![CI](https://github.com/Robotics-Content-Lab/ros2_devcontainer/actions/workflows/ci.yaml/badge.svg)](https://github.com/Robotics-Content-Lab/ros2_devcontainer/actions/workflows/ci.yaml) [![CD](https://github.com/Robotics-Content-Lab/ros2_devcontainer/actions/workflows/release.yaml/badge.svg)](https://github.com/Robotics-Content-Lab/ros2_devcontainer/actions/workflows/release.yaml)

This repository provides a ready-to-use **ROS 2 development environment** using Visual Studio Code's devcontainer feature. It allows you to quickly set up a Docker-based containerized workspace for ROS 2 development without manually configuring dependencies.

## 📋 Prerequisites

Before using this setup, make sure you have the following installed:

- **[Docker](https://www.docker.com/get-started)**: Ensure that Docker is installed and running on your machine.
- **[Visual Studio Code](https://code.visualstudio.com/)**: The development environment.
- **[Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)**: Required for running devcontainers in VS Code.

## 🚀 Getting Started

Follow the steps below to set up and start working with the ROS 2 devcontainer environment:

### 1. Clone the Repository

You can either create a new repository from this template via the GitHub CLI or directly through GitHub's interface:

- **Using CLI**:
    ```sh
    gh repo create ros2_ws --template Robotics-Content-Lab/ros2_devcontainer --private --clone
    ```

- **Using GitHub Web UI**:
    1. Click the "Use this template" button on the repository page.
    2. Create a new repository.

### 2. Add Your ROS 2 Packages

Once you've cloned the repository, add your **ROS 2 colcon packages** to the `src` directory.

### 3. Open in Visual Studio Code

After adding your packages:
1. Open the repository folder in Visual Studio Code.
2. When prompted, click on **"Reopen in Container"**. This will automatically build the devcontainer environment.

## 🛠️ Building the Workspace

Use the provided script to build the workspace:

```sh
./build_ws.sh
```

This script automatically handles building your ROS 2 workspace within the container.

## 📜 Available Scripts

Here are some helpful scripts to manage your ROS 2 Docker environment:

- **run_container.sh / .ps1**: Launch the Docker container that runs the ROS 2 workspace.
    - Unix: [scripts/run_container.sh](scripts/run_container.sh)
    - Windows: [scripts/run_container.ps1](scripts/run_container.ps1)
  
- **attach_terminal.sh / .ps1**: Attach a terminal to the running Docker container.
    - Unix: [scripts/attach_terminal.sh](scripts/attach_terminal.sh)
    - Windows: [scripts/attach_terminal.ps1](scripts/attach_terminal.ps1)

These scripts simplify managing and interacting with the development environment.

## 🛠️ Devcontainer Configuration

The devcontainer setup is controlled via the `devcontainer.json` file, located in the `.devcontainer/` folder. It defines the container's build configuration, Dockerfile, and other essential settings for the development environment.

- Configuration file: [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json)

## 📦 Dockerfiles

The repository includes two Dockerfiles to customize your ROS 2 development environment:

- **Dockerfile.base**: This file sets up the base image with essential ROS 2 dependencies.
    - Location: [`.devcontainer/Dockerfile.base`](.devcontainer/Dockerfile.base)

- **Dockerfile.full**: This Dockerfile extends the base image, adding extra tools and packages you might need for more complex development.
    - Location: [`.devcontainer/Dockerfile.full`](.devcontainer/Dockerfile.full)

## 🔧 Entrypoint

The Docker container uses an entrypoint script to set up the environment correctly. You can modify or review the script here:

- [`.devcontainer/entrypoint.sh`](.devcontainer/entrypoint.sh)



## 🙋 FAQs

### What is a devcontainer?

A devcontainer allows you to define a consistent, Docker-based development environment that can be easily shared and reused. In this repository, it is configured for **ROS 2** development.

### Do I need to install ROS 2 on my local machine?

No, the devcontainer setup installs and configures ROS 2 inside a Docker container, so you don't need ROS 2 installed locally.

### Can I use this setup for any ROS 2 distribution?

Yes, this setup supports multiple ROS 2 distributions. You can modify the Dockerfiles to customize which distribution you want to use (e.g., Foxy, Humble).

### How do I update dependencies inside the container?

You can modify the `Dockerfile.base` or `Dockerfile.full` to include new dependencies. After making changes, rebuild the devcontainer to apply them.

### How can I add my own packages?

Simply place your ROS 2 colcon packages inside the `src/` directory, and they will be automatically built when you run the workspace build script (`build_ws.sh`).

### What if I want to use a different IDE?

While this setup is optimized for **Visual Studio Code**, you can use the `run_container.sh`  or `run_container.ps1` script to launch the container and then connect to it using your preferred IDE.