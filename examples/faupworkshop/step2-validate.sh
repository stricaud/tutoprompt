#!/bin/bash
LAST_SHELL_CMD_LINE=$1
if [[ $1 =~ ^"faup -o json" ]]
then
    exit 0
else
    exit 1
fi




