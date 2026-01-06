#!/bin/bash

 echo "$@ --------all varible passed the scripted."
 echo "$# ---------number of varible passed .(counting)"
echo "$0---------- Scripted name."
echo "$pwd------- working directory"
echo "$home----- home directory"
echo "$$-------- pid scripted execution"
echo "$!---------last pid for command"
echo "$?--------- state of previous command  0---> success  1 to 127-->fail"
echo "set -e automatic exit"
echo "set -ex for deburing"
