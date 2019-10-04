#!/bin/bash -i
#
# We check the next step by reading a log file.
# Wrap your command like this:
# #!/bin/bash
# CMD=$(basename $0)
# echo "$CMD $@" > /tmp/command.tutoprompt
# eval /opt/faup/$CMD "$@"
#
# Put the original command in /opt/faup/ (choose another directory of course ;-))
#
# Tutoprompt reads /tmp/command.tutoprompt to validate if we should go to the next step
# 
COMMAND_LOG=/tmp/command.tutoprompt

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

function init_step() {
    if [ ! -e $HOME/.tutoprompt/step ]
    then
	mkdir $HOME/.tutoprompt/
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

function current_step() {
    return $(cat $HOME/.tutoprompt/step)
}

function next_step() {
    current_step
    local step=$(echo $?)
    let "next=step+1"
    return $next
}

function validate() {
    last_cmd=$(history 2 |head -n1)
#    last_cmd=$(history 2 | sed 's/^ *[^ ]* *//')
    echo "last:$last_cmd"
}

# check_installed
# if [ $? -eq 1 ]
# then
#     return
# fi

init_step

# validate -> wrap faup to log command

current_step
step=$(echo $?)
echo "step:$step"

next_step
step=$(echo $?)
echo "step:$step"

# Read log file
# If it matches the actual step validation
# 

#printfile examples/faupworkshop/step1.txt



#echo "$?"
#export PROMPT_COMMAND=print_all

