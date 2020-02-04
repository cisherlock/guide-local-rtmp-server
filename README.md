# Guide to setting up a 100% free local RTMP server | Use iPhone with Stream Labs Remote Camera and OBS
At the time of writing Stream Labs Remote Camera is limited to Android phones. This guide was created for Twitch streamers, allowing them to use their iPhone with Stream Labs Remote Camera. Tested (2019) at 62 FPS at 1080p with iPhone XS Max.

By setting up a local RTMP server you will also be able to use multiple remote cameras.

This guide is written for the average streamer and assumes you have a decent level of competency with computers. Advacned users should find it easy to modify the below for more advanced setups. For example, setting up on a dedicated machine, adding VOD recording and setting up a VPN so you can remote stream from anywhere in the world.

##### Security.
The following setup is limited to your local network (your WIFI). Only users connected to your WIFI will be abel to view the remote camera if they know the stream key. The remote camera is then imported to OBS which you can then stream to the internet.

To use the remote camera from anywhere in the world (over 4G) you would need to setup a VPN which isn't included in this guide.


##### Software Licenses.
It's your responsibility to check software licenses and how they apply to your situation.


##### 1. Install VMWare Workstation Player
It's free for personal/home use: 
[https://www.vmware.com/uk/products/workstation-player/workstation-player-evaluation.html](https://www.vmware.com/uk/products/workstation-player/workstation-player-evaluation.html)

Download the one for Windows and install it.


##### 2. Download Linux image
You can download from here: 
[https://ubuntu.com/download/desktop](https://ubuntu.com/download/desktop)

Click download, on the LTS version. It's Free. Next page click the 'download now' link if it doesn't automatically download.


##### 3. Open VMWare player and click "create a new virtual machine"
Select "install from disk image" and browse to the Linux iso you downloaded in step 2
You should provide the virtual machine with at least 2GB of RAM. If installation freezes you may need more.

Under Network Adapter, select "Bridged: Connected direct..." this will allow the virtual machine to obtain its own IP address on the network.

Follow the on-screen instructions and complete setup


##### 4. Open the terminal and run the following commands:
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


## Configure
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


## Run nginx. In terminal enter the following commands:
```
$ cd ../
$ sudo sbin/nginx
```
The RTMP server is now running on your local network...


## Find IP
Type the following command in the terminal:
```
$ ip a
```
Take note of the IP address. You should see an ip starting 192.168.0.xx


## Setup Stream Labs App
In the Stream Labs app, under settings, select custom RTMP server and enter the IP like so:
```
rtmp://192.168.0.xx:1935/live
Stream key: test
```
Make sure you replace the IP with the one you got in the previous step.


## Setup OBS
Add the stream as a media source. Untick local file, and enter:
```
rtmp://192.168.0.xx/live/test
```
Make sure you replace the IP with the one you got in the previous step.


## Multiple Cameras
You can enter anything as the stream key. You can have a different stream key for each phone and have multiple remote cameras at the same time.
