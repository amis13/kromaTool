#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

blockHeight="$(docker logs -n 10 kroma-node | awk '/l2_engineSyncTarget/ {print}' | sed 's/ \+/\n/g' | awk '/^l2_engineSyncTarget/ {print}' | tr -s ':' ' ' | awk 'NF{print $NF}')"

if [ "$blockHeight" ]; then

	docker logs -n 30 kroma-node | awk '/l2_engineSyncTarget/ {print}' | sed 's/ \+/\n/g' | awk '/^l2_engineSyncTarget/ {print}' | tr -s ':' ' ' | awk 'NF{print $NF}' > blocks.txt
	echo -e "\n${greenColour}[+]${endColour} ${grayColour}Block height: ${yellowColour}$(tail -n 1 blocks.txt)${endColour}\n"
	rm blocks.txt
else
	echo -e "\n${redColour}[+] The node isn't running${endColour}\n"
fi

#Ctrl+c
trap ctrl_c INT
