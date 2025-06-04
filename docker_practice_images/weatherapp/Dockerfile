FROM node

LABEL "np.com.techaxis"="company name"
LABEL "version"="1.0"


MAINTAINER "Dipendra Bhatta"

ARG dir=/var/node

#WORKDIR /var/node
WORKDIR $dir

RUN apt update
RUN apt install -y net-tools

#COPY weather_app /var/node
COPY weather_app $dir

ENV port=5000
ENV Deployment="Development"

#EXPOSE 3000
EXPOSE $port
RUN npm install
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost:3000 || exit 1


RUN useradd -m -d /home/appuser appuser 
USER appuser
CMD ["node","./bin/www"]


