FROM yannickvw/nginxwebsrv:latest
WORKDIR /var/www/html
RUN git clone https://github.com/broadinstitute/covid19-testing.git master
RUN mv /var/www/html/master /var/www/html/COVIDdashboard
EXPOSE 80


#!bin/bash
apt -y update
aot -y upgrade
apt install -y git python3-pip software-properties-common python3.8
mkdir /tmp/efs-utils
cd /tmp/efs-utils
git clone https://github.com/aws/efs-utils
cd efs-utils
sudo apt-get -y install binutils
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb
mkdir /var/log/sharedlogs
sudo mount -t efs ${EFS}:/ /var/log/sharedlogs
add-apt-repository -y ppa:deadsnakes/ppa
apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
apt install -y nginx php-mysql php-pdo php-ldap php-fpm php-pear php-curl php-dev php-gd php-mbstring php-zip php-xml
systemctl enable nginx
mkdir /git
cd /git
git clone https://github.com/broadinstitute/covid19-testing.git master
cp -r ./master /var/www/html
mv /var/www/html/master /var/www/html/COVIDdashboard
cd /var/www/html/COVIDdashboard
pip3 install virtualenv
virtualenv py-env
source py-env/bin/activate
pip3 install gunicorn flask
apt -y install mongo-tools mongodb-clients
grep -oP '(?<=data =).*?(?=;)' index.html > data.json
mongoimport --host ${DBServer.PrivateIp} --port 27017 --db COVIDDashboard --collection inventory --authenticationDatabase admin --drop --file ./data.json --jsonArray
systemctl stop nginx
sed -i 's,'"access_log /var/log/nginx/access.log;"','"access_log /var/log/sharedlogs/$HOSTNAME.access.log;"',' "/etc/nginx/nginx.conf"
sed -i 's,'"error_log /var/log/nginx/error.log;"','"error_log /var/log/sharedlogs/$HOSTNAME.error.log;"',' "/etc/nginx/nginx.conf"
systemctl start nginx