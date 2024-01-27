#!/bin/bash


sec=1
name=auto_start.sh
Thread=`ps -ef | grep $name | grep -v "grep"`
sleep 5
while [ 1 ]
do
count=`ps -ef | grep $name | grep -v "grep" | wc -l`
echo "Thread count: $count"
if [ $count -gt 0 ]; then
	sleep $sec
else 

	echo "$(date +%Y%m%d)_$(date +%H%M%S)"
	filename=$(date +%Y%m%d)_$(date +%H%M%S)
	nohup /home/nuc/$name > /home/nuc/log/$filename.file &
	sleep $sec
fi
done
