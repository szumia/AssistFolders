rm /etc/apt/sources.list
touch /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse 
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse 
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse focal" > /etc/apt/sources.list


