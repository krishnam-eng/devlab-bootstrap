#!/usr/bin/env bash

echo ======arguments============

echo "Hi $1"
echo "hello anyboady $2 $3"

echo "hello from $0"

echo "hello all $@"



echo =========options==========

# note: option should be given first to the script ...option first and everything is args

# : means option have arguments , otherwise just aflag
# bash interacting_with_user.sh -p 0898 -u krishnam -a -b
while getopts "u:p:ab" option; do
	case "${option}" in
		u) user=${OPTARG};;
		p) pwd=${OPTARG};;
		a) echo "got A flag";;
		b) echo "got B flag";;
		?) echo "i don't know what is ${OPTARG}";;
		*) echo "no match";;
	esac
done

echo "option -u: "$user
echo "option -p: "$pwd

echo ======get i/ps while executing========

echo "what is your name?"
read name
echo "what is the pwd?"
# -s read silent 
read -s pwd
echo "pwd: $pwd"

## man read - timeout ...

echo "which animal"
select animal in "cat" "dog" "fish"
do
	echo "you selected ${animal} !"
	break
done

#which animal
#1) cat
#2) dog
#3) fish
#? 1
#you selected cat !


echo "which animal"
select animal in "cat" "dog" "fish"
do
	case $animal in
		cat) echo "you selected ${animal}. mee mee !";;
		dog) echo "you selected ${animal}. Ror ror !";;
	esac
	break
done

echo ===========Ensure response 

echo ==what if user skip inout by enter =========

# e read line interpreter 
read -ep "Fav color? " -i "blue" favcolor
echo $favcolor

if (( $#<3 )); then
	echo "this cmd needs three args"
	echo "usr name, pwd, server"
else
	#
	echo "username: $1"
	echo "pwd: $2"
	echo "server: $3"
fi

echo "======== u can't move utill you give me an answer: kind of needy :) ====="

read -p "Fav color? " fav
while [[ -z $fav ]]
do
	echo "I need answers !"
	read -p "Fav color? " fav
done

echo === show default 
read -p "Fav color? [blue]" fav
if [[ -z $fav ]]
then
	fav="blue"
	echo "$fav is selected"
fi

# use regex for validation

read -p "what yeay? [yyyy]" year
until [[ $year =~ [0-9]{4} ]]
do
	read -p "A year , pleas ! [yyyy]" year
done


