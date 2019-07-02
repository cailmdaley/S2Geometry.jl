FROM ubuntu
ADD . /s2_docker
WORKDIR /s2_docker

RUN apt-get update && apt-get install -y \
    cmake \
    gcc \
    g++

RUN apt-get install -y \
    libgtest-dev \
    libssl-dev \
    swig \
    git

RUN git clone https://github.com/google/s2geometry.git && mkdir s2geometry/build
WORKDIR ./s2geometry/build
RUN pwd
RUN cmake -WITH_GTEST=ON
