#!/bin/bash

# Deploy the stack
docker stack deploy -c swarm_compose.yaml my_personal_website
