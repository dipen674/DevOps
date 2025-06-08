#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Deploy the stack
docker stack deploy -c swarm_compose.yaml mykinectoswarm
