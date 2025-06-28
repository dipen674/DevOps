FROM nginx
LABEL 	owner=Deependra
RUN apt update
RUN apt install -y net-tools
COPY index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
