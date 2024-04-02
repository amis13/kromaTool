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

ctrl_c(){
	echo -e "\n\n${redColour}[!] Aborting installer...${endColour}\n"
	tput cnorm && exit 1
}

#Ctrl+C
trap ctrl_c INT

path="$(find ~ -type d -name kroma-up)"

installer(){
	tput civis
	echo -e "$\n{yellowColour}[+]${endColour} ${grayColour}Starting automatic installation of the tools${endColour}\n"
	cd "$path" && cd ..

	checker="$(find ~ -type d -name kromaTool)"

	if [ ! "$checker" ]; then
		git clone https://github.com/amis13/kromaTool.git &>/dev/null && cd kromaTool

		for file in tools/*; do
			route="$(realpath "$file")"

			chmod +x "$route"
			ln -s "$route" -t /usr/bin/
		done
		echo -e "${greenColour}[+]${endColour} ${grayColour}The automatic installation of the tools has been completed${endColour} ${greenColour}successfully${endcolour}${grayColour}!${endColour}\n"
	else
		echo -ne "${yellowColour}[!]${endColour} ${grayColour}You already have kroma tools installed, do you want to update them? (y/n) --> ${endColour}" && read yes_no

		if [ "$yes_no" == "y" ]; then
			updateTool
		elif [ "$yes_no" == "n" ]; then
			tput cnorm && exit 0
		else
			echo -e "${redColour}[!] ERROR: You have entered an invalid character, use (y/n)${endColour}\n"
			tput cnorm && exit 1
		fi
	fi
	tput cnorm && exit 0
}

if [ "$path" ]; then
	installer
else
	tput civis
	echo -e "\n${yellowColour}[!] WARN:${endColour} ${grayColour}This is a tool exclusively for kroma validators and nodes${endColour}\n"
	echo -ne "${yellowColour}[!] ${grayColour}Do you want to install kroma-up? (y/n) --> ${endColour}" && read y_n

	if [ "$y_n" == "y" ]; then
		cd $HOME && git clone https://github.com/kroma-network/kroma-up.git
		installer
		echo -e "${yellowColour}[!]${endColour} ${grayColour}Check the documentation on:${endColour} ${blueColour}https://docs.kroma.network/developers/running-nodes-on-kroma${endColour} ${grayColour}to be able to use the tools${endColour}\n"
		echo -e "${yellowColour}[!]${endColour} ${grayColour}Check the documentation of the tools on:${endColour} ${blueColour}https://github.com/amis13/kromaTool${endColour} ${grayColour}to be able to use the tool${endColour}\n"
	elif [ "$y_n" == "n" ]; then
		tput cnorm && exit 0
	else
		echo -e "${redColour}[!] ERROR: You have entered an invalid character, use (y/n)${endColour}\n"
		tput cnorm && exit 1
	fi
	tput cnorm && exit 0
fi
