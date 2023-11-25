#!/bin/bash

echo "ubuntu" | sudo -S chmod +777 /dev/ttyUSB0
filename="origin_name"
last_lines=0
sec=1

#change 1
name=drone
zero_count=0
Thread=`ps -ef | grep $name | grep -v "grep"`
while [ 1 ]
do
count=`ps -ef | grep $name | grep -v "grep" | wc -l`
echo "Thread count: $count"
if [ $count -gt 0 ]; then
	sleep $sec
	sleep 1
	echo "The thread is still alive!"
	echo $(cat "/home/nuc/release_log/${filename}.file" | wc -l)
	cur_lines=$(cat "/home/nuc/release_log/${filename}.file" | wc -l)
	if [ ${cur_lines} == ${last_lines} ]
	then
		echo "the project stop but not exit,restart it"
#change 2
		/home/nuc/kill.sh drone
		cd /home/nuc
		filename=$(date +%Y%m%d)_$(date +%H%M%S)
		nohup ./$name > /home/nuc/release_log/$filename.file &
		last_lines=0
	fi
	last_lines=${cur_lines}
	sleep $sec
else 
	cd /home/nuc/cmake-build-release
	filename=$(date +%Y%m%d)_$(date +%H%M%S)
	nohup ./$name > /home/nuc/release_log/$filename.file &
	last_lines=0
	zero_count=$[$zero_count+1]
	echo "zero_count: $zero_count"
	#改回4s重启记得 -gt 4
	if [ $zero_count -gt 4 ]; then
	 echo 'ubuntu'| sudo -S reboot
	fi
	sleep $sec
	sleep 1	
fi
done



