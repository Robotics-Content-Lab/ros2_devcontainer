#!/usr/bin/env pwsh

param (
    [string]$d = "jazzy",
    [string]$p = "full",
    [switch]$h
)

function Usage {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) [-d <rolling, jazzy, iron>] [-p <base, full>] [-h]"
    Write-Host "  -d: ROS distro (default: jazzy)"
    Write-Host "  -p: Base image (default: full)"
    Write-Host "  -h: Help"
}

if ($h) {
    Usage
    exit 0
}

$BaseDir = git rev-parse --show-toplevel
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Could not find base directory of repository."
    exit 1
}

Push-Location $BaseDir
$SharedDir = "/home/ros_user/ros2_ws/src"
$HostDir = Join-Path $BaseDir "src"

if (-not (Test-Path $HostDir)) {
    Write-Host "Error: Could not find ROS2 workspace: $HostDir. Creating new workspace."
    New-Item -Path (Join-Path $BaseDir "ros2_src") -ItemType Directory -Force
}

$RosDistro = $d
$Base = $p

if ($RosDistro -notin @("rolling", "jazzy", "iron")) {
    Write-Host "Invalid ROS_DISTRO: $RosDistro"
    exit 1
}

if ($Base -notin @("base", "full")) {
    Write-Host "Invalid BASE: $Base"
    exit 1
}

Write-Host "Mounting folder:`n    $HostDir    to`n    $SharedDir" -ForegroundColor Green

$Image = "ghcr.io/robotics-content-lab/${RosDistro}:${Base}"

$RunArgs = @(
    "--rm",
    "--volume=${HostDir}:${SharedDir}:rw",
    "--name=robotics-content-lab",
    "--network=host",
    "--cap-add=SYS_PTRACE",
    "--security-opt=seccomp:unconfined",
    "--security-opt=apparmor:unconfined",
    "--ipc=host"
)

# OS-specific configurations
if ($IsWindows) {
    # Windows-specific settings
    $env:DISPLAY = "host.docker.internal:0"
    $RunArgs += "--env=DISPLAY=$env:DISPLAY"
    $RunArgs += "--volume=$env:TEMP:$env:TEMP"
} elseif ($IsLinux -or $IsMacOS) {
    # Linux and macOS settings
    $RunArgs += "--volume=/tmp/.X11-unix:/tmp/.X11-unix"
    $RunArgs += "--env=DISPLAY=$env:DISPLAY"
    $RunArgs += "--env=QT_X11_NO_MITSHM=1"
    $RunArgs += "--device=/dev/dri"
    
    # Only use xhost on Linux/macOS
    xhost + 2>$null
}

docker run -it `
    $RunArgs `
    --name "robotics-content-lab" `
    $Image

if ($IsLinux -or $IsMacOS) {
    # Only use xhost on Linux/macOS
    xhost - 2>$null
}

Pop-Location