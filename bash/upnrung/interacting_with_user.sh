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

