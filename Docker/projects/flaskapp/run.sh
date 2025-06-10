#!/bin/bash

#Run the stack file
docker stack deploy -c swarm_compose.yaml flaskapp
