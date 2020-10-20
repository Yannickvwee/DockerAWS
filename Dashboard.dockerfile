
# run git clone https://github.com/broadinstitute/covid19-testing.git master then execute dockerfile
# dont forget to pull the image first and install git if not installed
FROM nginx:latest
COPY ./master /usr/share/nginx/html/COVIDdashboard
RUN service nginx start
EXPOSE 80
