FROM ubuntu:20.04

# Update package lists
RUN apt-get update -y

# Install wget and xz-utils
RUN apt-get install -y wget xz-utils python3

# Create directories for extraction
RUN mkdir /qcxms_bin
RUN mkdir /plotms_bin

# Download and extract QCxMS and PlotMS
RUN wget https://github.com/qcxms/QCxMS/releases/download/v.5.2.1/QCxMS.v.5.2.1.tar.xz && tar -xvf QCxMS.v.5.2.1.tar.xz -C /qcxms_bin
RUN wget https://github.com/qcxms/PlotMS/releases/download/v.6.2.0/PlotMS.v.6.2.0.tar.xz && tar -xvf PlotMS.v.6.2.0.tar.xz -C /plotms_bin

RUN chmod +x /qcxms_bin/getres
