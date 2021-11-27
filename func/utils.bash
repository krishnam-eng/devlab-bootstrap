reverse(){
 echo "${(j::)${(@Oa)${(s::):-${1}}}}"
}

# N digits long
nrandom(){
  echo ${(l:${1}::0:)${RANDOM}}
}