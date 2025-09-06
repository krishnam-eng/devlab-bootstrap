################
#                Expansions
#
#         Alias Expansion
#   ${}   Parameter Expansion  [ e.g a=cat ; echo ${a}man => catman
#   $()   Command Substitution [ echo $(date)
#   $(()) Arithmetic Expansion [ echo $[4/2] - 2
#   {}    Brace Expansion      [ e.g %echo c{a,o,u}t => cat cot cut, %echo {1..5} => 1 2 3 4 5
#   !     History Expansion
#   *?[]^ Filename Generation  or Globbing as in Global Substitution
#         Process Sub          [ => > < >> | , tee
#         Filename Exp         [ ~ , =ls , ~customshortname
#         Process Sub          [ => > < >> | , tee#
###############

##############
#               Globbing
#
# Basic
#      * - wildcard - any chars
#      ? - any single char        [ ls script.?? > script.sh
#     [] - bracket for a sequance of chars. supports char set also like [[:alpha:]]*
#      ^ - avoid [^o] - no o
# Extended
#    **/ - recursive searching in child dirs  [ **/*.md - it matchs all md files in child dir also
#   ***/ - recursive searching including links   [  ***/*.md - it matchs all md files including links
#    (|) - alternate pattern [  *.(bash|zsh) matchs both script files
#    <-> - numeric ranges    [ log_<10-20>.txt
#     ~  - should not match [ b*~*.o - file start with b and do nto have .o in it
#     ^  - caret and tilde does the same - operator for negating
# Qualifier
#     (/) - dir
#     (.) - file
#     (@) - link
#     (rwx) - read, write, execute
#     (o) - order n- name, L- size , m- modified
#     (O) - Reverse sort
#  Time Qualifier
#     (mh-1) -  modified in last 1h
#     (ch-1) -  created in last 1h
#     (ah-1) -  accessed in last 1h
#     h, m, w, M - hour, min, week, Month
# File Size Qualifier
#     (L[kmg][+-]size) kb, mb, gb, larger than, smaller than
###############
# echo 'Globbing...'

# do not show "no matches found:..."
setopt null_glob

# do nto show "no bad pattern" either
setopt no_bad_pattern

# make it similar to bash - in case of any nomatch, pattern will be treated as string
unsetopt nomatch

# enable extened globbing. this enables cool features like recursive seraching "**/"
setopt EXTENDED_GLOB

# Bulk rename utility - works based on pattern
autoload -Uz zmv # e.g zmv '(*)_(*)' 'out_$2.$1', use -n option to do dry-run