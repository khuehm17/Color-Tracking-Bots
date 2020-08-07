##### *** This is a markdown file
##### *** All files of code are available on Github at https://github.com/khuemh/trackingbot_depl
# **TRACKING BOT USER MANUAL**

### **DIRECTORIES TREE**

```bash
|--raspberryPi
|    |--color_tracking
|    |    |--build
|    |    |    |--apps
|    |    |    |    |--program
|    |    |    |--objects
|    |    |--src
|    |    |    |--main.cpp
|    |    |--Makefile
|    |--dht11_udp
|    |    |--build
|    |    |    |--apps
|    |    |    |    |--program
|    |    |    |--objects
|    |    |--src
|    |    |    |--main.cpp
|    |    |    |--Socket.cpp
|    |    |--inc
|    |    |    |--Socket.h
|    |    |--Makefile
|    |--stream_udp
|    |    |--build
|    |    |    |--apps
|    |    |    |    |--program
|    |    |    |--objects
|    |    |--src
|    |    |    |--main.cpp
|    |    |    |--Socket.cpp
|    |    |--inc
|    |    |    |--Socket.h
|    |    |    |--config.h
|    |    |--Makefile
|    |--dht11.sh
|    |--stream.sh
|    |--tracking.sh
|--stm32
|    |--Drivers
|    |    |--CMSIS
|    |    |--STM32F4xx_HAL_Driver
|    |--Inc
|    |    |--delay.h
|    |    |--main.h
|    |--MDK-ARM
|    |    |--DebugConfig
|    |    |--hal_tracking_robot_v5
|    |    |--RTE
|    |    |--hal_tracking_robot_v5.uvprojx
|    |--src
|    |    |--delay.c
|    |    |--main.c
|    |--.mxproject
|    |--hal_tracking_robot_v5.ioc
|--server_pc
|    |--stream_udp_server
|    |--stream_udp_server_QT5
|--raspi_tracking_image
|--README.md
```

### **USER GUIDES**
#### On Raspberry Pi
1) Write *raspi_tracking_image.img* to SD memory by using [***Win32 Disk Imager***](https://sourceforge.net/projects/win32diskimager).
2) Connect to Raspberry Pi using ethernet cable. Use *Remote Desktop Connection* program to use Raspberry Pi with interface. In *Remote Desktop Connection*, connect to *raspberrypi.mshome.net* address.
3) Copy *code/raspberryPi* folder to Raspberry Pi.
   To build source code of any function, enter that function directory and open termial command line:
   ```bash
   > make
   ```
    or
    ```bash
    > make clean
    ```
    and rebuild the source code.
4) Open terminal command in *raspberryPi* directory. 
   
   To run tracking function
   ```bash
   > ./tracking.sh
   ```
   To stop, press [Ctrl+\ ]. To terminate the tracking process, press [Ctrl+C].
   To run streaming video and stream temperature and humidity function
   ```bash
   > ./stream.sh 192.168.x.xxx && ./dht11.sh 192.168.x.xxx
   ```

   and [Ctrl+C] to terminate streaming process.

   *** 192.168.x.xxx is IP address of server. 

#### On STM32F4

Run *stm32/MDK-ARM/hal_tracking_robot_v5.uvprojx* with [**KeiluVision 5**](http://www2.keil.com/mdk5/uvision). Build anddownload executable file to STM32 via micro USB cable. 
To change configuration, open *stm32hal_tracking_robot_v5.ioc* with **STM32CubeMX** (https:/www.st.com/en/development-tools/stm32cubemx.html).

#### On PC

*** This's for UBUNTU OS, with GNU GCC, OpenCV 3.4 prequired

Copy *server_pc* folder to PC. Enter *server_pcstream_udp_server* directory, open terminal command line
```bash
> make 
```
to build the source code for executing on Ubuntu OS.
To start getting the streaming video from Raspberry Pi:
```bash
> ./build/apps/program 56666
```
To stream video and data with interface, enter *server_pc/stream_udp_server_QT5*, open QT5 with [**Qt Designer**](https://www.qt.io).

#### Appendix A: Raspian OS configuration
1) Enable Serial console

    > Enable SSH: add file ssh to boot folder
    >
    > Open config.txt -> add enable_uart=1

2) Enable ethernet network interface
   
    ```bash
    > sudo raspi-config
    ```

    > Choose 2 Network Options
    >
    > Choose N3 Network interface names -> Yes
    >
    > PuTTY: IP: raspberrypi.mshome.net Port: 22

