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
	echo "\n\n${redColour}[!] Aborting installer...${endColour}\n"
	tput cnorm && exit 1
}

#Ctrl+C
trap ctrl_c INT

path="$(find ~ -type d -name kroma-up | awk 'NR==1{print $0}')"
absolute_path="$(find / -type d -name kroma-up 2>/dev/null | awk 'NR==1{print $0}')"
TOOLS_URL="https://github.com/amis13/kromaTool.git"
KROMA_URL="https://github.com/kroma-network/kroma-up.git"

installer(){
	tput civis
	echo "\n${greenColour}[+]${endColour} ${grayColour}Starting automatic installation of the tools${endColour}\n"
	echo "${yellowColour}[+]${endColour} ${grayColour}This may take a few minutes${endColour}\n"

	(cd "$path" && cd ..) || (cd "$absolute_path" && cd ..)

	checker="$(find / -type d -name kromaTool 2>/dev/null)"

	if [ ! "$checker" ]; then
		(git clone $TOOLS_URL &>/dev/null) && sleep 3 && cd kromaTool/

		for file in tools/*; do
			route="$(echo $file | awk -F '/' '{print $2}' | xargs realpath)"
			the_file="$(echo $file | awk -F '/' '{print $2}')"
			chmod +x "$the_file"
			ln -s "$route" "/usr/bin/$the_file"
		done
		echo "${greenColour}[+]${endColour} ${grayColour}The automatic installation of the tools has been completed${endColour} ${greenColour}successfully${endColour}${grayColour}!${endColour}\n"
	else
		echo "${yellowColour}[!]${endColour} ${grayColour}You already have kroma tools installed, do you want to update them? (y/n) --> ${endColour}" && read yes_no

		if [ "$yes_no" == "y" ]; then
			updateTool
		elif [ "$yes_no" == "n" ]; then
			tput cnorm && exit 0
		else
			echo "${redColour}[!] ERROR: You have entered an invalid character, use (y/n)${endColour}\n"
			tput cnorm && exit 1
		fi
	fi
	tput cnorm && exit 0
}

if [ "$path" ] || [ "$absolute_path" ]; then
	installer
else
	tput civis
	echo "\n${yellowColour}[!] WARN:${endColour} ${grayColour}This is a tool exclusively for kroma validators and nodes${endColour}\n"
	echo "${yellowColour}[!]${endColour} ${grayColour}Do you want to install kroma-up and tools? (y/n) --> ${endColour}" && read y_n

	if [ "$y_n" == "y" ]; then
		cd "$HOME" && git clone $KROMA_URL &>/dev/null
		echo "${greenColour}[+]${endColour} ${grayColour}The repository has been ${greenColour}successfully${endColour} ${grayColour}cloned!${endColour}\n"
		installer
		echo "${yellowColour}[!]${endColour} ${grayColour}Check the documentation on:${endColour} ${blueColour}https://docs.kroma.network/developers/running-nodes-on-kroma${endColour} ${grayColour}to be able to use the tools${endColour}\n"
		echo "${yellowColour}[!]${endColour} ${grayColour}Check the documentation of the tools on:${endColour} ${blueColour}https://github.com/amis13/kromaTool${endColour}${endColour}\n"
	elif [ "$y_n" == "n" ]; then
		tput cnorm && exit 0
	else
		echo "${redColour}[!] ERROR: You have entered an invalid character, use (y/n)${endColour}\n"
		tput cnorm && exit 1
	fi
fi
