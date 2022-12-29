# This docker uses fsl's bet to extract the brain from a T1 image.
# example run 
# docker run docker run -v PATH2NIFTI_inpit folder:/output -v PATH2NIFTI_output_folder:/output myfsl
FROM ubuntu:latest

MAINTAINER JWK

# install necessary packages
RUN apt-get update
RUN apt-get install -y python3.9
RUN apt-get install -y curl 
RUN apt-get install -y ca-certificates

# create folders inside the docker
RUN mkdir input
RUN mkdir output
RUN mkdir code

# setup certificates for curl
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

# download fslinstaller
RUN curl https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py --output /code/fslinstaller.py

# copy main script
COPY run.py run.py

# go to code directory and install fsl
WORKDIR /code
RUN python3 fslinstaller.py --dest=/usr/local/fsl
ENV FSLDIR=/usr/local/fsl
ENV PATH=$PATH:$FSLDIR

WORKDIR /

# setup an entry point so that each time docker is run it executes the run.py
ENTRYPOINT ["python3","run.py"]