3) Update Raspberry Pi

    ```bash
    > sudo apt-get update && upgrade
    ```

4) Install Raspberry Pi remote Desktop
   
    > Enable VNC: sudo raspi-config -> Interfacing options -> Enable VNC -> sudo reboot
    >
    > Install xrdp: sudo apt-get install xrdp

5) Enable raspberrypi Camera

    > sudo raspi-config -> 5 Interfacing Options -> P1 Camera -> Yes

    ```bash
    > sudo modprobe bcm2835-v4l2
    ```
6) Install wiringPi

    ```bash
    > cd ~
    > git clone git://git.drogon.net/wiringPi
    > cd wiringPi
    > ./build
    ```

7) Enable SPI

    > sudo raspi-config -> 5 Interfacing Options -> P4 SPI -> Yes

#### Appendix B: Install OpenCV
1) Installing prerequisites
 * Update your system
    ```bash
    > sudo apt-get update
    > sudo apt-get upgrade
    > sudo rpi-update
    > sudo reboot
    ```

 * Install the devel tools

    ```bash
    > sudo apt-get install build-essential cmakecmake-curses-gui pkg-config
    ```

 * Install the required libraries
   - Install Image I/O packages
        ```bash
        > sudo apt-get install libatlas-base-dev gfortran
        ```
   - Install Video I/O packages
        ```bash
        > sudo apt-get install libavcodec-dev libavformat-devlibswscale-dev libv4l-dev -y
        > sudo apt-get install libxvidcore-dev libx264-dev -y
        ```
   - Install the GTK development library for basic GUI windows
        ```bash
        > sudo apt-get install libgtk2.0-dev libgtk-3-dev -y
        ```
 * Additional libraries
    ```bash
    > sudo apt-get install libatlas-base-dev gfortran -y
    ```
 * Install python-dev
    ```bash
    > sudo apt-get install python3 python3-setuptools python3-dev -y
    ```

2) Download OpenCV
    ```bash
    > mkdir OPENCV
    > cd  /home/OPENCV
    > wget https://github.com/opencv/opencv/archive/3.2.0.zip -O opencv_source.zip
    > wget https://github.com/opencv/opencv_contrib/archive/3.2.0.zip -O opencv_contrib.zip
    > unzip opencv_source.zip && mv opencv-3.2.0 opencv
    > unzip opencv_contrib.zip && mv opencv_contrib-3.2.0 opencv_contrib
    ```
3) Run CMake OpenCV
    ```bash
    > cd ~/opencv
    > mkdir build
    > cd build
    > cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_opencv_java=OFF -D BUILD_opencv_python2=OFF -D BUILD_opencv_python3=ON -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) -D INSTALL_C_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.4.0/modules -D WITH_CUDA=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS= OFF ..
    ```
4) Swap Space size to add more virtual memory
   
   * Open your /etc/dphys-swapfile and then edit the CONF_SWAPSIZE  variable
        ```bash
        > sudo nano /etc/dphys-swapfile
        ```
   * Add CONF_SWAPSIZE=1024
        ```bash
        > sudo /etc/init.d/dphys-swapfile stop
        > sudo /etc/init.d/dphys-swapfile start
        ```
5) Build and Install OpenCV
    ```bash
    > make -j4 
    > sudo make install
    > sudo ldconfig
    ```