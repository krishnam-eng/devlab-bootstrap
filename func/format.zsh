

# remove all spaces and tabs at the end of each line
# -a all files in child dir recursively
# just globbing pattern with out -a option - only for specified files
rmspace(){
  while getopts "af:" opt
  do
    case $opt in
    a)  echo "all file option is selected !";

        for f in **/*.*
        do
          echo "$LOG_TS Removing space from EOL for $f"
          sed -i 's/[[:space:]]*$//' $f
        done;;

    f)  echo "$LOG_TS Removing space from EOL for $OPTARG";

        sed -i 's/[[:space:]]*$//' $OPTARG;;
    esac
  done
}
