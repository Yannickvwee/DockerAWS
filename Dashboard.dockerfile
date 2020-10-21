
# run git clone https://github.com/broadinstitute/covid19-testing.git master then execute dockerfile
# dont forget to pull the image first and install git if not installed
FROM nginx:latest
COPY ./master /usr/share/nginx/html/COVIDdashboard
RUN service nginx start
# RUN apt-get -y update
# RUN apt-get -y install mongo-tools mongodb-clients
# RUN grep -oP '(?<=data =).*?(?=;)' index.html > data.json
# RUN mongoimport -u ${dbuname} -p ${dbpw} --host ${dbserver.privateip} --port 27017 --db COVIDDashboard --collection inventory --authenticationDatabase admin --drop --file ./data.json --jsonArray
EXPOSE 80

#docker run -it --rm -d -p 0.0.0.0:80:80 --net shared_nw --ip 10.0.1.200 --name amezing amezing
#apt -y install software-properties-common dirmngr apt-transport-https lsb-release ca-certificates
#apt install -y git build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget nginx php-mysql php-pdo php-ldap php-fpm php-pear php-curl php-dev php-gd php-mbstring php-zip php-xml
#sudo apt install gnupg2 pass
# sudo docker network create --driver bridge --subnet=10.0.1.0/24 --gateway=10.0.1.10 --opt "com.docker.network.bridge.name"="docker1" shared_nw
# https://github.com/looking4ward/nhs-cac-docker-dotnetwebapp.git
# docker swarm init
# $ docker volume create portainer_data
# $ docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
# docker swarm join-token manager -q