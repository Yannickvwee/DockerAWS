
# run git clone https://github.com/broadinstitute/covid19-testing.git master then execute dockerfile
FROM nginx:latest
COPY ./master /usr/share/nginx/html/COVIDdashboard
RUN service nginx start
EXPOSE 80
