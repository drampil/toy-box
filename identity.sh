#!/bin/bash

# This is designed for Amazon EC2 Linux

# Adding some variables
user=$(whoami)
system=$(uname)
kernel=$(uname -r)
uptime=$(uptime -p)
host=$(hostname)
cpu=$(cat /proc/cpuinfo | grep "model name" | sed 's/[^,:]*://g')
memavail=$(cat /proc/meminfo | grep "MemAvailable" | sed 's/[^*,:]*://g' | sed 's/^ *//g')
memfree=$(cat /proc/meminfo | grep "MemFree" | sed 's/[^*,:]*://g' | sed 's/^ *//g')

# Functions list
get_logo(){
	curl -L rum.sh/ricebowl
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

# Run all the functions in this order
get_logo
get_user
get_hostname
get_shell
get_kernel
get_uptime
get_cpu
get_memory
echo
echo "Welcome back, person."
