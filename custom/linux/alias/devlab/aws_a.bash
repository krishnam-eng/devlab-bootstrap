# Creating (make) a bucket

alias as3mb="aws s3 mb" # s3://your-bucket-name

# Uploading a file to a bucket
alias as3cp="aws s3 cp" # /path/to/local/file s3://your-bucket-name/path/to/s3/object

# Downloading a file from a bucket
alias as3cp="aws s3 cp" # s3://your-bucket-name/path/to/s3/object /path/to/local/file

# Listing the contents of a bucket
alias as3ls="aws s3 ls" # s3://your-bucket-name

# Deleting a file from a bucket
alias as3rm="aws s3 rm" # s3://your-bucket-name/path/to/s3/object

# Deleting a bucket
alias as3rb="aws s3 rb" # s3://your-bucket-name