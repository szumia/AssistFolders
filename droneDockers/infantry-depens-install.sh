#!/usr/bin/env bash

COMPARE_STRING=""
OPENCV_VERSION="4.6.0"
A=`whoami`

if [[ $A != 'root' ]]; then
   echo "You have to be root to run this script"
   echo "Fail !!!"
   exit 1;
fi

echo "script starting!!!!"


# Install Basic Package
apt update && apt install -y cmake g++ wget unzip git vim 
apt install pkg-config libgtk2.0-dev libgl1-mesa-dev libavformat-dev libavcodec-dev libswscale-dev


# Install eigen
apt-get install libeigen3-dev
ln -s /usr/include/eigen3/Eigen/ /usr/include/Eigen


str_exist() {
	if [[ -z "$COMPARE_STRING" ]]; then
	  echo 0
	elif [[ -n "$COMPARE_STRING" ]]; then
	  echo 1
	fi	
}

install_opencv() {
	mkdir opencv_install && cd opencv_install
	wget -O opencv.zip https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip
	wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip
	unzip opencv.zip
	unzip opencv_contrib.zip
	mkdir -p build && cd build
	cmake -DWITH_FFMPEG=ON -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib-$OPENCV_VERSION/modules ../opencv-$OPENCV_VERSION
	cmake --build .
	make install
	cd ../../
#	rm -rf opencv-install	
}

install_mvsdk() {
	mkdir mvsdk_install && cd mvsdk_install
	wget https://www.mindvision.com.cn/uploadfiles/SDK/linuxSDK_V2.1.0.34.tar.gz
	tar -xvf linuxSDK_V2.1.0.34.tar.gz
	chmod 777 ./install.sh
	./install.sh
	cd ..
#	rm -rf mvsdk_install
}

install_fmt() {
	mkdir fmt_install && cd fmt_install
	wget https://github.com/fmtlib/fmt/archive/refs/tags/8.1.1.zip
	unzip 8.1.1.zip
	cd fmt-8.1.1/
	mkdir build && cd build
	cmake ..
	make -j8
	make install
	cd ../../..
#	rm -rf fmt_install 
}

install_g2o() {
	mkdir g2o_install && cd g2o_install
	wget https://github.com/RainerKuemmerle/g2o/archive/refs/tags/20201223_git.zip
	unzip 20201223_git.zip
	cd g2o-20201223_git
	mkdir build && cd build
	cmake ..
	make -j8
	make install
	cd ../../..
#	rm -rf g2o_install 	
}

install_glog() {
	mkdir glog_install && cd glog_install
	wget https://github.com/google/glog/archive/refs/tags/v0.6.0.zip
	unzip v0.6.0.zip
	cd glog-0.6.0/
	mkdir build && cd build
	cmake ..
	make -j8
	make install
	cd ../../..
#	rm -rf glog_install 	
}


install_sophus() {
	mkdir sophus_install && cd sophus_install
	wget https://github.com/strasdat/Sophus/archive/refs/tags/v22.04.1.zip
	unzip v22.04.1.zip
	cd Sophus-22.04.1/
	mkdir build && cd build
	cmake ..
	make #do not use -j8
	make install 	
	cd ../../..
#	rm -rf sophus_install
}

install_onnx() {
	mkdir onnx_install && cd onnx_install
	wget https://github.com/microsoft/onnxruntime/releases/download/v1.12.1/onnxruntime-linux-x64-1.12.1.tgz
	tar -xvf onnxruntime-linux-x64-1.12.1.tgz
	cd onnxruntime-linux-x64-1.12.1
	cp -r ./lib/* /usr/local/lib
	cd ..
	cp ./onnxruntime-linux-x64-1.12.1 /usr/local/ -r
	ldconfig
	cd ..
#	rm -rf onnx_install
}



COMPARE_STRING=`ls /usr/local/lib/ | grep libopencv` 
EXIST=$(str_exist)
if [[ $EXIST == "0" ]]; then
  install_opencv
fi


COMPARE_STRING=`ls /lib/ | grep libMVSDK.so` 
EXIST=$(str_exist)
if [[ $EXIST == "0" ]]; then
  install_mvsdk
fi

COMPARE_STRING=`ls /usr/local/lib/ | grep libfmt` 
EXIST=$(str_exist)
if [[ $EXIST == "0" ]]; then
  install_fmt
fi

COMPARE_STRING=`ls /usr/local/lib/ | grep libg2o`
EXIST=$(str_exist)
if [[ $EXIST == "0" ]]; then
  install_g2o
fi
   
COMPARE_STRING=`ls /usr/local/lib/ | grep libglog` 
EXIST=$(str_exist)
if [[ $EXIST == "0" ]]; then
  install_glog
fi


COMPARE_STRING=`ls /usr/local/include/ | grep sophus` 
EXIST=$(str_exist)
if [[ $EXIST == "0" ]]; then
  install_sophus
fi

  
COMPARE_STRING=`ls /usr/local/lib/ | grep libonnx` 
EXIST=$(str_exist)
if [[ $EXIST == "0" ]]; then
  install_onnx 
fi
