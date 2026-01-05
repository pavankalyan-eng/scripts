#!/bin/bash


set -e 
failure(){
    echo "$1:$2"
}

trap 'failure "${line no} ${bashcommand}"' ERR  

echo "hiiiiiii"
echooooo "command not founf"
echo "failure command"