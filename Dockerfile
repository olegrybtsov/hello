FROM centos

RUN yum install epel-release -y
RUN yum install nginx -y

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
EXPOSE 443

COPY static /usr/share/nginx/html
