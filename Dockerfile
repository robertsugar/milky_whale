#Galaxy on Docker

FROM ubuntu:14.04

#update packages
RUN apt-get update

# Add the package verification key
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

#Install Packages
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get install --no-install-recommends -y git
RUN apt-get install --no-install-recommends -y python
#lynx for testing web interface
RUN apt-get install --no-install-recommends -y lynx

#Install Galaxy
#RUN git clone https://github.com/galaxyproject/galaxy/
ADD galaxy/ /galaxy

#Autorun Galaxy
CMD ["/bin/sh", "/galaxy/run.sh"]

#Galaxy default port
EXPOSE 8080
