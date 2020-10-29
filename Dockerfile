FROM cailmdaley/sptlab

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \ 
    libgflags-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libssl-dev

COPY --from=julia:1.3 --chown=1000 /usr/local/julia $JULIA_DEPOT_PATH

RUN git -C $SRC clone https://github.com/google/s2geometry.git \
    && mkdir $SRC/s2geometry/build \
    && cd $SRC/s2geometry/build \
    && cmake .. \
    && make \
    && make install
    # && make test
    #    -DCMAKE_INSTALL_PREFIX=$SRC/s2geometry \
    #    -DPYTHON_INCLUDE_DIR=usr/include/python2.7 \
    #    -DPYTHON_LIBRARY=/usr/lib/python2.7/config-x86_64-linux-gnu/libpython2.7.s

USER $IMAGE_USER