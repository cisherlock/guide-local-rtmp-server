## 1. Open the terminal and run the following commands:
(Enter each line below starting with a $ and hit return... but don't enter the '$' sign)

```
$ mkdir /tmp
$ cd /tmp
$ sudo apt update && sudo apt upgrade -y
$ sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev
$ sudo apt-get install zlibc zlib1g zlib1g-dev

^(note: it's zlib1g - the number one, not the letter 'L') - You will be asked if you want to continue, press 'y' and enter

$ wget http://nginx.org/download/nginx-1.16.1.tar.gz
$ wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/dev.zip
$ tar -zxvf nginx-1.16.1.tar.gz
$ unzip dev.zip
$ cd nginx-1.16.1
$ ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-dev
$ make
$ sudo make install
```


## 2. Configure
```
$ cd /usr/local/nginx/conf
$ sudo nano nginx.conf
```
Move to the bottom of the file using the arrow keys. After the last '}' enter the following:
```
rtmp {
  server {
    listen 1935;
    chunk_size 4096;

    application live {
      live on;
      record off;
    }
  }
}
```
To save and exit:
Press Ctrl+x, then press y, and hit return


## 3. Run nginx. In terminal enter the following commands:
```
$ cd ../
$ sudo sbin/nginx
```
The RTMP server is now running on your local network...


## 4. Go back to README.md and continue from step 5