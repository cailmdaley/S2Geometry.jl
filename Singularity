BootStrap: docker
From: ubuntu:latest

%post
   apt-get update
   apt-get install -y git man cmake g++ swig python-dev ipython
   apt-get install -y libgflags-dev libgoogle-glog-dev libgtest-dev libssl-dev
   
   apt-get clean
   apt-get autoremove
   
   
   git clone https://github.com/google/s2geometry.git
   
   cd s2geometry && mkdir build && cd build
   cmake .. \
   -DCMAKE_INSTALL_PREFIX=/usr \
   -DWITH_GFLAGS=ON \
   -WITH_GTEST=ON -DGTEST_ROOT=/usr/src/gtest \
   -DPYTHON_INCLUDE_DIR=/usr/include/python2.7 \
   -DPYTHON_LIBRARY=/usr/lib/python2.7/config-x86_64-linux-gnu/libpython2.7.so
   
   make && make install
   
%test 
   cd s2geometry/build
   make test
