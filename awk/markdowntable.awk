# creates three column tables
# meant for creating keyboard keybinding table
BEGIN{
  print "|=====|=====|=====|"
}
NF==3{
  printf("|%5s|%-5s|%-5s|\n", $1, $2, $3)
}
END{
}
