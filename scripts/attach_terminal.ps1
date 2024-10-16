# Get the container ID
$CONTAINER = docker container ls | Where-Object { $_ -match "robotics-content-lab" } | ForEach-Object { $_.Split()[0] }

# Execute the entrypoint script inside the container
docker container exec -it $CONTAINER /entrypoint.sh tmux
