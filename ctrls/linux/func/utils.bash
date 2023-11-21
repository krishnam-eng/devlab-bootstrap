decode64() {
  # Check if the required argument is provided
  if [ -z "$1" ]; then
    echo "Error: Base64-encoded string is missing."
    return 1
  fi

  # Decode the Base64-encoded string and print the result
  decoded_string=$(echo "$1" | base64 --decode)
  echo "$decoded_string"
}

a1z26() {
    input_string="$1"
    encoded_string=""

    for (( i=0; i<${#input_string}; i++ )); do
        char="${input_string:$i:1}"
        encoded_char=$(a1z26_encode_char "$char")
        encoded_string="${encoded_string}${encoded_char} "
    done

    echo "$encoded_string"
}

a1z26_encode_char() {
    char="$1"
    case "$char" in
        [aA]) echo 1 ;;
        [bB]) echo 2 ;;
        [cC]) echo 3 ;;
        [dD]) echo 4 ;;
        [eE]) echo 5 ;;
        [fF]) echo 6 ;;
        [gG]) echo 7 ;;
        [hH]) echo 8 ;;
        [iI]) echo 9 ;;
        [jJ]) echo 10 ;;
        [kK]) echo 11 ;;
        [lL]) echo 12 ;;
        [mM]) echo 13 ;;
        [nN]) echo 14 ;;
        [oO]) echo 15 ;;
        [pP]) echo 16 ;;
        [qQ]) echo 17 ;;
        [rR]) echo 18 ;;
        [sS]) echo 19 ;;
        [tT]) echo 20 ;;
        [uU]) echo 21 ;;
        [vV]) echo 22 ;;
        [wW]) echo 23 ;;
        [xX]) echo 24 ;;
        [yY]) echo 25 ;;
        [zZ]) echo 26 ;;
        *) echo "$char" ;;
    esac
}