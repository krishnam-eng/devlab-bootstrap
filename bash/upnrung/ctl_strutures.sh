#!/usr/bin/env bash

##### Conditional statements with the if keywords 
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

######## workign with while and untill loops 

echo "While Loop"

declare -i n=0

while (( n < 10 ))
do
	echo "n: ${n}"
	((n++))   # not $n - bzc that would be lile 0++ variable expanstion is not needed here

done 

echo "Until Loop"

declare -i m=0

until (( m == 10 )) # break condition 
do
	echo "m: ${m}"
	((m++))   # not $n - bzc that would be lile 0++ variable expanstion is not needed here
	#sleep 1
done 

echo "For Loop"

declare -i m=0

for i in {1..10}
do
	echo "i: ${i}"
    #sleep 1
done

for (( i=1; i<=100; i++ ))
do
	echo $i
done


declare -a fruits=("apple" "banana" "cherry")
for i in ${fruits[@]}
do
	echo "Taking $i out from Fruit Basket "
done 


for i in $(ls)
do
	echo $i
done

echo "selecting behavior using case"

animal="dog"

case $animal in
	cat) echo "rose";; # one for ; is for what we execute and one ; is for telling i am done with action 
	dog|puppy) echo "K";;
	*) echo "";;
esac


greet(){
	echo "Hi there ! $1"  # $2...n arg numbers

}

# call function 
greet
greet "Bala"

echo "======= FUN Variable========="

greetall(){
	for i in $@   #$* also gives params
	do
		echo "arg: $i for $FUNCNAME"  # $0 is reserved for function's name 
	done 
}

greetall "B" "A" "C"

greetall $(ls .)


echo "=========== local var ========"

var1="I'm global"

myfun(){
	var2="I'm inside fun" # it is also global . 
	local var3="I'm var with local"
}

echo $var1
echo $var2
echo $var3


echo "=======Writing and reading file========="
# >, >|, >>, <

for i in {1..10}
do
	$(mkdir -p out/)
	echo "line number $i" >> out/stdout.log
done

while read f       #reads from input redirection
	do echo "$f"
done < out/stdout.log
