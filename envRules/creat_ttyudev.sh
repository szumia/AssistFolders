sudo cp ./ttyudev.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules 
sudo udevadm trigger
# sudo service udev reload
# sudo service udev restart
echo "finish"
