reverse(){
 echo "${(j::)${(@Oa)${(s::):-${1}}}}"
}

# N digits long
nrandom(){
  echo ${(l:${1}::0:)${RANDOM}}
}

# remove all spaces and tabs at the end of each line
rmspace(){
  sed -i 's/[[:space:]]*$//' $1
}
