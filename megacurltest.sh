#!/bin/bash

echo -e "  __  __                         _   _ ____  _     "
echo -e " |  \/  | ___  __ _  __ _    ___| | | |  _ \| |    "
echo -e " | |\/| |/ _ \/ _  |/ _  |  / __| | | | |_) | |    "
echo -e " | |  | |  __/ (_| | (_| | | (__| |_| |  _ <| |___ "
echo -e " |_|  |_|\___|\__, |\__,_|  \___|\___/|_| \_\_____|"
echo -e "              |___/                                "
echo
echo
echo "Please enter a single URL, enter one URL per line, or paste all URLs at the same time as a block."
array=()
while IFS= read -r -p "" url; do
    [[ $url ]] || break
    array+=("$url")
done
grab=$(printf ' %s\n' "${array[@]}")
echo "---Beta Script: Mega cURL---"
echo
for i in $(echo $grab | sed 's/[h]xx[p]/http/gi; s/[][]//g;'); do echo  "$i";
echo ">>>>>>>>"
echo "$(curl -I -s -L -k -m 5 --show-error $i | grep 'HTTP\|Location\|location\|x-amz-apigw-id\|CloudFront\|x-amz-cf-id:\|AmazonS3')"
echo; done
echo "---Formatted Stack---"
echo
