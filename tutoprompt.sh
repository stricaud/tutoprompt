#!/bin/bash

TITLE="\e[1;44m"
CONTENT="\e[44m"
EXAMPLE="\e[93;44m"
RESULT="\e[93;44m"

COLS=$(tput cols)

function check_installed() {
    if [ ! -d $HOME/.tutoprompt/ ]
    then
	echo "Tutoprompt has no tutorial installed. Please run ./tutoprompt.sh --install <tutorial-dir>"
	return 1
    fi
}

function fetch_step() {
    if [ ! -e $HOME/.tutoprompt/step ]
    then
	echo "1" > $HOME/.tutoprompt/step
    fi
}

function println() {
    color=$1
    str=$2

    remains=$(($COLS - ${#str}))
    echo -en "$color$str"
    for i in $(seq $remains)
    do
	echo -n " "
    done
    echo -e "\e[0m"
}

function printfile() {
    file=$1
    while read line
    do
	if [ ${#line} -gt 3 ]
	then
	    action=${line:0:1}
	    str=${line:2:${#line}-2}
	    case "$action" in
		"T")
		    println $TITLE "$str"
		    ;;
		"C")
		    println $CONTENT "$str"
		    ;;
		"E")
		    println $EXAMPLE "$str"
		    ;;
		"R")
		    println $RESULT "$str"
		    ;;
	    esac
	fi	
    done < $file    
}

function print_all() {
    echo ""
    println $TITLE "Faup tutorial: Step 1"
    println $CONTENT "We are going to show how faup can parse urls."
    println $EXAMPLE "$ faup www.hack.lu"
    println $RESULT ",,www,hack.lu,hack,www.hack.lu,lu,,,,,mozilla_tld"
}

# check_installed
# if [ $? -eq 1 ]
# then
#     return
# fi

printfile examples/faupworkshop/step1.txt



#echo "$?"
#export PROMPT_COMMAND=print_all

