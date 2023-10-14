# Webcache template with Nginx and Varnish

## To run locally

- `docker build -t webcache --build-arg ENV_NAME=stage .`
- `docker run -d -p 6081:6081 --name webcache webcache`

- Usecase
- Build image and push to ECR and set up Webcache with ECS/EC2

## For Production

- `docker build -t webcache --build-arg ENV_NAME=prod .`
- `docker run -d -p 6081:6081 --name webcache webcache`
