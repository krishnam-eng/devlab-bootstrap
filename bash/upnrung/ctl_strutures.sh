#!/usr/bin/env bash

declare -i a=3

if [[ $a -gt 4 ]]
then
	echo "true"
else 
	echo "false"
fi 

if [[ $a -gt 4 ]];then
	echo "true"
else 
	echo "false"
fi 


if [[ $a -gt 4 ]];then
	echo ">4"
elif [[ $a -gt 1  ]];then 
	echo ">1"
fi 

