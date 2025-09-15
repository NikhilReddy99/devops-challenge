# Powershell helper to start registry and docker-compose
docker run -d -p 5000:5000 --name registry registry:2
docker-compose up --build -d
