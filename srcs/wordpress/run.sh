docker build -t webserver .
docker run -p 80:80 -p 443:443 -ti webserver