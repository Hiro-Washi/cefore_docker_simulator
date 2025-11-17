#!/bin/bash
docker run -it -d -w /app -v ./:/docker -h "test" --name "ceftest2" -p 9890:9896 linuxcontainers/debian-slim
docker run --rm -it -d -w /app -v ./:/docker -h "test" --name "cefpyco-test" -p 9896:9896 debian-cefore-router
# IP: Docker のデフォルトブリッジネットワーク (docker0) は、通常、172.17.0.1/16 のIPアドレス範囲
docker build -t cefian:dev
docker build -t debslim-cefapp:0.11.0 -f Dockerfile_debian_cefapp .

(cd tmp)

apt update
apt upgrade
apt install -y libssh-dev make automake build-essential procps zip

cd /tmp
unzip /docker/v0.11.0.zip -d ./
cd cefore-0.11.0
export CEFORE_DIR=/usr/local
aclocal
automake
./configure --enable-csmgr --enable-cache
make
sudo make install

(echo "include $CEFORE_DIR/lib">> /etc/ld.so.conf)
ldconfig

sh /docker/init.sh 
# Unable to start csmgrd, Illegal CS_MODE=0


