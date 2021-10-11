#!/bin/bash

# This is designed for Debian-based OS in progress
# This is just a cool bootscript to show system stats
# By: drampil@

echo "System scan in progress... please wait."

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
skull=$(curl -s https://raw.githubusercontent.com/drampil/toy-box/main/skull.txt)
user=$(whoami)
check=$(cat /etc/group | grep sudo | grep -o $user)
dmesg=$(dmesg | tail --lines=5 | sed 's/\[[^][]*\]//g; ' )

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
	echo "$skull"
	echo
}

get_dmesg(){
	echo "dmesg (-5)""$dmesg" >> trash.txt
}


get_header(){
	echo ":  SYSTEM SCAN IN PROGRESS..." >> trash.txt
}

get_user(){
	echo "User:" $user"@"$system":" >> trash.txt
}

get_hostname(){
	echo "Host:" $host":"  >> trash.txt
}

get_shell(){
	echo "Shell:" $SHELL":"  >> trash.txt
}

get_kernel(){
	echo "Kernel:" $kernel":"  >> trash.txt
}

get_uptime(){
	echo "Uptime:" $uptime":"  >> trash.txt
}

get_cpu(){
	echo "CPU:" $cpu":"  >> trash.txt
}

get_memory(){
	echo "Memory:" $memfree"/"$memavail":"  >> trash.txt
}

get_devices(){
	echo -e "Devices:""$devices"
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
get_dmesg

# Display it


cat trash.txt 
echo
get_devices
echo
get_priviege
echo
echo "Show me what you've got," $user"."
echo

# Cleanup
rm devices.txt
rm trash.txt
