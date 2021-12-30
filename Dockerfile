FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y sudo
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN apt-get install -y apache2
RUN apt-get install apache2-utils -y
RUN apt-get clean 
RUN apt-get update

RUN a2enmod userdir
RUN a2enmod autoindex


RUN sudo adduser --force-badname --disabled-password --gecos "" user1
RUN sudo adduser --force-badname --disabled-password --gecos "" user2
RUN sudo adduser --force-badname --disabled-password --gecos "" user3
RUN sudo adduser --force-badname --disabled-password --gecos "" user4
RUN sudo adduser --force-badname --disabled-password --gecos "" user5

RUN cd /home/user1
RUN mkdir public_html
RUN chmod 755 public_html
WORKDIR /home/user1/public_html
COPY user1.html .
RUN mv user1.html index.html

WORKDIR /home/

RUN cd /home/user2
RUN mkdir public_html
RUN chmod 755 public_html
WORKDIR /home/user2/public_html
COPY user2.html .
RUN mv user2.html index.html

WORKDIR /home/

RUN cd user3 && mkdir public_html
RUN chmod 755 public_html
WORKDIR /home/user3/public_html
COPY user3.html .
RUN mv user3.html index.html

WORKDIR /home/

RUN cd user4 && mkdir public_html
RUN chmod 755 public_html
WORKDIR /home/user4/public_html
COPY user4.html .
RUN mv user4.html index.html

WORKDIR /home/

RUN cd user5 && mkdir public_html
RUN chmod 755 public_html
WORKDIR /home/user5/public_html
COPY user5.html .
RUN mv user5.html index.html


WORKDIR /var/www/html/
RUN rm -r index.html
COPY index.html .
COPY not-found.html .
COPY forbidden.html .

WORKDIR /var/www/html/
RUN mkdir marketing
RUN cd marketing
WORKDIR /var/www/html/marketing/
RUN mkdir promotions
WORKDIR /var/www/html/marketing/promotions/
COPY promotions.html /var/www/html/marketing/promotions


COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]