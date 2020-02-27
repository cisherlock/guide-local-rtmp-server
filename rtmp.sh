#!/bin/bash

echo "*************************************"
echo "**** Installing RTMP Please Wait ****"
echo "*************************************"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
sleep 5

cd /tmp

sudo apt update && sudo apt upgrade -y

sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev -y
sudo apt-get install zlibc zlib1g zlib1g-dev -y

wget http://nginx.org/download/nginx-1.16.1.tar.gz
wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/dev.zip

tar -zxvf nginx-1.16.1.tar.gz
unzip dev.zip
cd nginx-1.16.1

./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-dev

make
sudo make install

cd /usr/local/nginx/conf

sudo sh -c "echo 'rtmp {
  server {
    listen 1935;
    chunk_size 4096;

    application live {
      live on;
      record off;
    }
  }
}' >> nginx.conf"

cd ../
sudo sbin/nginx
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "."
echo "."
echo "."

echo "----------------------- FIND IP ADDRESS --------------------------------"
echo $(ip a)
echo "----------------------- FIND IP ADDRESS --------------------------------"
echo "."
echo "."
echo "."
echo "^^ Note down the IP address starting 192.168.0.xx/xx -- but drop the slash and 2 numbers after ^^"
sleep 2
echo "."
echo "."
echo "."
echo "RTMP is now running..."
sleep 2
echo "."
echo "."
echo "."
echo "In Streaming app enter: rtmp://192.168.0.xx:1935/live"
echo "Stream Key: Anything-You-Want"
sleep 2
echo "."
echo "."
echo "."
echo "In OBS add a media source. Un-tick local file and enter: rtmp://192.168.0.xx/live/Your-Stream-Key"
sleep 2
echo "."
echo "."
echo "."
echo "***********************"
echo "**** End of Script ****"
echo "***********************"






