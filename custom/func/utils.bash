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