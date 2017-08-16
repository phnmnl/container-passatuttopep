FROM ubuntu:16.04

LABEL software.version=201604
LABEL version=201604
LABEL software=Passatutto

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL Description="Metaboilite pep score generator"



# Install packages for compilation
RUN apt-get -y update
RUN apt-get -y --no-install-recommends --fix-missing install make gcc gfortran
RUN apt-get -y --no-install-recommends --fix-missing install g++ libnetcdf-dev 
RUN apt-get -y --no-install-recommends --fix-missing install libxml2-dev libblas-dev 
RUN apt-get -y --no-install-recommends --fix-missing install liblapack-dev
RUN apt-get -y --no-install-recommends --fix-missing install r-base


RUN R -e 'install.packages(c("R.utils","tools"),repos = "http://cran.us.r-project.org")' 
# Update & upgrade sources
RUN apt-get -y update

# Install development files needed
RUN apt-get -y install wget default-jre-headless unzip

# Clean up
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*


ADD passatutto/Passatutto /usr/local/bin/Passatutto

ADD scripts/*.r /usr/local/bin/
RUN chmod +x /usr/local/bin/*.r

# Define Entry point script
#ENTRYPOINT ["java", "-cp", "/usr/local/bin/passatutto.jar"]
