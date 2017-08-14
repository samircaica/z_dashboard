FROM centos:latest
MAINTAINER Samir Caica <samir.caica@gmail.com>

RUN yum -y install git man patch gcc openssl-devel readline-devel zlib zlib-devel gcc-c++ libcurl-devel httpd httpd-devel apr-devel apr-util-devel postgresql-devel make bzip2 autoconf automake libtool bison curl --nogpgcheck

RUN useradd -c 'Inmetrics Performance Center' -m -d /opt/perfcenter -U perfcenter && chmod a+rx /opt/perfcenter

ADD ./install-rbenv.sh /usr/sbin/
ADD ./install-dashboard.sh /usr/sbin/

RUN chmod 755 /usr/sbin/install-rbenv.sh
RUN chmod 755 /usr/sbin/install-dashboard.sh

RUN install-rbenv.sh

ADD ./dashboard /opt/perfcenter/dashboard

RUN install-dashboard.sh

ADD ./dashboard.conf /opt/perfcenter/httpd-config/dashboard.conf

RUN cp -i /opt/perfcenter/httpd-config/*.conf /etc/httpd/conf.d

EXPOSE 8080

CMD ["apachectl", "stop"]

CMD ["apachectl", "-DFOREGROUND"]