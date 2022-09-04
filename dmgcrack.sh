#!/bin/bash
IFS=$'\n'
index=0
[ $# -eq 0 ] && { echo "Error: No Arguments Supplied."; echo "Usage: ./dmgcrack.sh wordlist encrypted_dmg"; exit 1; }

echo "########### Encrypted DMG password brute-forcer ##########";
echo "#################### Brute-forcing... ####################";

for i in $(cat $1);
do 
	index=$(( index + 1 ))
	printf "Testing line $index: "
	echo -ne "$i\033[0K\r"		#Erase or comment this line if you don't wish to print out the wordlist
	cmdResponse=`hdiutil attach -passphrase $i $2 2>&1;`
	if [[ ${cmdResponse} != *"failed"* ]];then
		echo "Encryption Key Found - '$i'";
		break
	fi
done
echo "Finished brute-forcing, key not found."