#!/bin/bash

number=$1

if [ $number -gt 20 ]
then
    echo "given number is greater then  $number"
else
    echo "given number is less then  $number"
fi