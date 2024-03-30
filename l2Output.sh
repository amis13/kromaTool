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


function ctrl_c(){
        echo -e "\n\n${redColour}[!] Exiting...${endColour}\n"
        tput cnorm && exit 1
}

#Ctrl+c
trap ctrl_c INT

function searchSubmitedOutputs(){
        tput civis
        echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Searching submited L2Outputs...${endColour}\n"
        submitedOutputs="$(docker logs kroma-validator | awk '/\"L2output successfully submitted\"/{print $3, $4, $5}' | tr -s '"' ' ' | awk '{print $2, $3, $4}')"
        if [ "$submitedOutputs" ]; then
                docker logs kroma-validator | awk '/\"L2output successfully submitted\"/{print $3, $4, $5}' | tr -s '"' ' ' | awk '{print $2, $3, $4}' > counter.txt
                echo -e "${greenColour}[+]${endColour} ${grayColour}There are ${yellowColour}$(wc -l counter.txt | awk '{print $1}')${endColour} L2outputs${endColour} ${greenColour}successfully${endColour} ${grayColour}submitted${endColour}\n"
                rm counter.txt
        else
                echo -e "${redColour}[+] There aren't submited L2Outputs${endColour}\n"
        fi
        tput cnorm && exit 0
}

function searchFailedSubmitedOutputs(){
        tput civis
        echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Searching Failed submited L2Outputs...${endColour}\n"
        failedSubmitedOutputs="$(docker logs kroma-validator | awk '/\"failed to submit L2Output\"/ {print $3, $4, $5, $6}' | tr -s '"' ' ' | awk '{print $2, $3, $4, $5}')"
        if [ "$failedSubmitedOutputs" ]; then
                docker logs kroma-validator | awk '/\"failed to submit L2Output\"/ {print $3, $4, $5, $6}' | tr -s '"' ' ' | awk '{print $2, $3, $4, $5}' > failedCounter.txt
                echo -e "${greenColour}[+]${endColour} ${grayColour}There are ${yellowColour}$(wc -l failedCounter.txt | awk '{print $1}')${endColour} L2outputs${endColour} ${redColour}unsuccessfully ${endColour}${grayColour}submitted${endColour}\n"
                rm failedCounter.txt
        else
                echo -e "${redColour}[+] There aren't unsuccessful submited L2Outputs${endColour}\n"
        fi
        tput cnorm && exit 0
}

function helpPanel(){
        echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Use: ${endColour}${yellowColour}$0${endColour}\n"
        echo -e "\t${blueColour}-b)${endColour} ${grayColour}Search submited L2Outputs${endColour}\n"
        echo -e "\t${blueColour}-f)${endColour} ${grayColour}Failed submited L2Outputs${endColour}\n"
        echo -e "\t${blueColour}-h)${endColour} ${grayColour}Show this help panel${endColour}\n"
        tput cnorm
}

declare -i parameter_counter=0

while getopts "bfh" arg; do
        case $arg in
                b) let parameter_counter+=1;;
                f) let parameter_counter+=2;;
                h) ;;
        esac
done

if [ $parameter_counter -eq 1 ]; then
        searchSubmitedOutputs
elif [ $parameter_counter -eq 2 ]; then
        searchFailedSubmitedOutputs
else
        helpPanel
fi
