#!/bin/bash

echo "ubuntu" | sudo -S chmod +777 /dev/ttyUSB0
filename="origin_name"
last_lines=0
sec=1

#change 1
name=infantry_vision									#进程名字
zero_count=0
Thread=`ps -ef | grep $name | grep -v "grep"`			#感觉多余了
while [ 1 ]
do
count=`ps -ef | grep $name | grep -v "grep" | wc -l`	#检查运行中的进程是否有包含特定名称的进程，并返回进程数量
echo "Thread count: $count"								#输出进程数量
if [ $count -gt 0 ]; then								#如果进程数大于0
	sleep $sec
	sleep 1
	echo "The thread is still alive!"
	echo $(cat "/home/nuc/build-infantry_vision-Desktop_Qt_5_9_1_GCC_64bit-Release/log/${filename}.file" | wc -l)		#输出 ${filename}.file 文件中的行数。
	cur_lines=$(cat "/home/nuc/build-infantry_vision-Desktop_Qt_5_9_1_GCC_64bit-Release/log/${filename}.file" | wc -l)  
	if [ ${cur_lines} == ${last_lines} ]				#如果程序运行输出为空，可以判断程序没有正常运行 restar 
	then
		echo "the project stop but not exit,restart it"
#change 2
		/home/nuc/kill.sh infantry_vision				#杀死进程
		cd /home/nuc/build-infantry_vision-Desktop_Qt_5_9_1_GCC_64bit-Release
		filename=$(date +%Y%m%d)_$(date +%H%M%S)
		nohup ./$name > /home/nuc/build-infantry_vision-Desktop_Qt_5_9_1_GCC_64bit-Release/log/$filename.file &	
		#在后台运行名为 $name 的可执行文件，并将其标准输出重定向到 /home/nuc/build-infantry_vision-Desktop_Qt_5_9_1_GCC_64bit-Release/log/${filename}.file 文件中，即将命令的输出写入到一个以当前日期和时间命名的日志文件中。
		last_lines=0
	fi
	last_lines=${cur_lines}							   #更新程序输出行数					
	sleep $sec
else 												   #如果进程数小于0
	cd /home/nuc/build-infantry_vision-Desktop_Qt_5_9_1_GCC_64bit-Release
	filename=$(date +%Y%m%d)_$(date +%H%M%S)
	nohup ./$name > /home/nuc/build-infantry_vision-Desktop_Qt_5_9_1_GCC_64bit-Release/log/$filename.file &
	#在后台运行名为 $name 的可执行文件，并将其标准输出重定向到 /home/nuc/build-infantry_vision-Desktop_Qt_5_9_1_GCC_64bit-Release/log/${filename}.file 文件中，即将命令的输出写入到一个以当前日期和时间命名的日志文件中。
	last_lines=0
	zero_count=$[$zero_count+1]
	echo "zero_count: $zero_count"
	if [ $zero_count -gt 4 ]; then					#进程一直没有被正确启动，后台启动的进程超过了4个 大问题 重启
		reboot
	fi
	sleep $sec
	sleep 1	
fi
done



