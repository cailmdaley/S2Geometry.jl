FROM cailmdaley/sptlab

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \ 
    libgflags-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libssl-dev

USER $IMAGE_USER
RUN git -C $SRC clone https://github.com/google/s2geometry.git \
    && mkdir /src/s2geometry/build \
    && cd /src/s2geometry/build \
    && cmake .. \
       -DCMAKE_INSTALL_PREFIX=/src \
       -DWITH_GFLAGS=ON \
       -WITH_GTEST=ON \ 
       #-DGTEST_ROOT=/usr/src/gtest \
    && make \
    && make install \
    && make test
    #    -DPYTHON_INCLUDE_DIR=usr/include/python2.7 \
    #    -DPYTHON_LIBRARY=/usr/lib/python2.7/config-x86_64-linux-gnu/libpython2.7.s