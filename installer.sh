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

tput civis
echo -e "\n${greenColour}[+]${endColour} ${grayColour}Starting automatic installation of the tools${endColour}\n"
echo -e "${yellowColour}[+]${endColour} ${grayColour}This may take a few minutes${endColour}\n"

absolute_path="$(find / -type d -name kroma-up 2>/dev/null | awk 'NR==1{print $0}')"
KROMA_URL="https://github.com/kroma-network/kroma-up.git"

installer(){
	checker_binary="$(which l2Output || which blockHeight || which updateKromaTools)"

	if [ ! "$checker_binary" ]; then

		for file in tools/*; do
			route="$(realpath "$file")"

			chmod +x "$route"
			ln -s "$route" /usr/bin/
		done
		echo -e "${greenColour}[+]${endColour} ${grayColour}The automatic installation of the tools has been completed${endColour} ${greenColour}successfully${endColour}${grayColour}!${endColour}\n"
		echo -e "${yellowColour}[!]${endColour} ${grayColour}Check the documentation of the tools on:${endColour} ${blueColour}https://github.com/amis13/kromaTool${endColour}${endColour}\n"
	else
		while true; do

			echo -ne "${yellowColour}[!]${endColour} ${grayColour}You already have kroma tools installed, do you want to update them? (y/n) --> ${endColour}" && read yes_no

			if [ "$yes_no" == "y" ]; then
				updateKromaTools
				tput cnorm && exit 0
			elif [ "$yes_no" == "n" ]; then
				tput cnorm && exit 0
			else
				echo -e "\n${redColour}[!] ERROR: You have entered an invalid character, use (y/n)${endColour}\n"
				sleep 1
			fi
		done
	fi
	tput cnorm
}

if [ "$absolute_path" ]; then
	installer
else
	echo -e "${yellowColour}[!] WARN:${endColour} ${grayColour}This is a tool exclusively for kroma validators and nodes${endColour}\n"

	while true; do
		echo -ne "${yellowColour}[!]${endColour} ${grayColour}Do you want to install kroma-up and tools? (y/n) --> ${endColour}" && read y_n

		if [ "$y_n" == "y" ]; then
			cd "$HOME" && git clone "$KROMA_URL" &>/dev/null
			echo -e "${greenColour}[+]${endColour} ${grayColour}The repository has been ${greenColour}successfully${endColour} ${grayColour}cloned!${endColour}\n"

			kromaTools="$(find / -type d -name kromaTool 2>/dev/null)"

			cd "$kromaTools" && installer
			echo -e "${yellowColour}[!]${endColour} ${grayColour}kroma-up has been cloned in:${endColour} ${yellowColour}$HOME/kroma-up${endColour}\n"
			echo -e "${yellowColour}[!]${endColour} ${grayColour}Check the documentation on:${endColour} ${blueColour}https://docs.kroma.network/developers/running-nodes-on-kroma${endColour} ${grayColour}to be able to use the tools${endColour}\n"
			tput cnorm && exit 0
		elif [ "$y_n" == "n" ]; then
			tput cnorm && exit 0
		else
			echo -e "${redColour}[!] ERROR: You have entered an invalid character, use (y/n)${endColour}\n"
			sleep 1
		fi
	done
fi
