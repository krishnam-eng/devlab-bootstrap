**Unary operators that check file characteristics**

```
Option Description
-b File is a block special device (for files like /dev/hda1)
-c File is character special (for files like /dev/tty)
-d File is a directory
-e File exists
-f File is a regular file
-g File has its set-group-ID (setgid) bit set
-h File is a symbolic link (same as -L)
-G File is owned by the effective group ID
-k File has its sticky bit set
-L File is a symbolic link (same as -h)
-N File has been modified since it was last read
-O File is owned by the effective user ID
-p File is a named pipe
-r File is readable
-s File has a size greater than zero
-S File is a socket
-u File has its set-user-ID (setuid) bit set
-w File is writable
-x File is executable
```

**Explanation of assignment operators in bash**
```
Operator Operation with assignment Use Meaning
= Simple assignment a=b a=b
*= Multiplication a*=b a=(a*b)
/= Division a/=b a=(a/b)
%= Remainder a%=b a=(a%b)
+= Addition a+=b a=(a+b)
-= Subtraction a-=b a=(a-b)
<<= Bit-shift left a<<=b a=(a<<b)
>>= Bit-shift right a>>=b a=(a>>b)
&= Bitwise “and” a&=b a=(a&b)
^= Bitwise “exclusive or” a^=b a=(a^b)
\ = Bitwise “or” a|=b
```

**Testing for More than One Thing**

Use the operators for logical AND (-a) and OR (-o) to combine more than one test
in an expression. For example:
```
if [ -r $FILE -a -w $FILE ]
```

**Testing for String Characteristics**
```
if [ -z "$VAR" ]
then
echo zero length
else
echo has text
fi
```

**Testing for Equality**
The type of comparison you need determines which operator you should use. Use the
-eq operator for numeric comparisons and the equality primary = (or ==) for string
comparisons

