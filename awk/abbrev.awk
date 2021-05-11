#!/usr/bin/awk -f

# convention "1stword-1stchar"+"2ndword-1stchar"+"2ndword-lastchar")
BEGIN{
  FS="-";
}
{
  si = length($2);
  print substr($1,1,1) substr($2,1,1) substr($2,si,si);
}
END{
}
