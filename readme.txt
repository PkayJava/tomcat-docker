./build.sh
docker run -p 9443:8443 -p 9444:8444 --rm localhost:5000/tomcat:9.0


# docker run -it -d --name ubuntu -v /home/skhauv/docker/apps:/apps localhost:5000/ubuntu:18.04 /bin/sh
# docker exec -it ubuntu /bin/bash