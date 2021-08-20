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
devices=$(lsblk | awk '(NR>1)' > devices.txt; cat devices.txt | sed 's/└─/\t└─/g')
packages=$(yum list installed | wc -l)
user=$(whoami)
check=$(cat /etc/group | grep wheel | cut -d ":" -f 4)



# Functions list

get_priviege(){
if [[ $user = $check ]];
then
        echo "You have root powers."
else
        echo "You don't have any power here!"
fi
}

get_logo(){
	curl https://github.com/drampil/toy-box/blob/main/skull.txt
}

get_user(){
	echo "User:" $user"@"$system >> trash.txt
}

get_hostname(){
	echo "Host:" $host  >> trash.txt
}

get_shell(){
	echo "Shell:" $SHELL  >> trash.txt
}

get_kernel(){
	echo "Kernel:" $kernel  >> trash.txt
}

get_uptime(){
	echo "Uptime:" $uptime  >> trash.txt
}

get_cpu(){
	echo "CPU:" $cpu  >> trash.txt
}

get_memory(){
	echo "Memory:" $memfree"/"$memavail  >> trash.txt
}

get_devices(){
	echo -e "Devices:""$devices"
}

get_packages(){
	echo "Packages:" $packages  >> trash.txt
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


# Display it
cat trash.txt | column -s":" -t
echo
get_devices
get_priviege
echo
echo "Welcome back," $user


# Cleanup
rm devices.txt
rm trash.txt
