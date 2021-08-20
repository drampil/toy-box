Last login: Thu Aug 19 21:24:03 on ttys000

The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
3c22fb01df8c:~ drampil$ ssh -i "Desktop/us-east-keypair.pem" ec2-user@ec2-3-84-173-113.compute-1.amazonaws.com
Last login: Fri Aug 20 01:24:03 2021 from 72-21-196-66.amazon.com

       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/


                   ░
               ░  ░
              ░  ░
             ░    ░     ▄▀ ▄▀
              ░       ▄▀ ▄▀
              ▄▄█\█▄▄▀ ▄▀
         __▄`/█/`██`█▄▀__
       ▄▀·`.,█.██\-██/█`·▀▄
      ▐█▄██████,,████πr8▄▄█▌
      ▐▓▓▓▄▄▄▄▄▄▄▄▄▄▄▄▄▄▒▒░▌
      ▐▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▌
       █▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░█
       ▐▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░▌
        ▀█▓▓▓▓▓▒▒▒▒▒▒▒░░█▀
          ▀██▓▓▒▒▒▒▒▒██▀
             ▀▀▀▀▀▀▀▀



User:  ec2-user@Linux
Host:  ip-172-31-40-160.ec2.internal
Shell:  /bin/bash
Kernel:  4.14.238-182.422.amzn2.x86_64
Uptime:  up 1 week, 7 hours, 49 minutes
CPU:  Intel(R) Xeon(R) CPU E5-2676 v3 @ 2.40GHz
Memory: 158176 kB/742588 kB
Devices: xvda    202:0    0  100G  0 disk 
	 └─xvda1 202:1    0  100G  0 part /
Packages Installed: 465

Welcome back, ec2-user
[ec2-user@ip-172-31-40-160 ~]$ clear


[ec2-user@ip-172-31-40-160 ~]$ vim identity.sh 

















































  1 #!/bin/bash
  2 
  3 # This is designed for Amazon EC2 Linux
  4 # This is just a cool bootscript to show system stats
  5 # By: drampil@
  6 
  7 # Adding some variables
  8 user=$(whoami)
  9 system=$(uname)
 10 kernel=$(uname -r)
 11 uptime=$(uptime -p)
 12 host=$(hostname)
 13 cpu=$(cat /proc/cpuinfo | grep "model name" | sed 's/[^,:]*://g')
 14 memavail=$(cat /proc/meminfo | grep "MemAvailable" | sed 's/[^*,:]*://g' | sed 's/^ *//g')
 15 memfree=$(cat /proc/meminfo | grep "MemFree" | sed 's/[^*,:]*://g' | sed 's/^ *//g')
 16 devices=$(lsblk | awk '(NR>1)' > devices.txt; cat devices.txt | sed 's/└─/\t └─/g')
 17 packages=$(yum list installed | wc -l)
 18 
 19 
 20 # Functions list
 21 get_logo(){
 22         curl -L rum.sh/ricebowl
 23 }
 24 
 25 get_user(){
 26         echo "User: " $user"@"$system
 27 }
 28 
 29 get_hostname(){
 30         echo "Host: " $host
 31 }
 32 
 33 get_shell(){
 34         echo "Shell: " $SHELL
 35 }
 36 
 37 get_kernel(){
 38         echo "Kernel: " $kernel
 39 }
 40 
 41 get_uptime(){
 42         echo "Uptime: " $uptime
 43 }
 44 
 45 get_cpu(){
 46         echo "CPU: " $cpu
 47 }
 48 
 49 get_memory(){
 50         echo "Memory: "$memfree"/"$memavail
 51 }
 52 
 53 get_devices(){
                                                                                        1,1           Top
