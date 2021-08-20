#!/bin/bash

# This is designed for Amazon EC2 Linux
# This is just a cool bootscript to show system stats
# By: drampil@

# Adding some variables
user=$(whoami)
system=$(uname)
kernel=$(uname -r)
uptime=$(uptime -p)
host=$(hostname)
cpu=$(cat /proc/cpuinfo | grep "model name" | sed 's/[^,:]*://g')
memavail=$(cat /proc/meminfo | grep "MemAvailable" | sed 's/[^*,:]*://g' | sed 's/^ *//g')
memfree=$(cat /proc/meminfo | grep "MemFree" | sed 's/[^*,:]*://g' | sed 's/^ *//g')
devices=$(lsblk | awk '(NR>1)' > devices.txt; cat devices.txt | sed 's/└─/\t └─/g')
packages=$(yum list installed | wc -l)
skull=$(cat skull.txt)
user=$(whoami)
check=$(cat /etc/group | grep wheel | cut -d ":" -f 4)



# Functions list

get_priviege(){
if [[ $user = $check ]];
then
        echo "You have root power"
else
        echo "You don't have root power"
fi
}

get_logo(){
	echo "$skull"
}

get_user(){
	echo "User: " $user"@"$system
}

get_hostname(){
	echo "Host: " $host
}

get_shell(){
	echo "Shell: " $SHELL
}

get_kernel(){
	echo "Kernel: " $kernel
}

get_uptime(){
	echo "Uptime: " $uptime
}

get_cpu(){
	echo "CPU: " $cpu
}

get_memory(){
	echo "Memory: "$memfree"/"$memavail
}

get_devices(){
	echo -e "Devices: ""$devices"
}

get_packages(){
	echo "Packages Installed: "$packages
}

# Run all the functions in this order
get_logo
get_user
get_hostname
get_shell
get_kernel
get_uptime
get_cpu
get_memory
get_packages
get_devices
echo
echo "Welcome back," $user
get_priviege

# Cleanup
rm devices.txt