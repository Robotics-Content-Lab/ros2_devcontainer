# ROS 2 Devcontainer Setup

## Getting Started

### Prerequisites

- Docker
- Visual Studio Code
- Remote - Containers extension for Visual Studio Code

### Setting Up the Devcontainer

1. Clone the repository:
    ```sh
    git clone https://github.com/Robotics-Content-Lab/ros2_devcontainer
    cd https://github.com/Robotics-Content-Lab/ros2_devcontainer
    ```
2. Add your ROS 2 colcon packages to the `src` directory.

3. Open the repository in Visual Studio Code.

4. When prompted, click on "Reopen in Container" to start the devcontainer.

### Building the Workspace

The workspace can be built using the provided script:

```sh
build_ws.sh
```
### Scripts

- **attach_terminal.sh/ps1**: This script attaches a terminal to a running Docker container. The are located at [scripts/attach_terminal.sh](scripts/attach_terminal.sh) and [scripts/attach_terminal.ps1](scripts/attach_terminal.ps1).

### Devcontainer Configuration

The devcontainer configuration is defined in [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json). It specifies the Dockerfile to use, build arguments, and other settings for the development container.

### Dockerfiles

- **Dockerfile.base**: Base Dockerfile for the ROS 2 environment. Located in [`.devcontainer/Dockerfile.base`](.devcontainer/Dockerfile.base).

- **Dockerfile.full**: Dockerfile that extends the base Dockerfile with additional tools and packages. Located in [`.devcontainer/Dockerfile.full`](.devcontainer/Dockerfile.full).

### Entrypoint

The entrypoint script for the Docker containers is defined in [`.devcontainer/entrypoint.sh`](.devcontainer/entrypoint.sh).

