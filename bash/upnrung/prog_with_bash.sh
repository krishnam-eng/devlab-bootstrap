#!/usr/bin/env bash

# => This is a comment
# Use env to find bash instead of hardcoding bash path

######### Working with echo

echo "hello"

echo "there"

echo -n "no new line"

######### Working with variables
myvar="Anything"


# read only
declare -r mycon="you can't change me"

# helps with normalize the string
# lowerstring variable 
declare -l lowerstring="I am AWAYS lowerstring"
echo $lowerstring

# upperstring variable
declare -u upperstring="I am aways UPPER !"
echo $upperstring

# list all variables 

# $ declare -p 

# System variables
# $ env
echo $USER

####### Working with numbers

# +, -, *, /, %, **

# +=, -+

# ++, --

echo $RANDOM

echo "$((1+$RANDOM % 10)) - some random in 1..10"

######### Working with test and extended test
# bash -c 'help test'

# space around [] is must 
[ -d ~ ]

[ -f ~/.zshrc ]

[ "cat" -eq "dog" ] 

# eq, ne, lt, gt,...

# != , ==

# even regex !
[ "cat" =~ c.* ]


# multi condition

[[ -d ~ && -f ~/.zshrc ]]



