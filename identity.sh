#!/bin/bash

# This is designed for Amazon EC2 Linux
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
packages=$(yum list installed | wc -l)
skull=$(cat skull.txt)
user=$(whoami)
check=$(cat /etc/group | grep wheel | cut -d ":" -f 4)
dmesg=$(dmesg | tail --lines=5 | sed 's/\[[^][]*\]//g; s/\: /_/g; s/^/:|/g; s/$/:|/g; ' )
selinux=$(sestatus | awk 'NR==1 {print $3}')
selinuxmode=$(getenforce)
firewall=$(systemctl status firewalld | grep Active | awk '{print $2}')
yumv=$(yum info yum | grep -i version | awk '{print $3}')

# Functions list

get_priviege(){
if [[ $user = $check ]];
then
        echo "You have root powers."
else
        echo "You don't have any power here!"
fi
}

get_yumv(){
	echo "Yum Version:| ""$yumv"":|" >> trash.txt
}

get_selinux(){
if [[ $selinux = "disabled" ]];
then
	echo "SELINUX:|"" $selinux"":|" >> trash.txt
elif [[ $selinux = "enabled" ]];
then
	echo "SELINUX:|"" $selinux"":|" >> trash.txt
	echo "MODE:|"" $selinuxmode"":|" >> trash.txt
else
	echo "SELinux encountered an issue" >> trash.txt
fi
}

get_logo(){
	echo "$skull"
	echo
}

get_dmesg(){
	echo "dmesg (-5)""$dmesg" >> trash.txt
}

get_firewall(){
	echo "Firewalld:| ""$firewall"":|" >> trash.txt
}

get_header(){
	echo ":  SYSTEM SCAN IN PROGRESS..." >> trash.txt
}

get_user(){
	echo "User:|" $user"@"$system":|" >> trash.txt
}

get_hostname(){
	echo "Host:|" $host":|"  >> trash.txt
}

get_shell(){
	echo "Shell:|" $SHELL":|"  >> trash.txt
}

get_kernel(){
	echo "Kernel:|" $kernel":|"  >> trash.txt
}

get_uptime(){
	echo "Uptime:|" $uptime":|"  >> trash.txt
}

get_cpu(){
	echo "CPU:|" $cpu":|"  >> trash.txt
}

get_memory(){
	echo "Memory:|" $memfree"/"$memavail":|"  >> trash.txt
}

get_devices(){
	echo -e "Devices:""$devices"
}

get_packages(){
	echo "Packages:| "$packages":|"  >> trash.txt
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
get_selinux
get_yumv
get_firewall
get_dmesg

# Display it
cat trash.txt | column -s":" -t
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
