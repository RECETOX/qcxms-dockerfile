FROM ubuntu:20.04
RUN sudo apt-get install git
RUN git clone https://github.com/qcxms/qcxms
RUN git checkout ...
COPY build.sh .
RUN bash build.sh
...
