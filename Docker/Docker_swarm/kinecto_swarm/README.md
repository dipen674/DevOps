1. Build Images Locally
   First, build the Docker images for the storefront and scheduler services locally using the compose.yaml file.

2. Push Images to Docker Hub
   After building, push these images to an external container registry such as Docker Hub or Harbor. In this project, Docker Hub is used as the image repository.

3. Update Swarm Compose File
   Reference the pushed images in the swarm_compose.yaml file to ensure that Docker Swarm pulls the correct images from the registry during deployment.

4. Environment Variable Management
   A bash script has been created to export environment variables defined in the .env file, facilitating proper substitution of variables in the compose file.

5. Deploy the Stack
   After setting the script's execute permission, running it deploys the Docker Swarm stack with all configurations and environment variables correctly applied.


