`This page is the outcome of learning awk programming. it contains learning notes and act as my quick reference card`

![Mimetypes-application-x-awk-icon](https://user-images.githubusercontent.com/82016952/117792222-b8b2ca80-b268-11eb-9bdb-6afbd8bb8ade.png)

- [AWK / GAWK](#awk--gawk)
  - [Basics](#basics)
    - [Structure](#structure)
      - [Statements](#statements)
      - [Variables](#variables)
      - [Operations](#operations)
    - [Running AWK](#running-awk)
      - [Options](#options)
  - [Reading Input: Records and Fields](#reading-input-records-and-fields)
  - [Printing Output: Formatting, Records and Fields](#printing-output-formatting-records-and-fields)
  - [Regular Expressions](#regular-expressions)
    - [Basic](#basic)
    - [Quantifiers](#quantifiers)
    - [Bracket Experssion (Sets)](#bracket-experssion-sets)
    - [Character Classes (set)](#character-classes-set)
    - [Escape Sequence](#escape-sequence)
    - [Groups](#groups)
    - [Assertions](#assertions)
    - [Flags](#flags)


# AWK / GAWK
Basic function of awk is to search files for lines and perform actions on that line using awk program. This program consist of _pattern-action_ pairs.

- awk program is data driven where as most others are procedural - where you describe every steps in great details.
- awk program is consists of a series of rules.
- a rule consists of a pattern followed by an action. `pattern {}`

**When to use**
- very useful for producing reports from large amounts of raw data
- easy to compose and use: avoids the edit-complie-test-debug cycle
- consider using a different languages(bash, python...) if you need write 100+ lines of awk program to get what you want

## Basics

### Structure
```bash
[pattern]{action}
pattern[{action}]
```

```bash
@include pathoflib
@load extention

# awk program may have n number of below pattern-action pairs including special patterns like begin...it helps in writing lib

BEGIN{ # BEGIN rule run this block before reading any input. Executed Once per one awk program execution

}
BEGINFILE{ # BEGIN rule run this block before reading any input. Executed for each input file 

}
/regex pattern/{ # run this block for each records that matchs the given regex pattern
    statement1; 
    statement2..n; # ';' used to seperate statements or rules if rules are on the same line
}
experssion pattern{ # run this block for each records that matchs the given exp pattern - boolean exp are allowed || && ...

}
begpat, endpat{

}
empty{

}
ENDFILE{ # END rule run this block at the end of reading all inputs for each input file
  # cleanup action to be done on a per-file
}
END{ # END rule run this block at the end of reading all inputs
  # cleanup action to be done for your awk program
}

```

Action consist of statements enclosed in curly braces; statemenmts are build from the below 

#### Statements
  - Experssion `(assignment , compute,...)`
  - Control Statements `if while for switch` - C style 
    - Decision Making 
      - `if (condition) {then-body} [else else-body]`
      - `switch (experssion) { case value: compound statements; default: statements}`
      - `break, continue` - lets you exit the loop early or start the next iteration of a loop 
      - `next, nextfile` - lets you read the next record or file file
      - `exit [exit code]` - terminates the program
    - Loop 
      - `while (condition) {do-body}`
      - `do {do-body} while (condition)`
      - `for (initialization; condition; increment) {loop-body}`
      - `for item in associate-array`
  - Compound Statements `{}`
  - Input Statements `getline`
  - Output Statements `print printf`

#### Variables
- Shell Variables can be used
- Built-in variables provide control over awk `explained later`
- ARGC and ARGV make the command-line arguments available to program in array data
- No Fixed Type
  - holds string or numeric

#### Operations
- `()` group
- `$` Field reference 
- Increment & Decrement `++, --`
  - pre, post
- Arithmetic operators `^ ** - + * / %  + - ` 
  - unary first, then, binary opt in precedence
- String concat
- Relational Operators `< <= > >= == != ~ !~ in`
- Boolean Expressions `&& || !`
- Conditional Exp `selector ? if-true-exp : if-false-exp`
- Assignment `=, +=, -=`

(_sorted by precedence order high to low_)

### Running AWK
- One-Shot Throwaway awk Programs
  - `awk 'prog' ip-file1 ip-files2`
  - use single quote to provide program. It protects everything inside quotes
- Running awk Without Input Files
  - reads from std input
- Running from program file for long program
  - `awk -f prog-file.awk ip-file1`
  - use .awk suffix for keeping housekeeping easier
  - if the file name does not have / then awk searches a list of dirs (searchpath)
    - use `AWKPATH` to define search path. If file not found, the path is searched agin with .awk suffix
- Executable awk program 
- use headerline `#!/usr/bin/awk -f` file advice to give which interpreter to run
  - chmod +x prog-file
  - Add prog dir to $PATH

#### Options

_most frequently used options _

|     Option | What it does                        |
| ---------: | ----------------------------------- |
|         -F | _F_ield Seperator                   |
|         -f | Source _f_iles                      |
|         -i | include source file like @include   |
| -v var=val | Set _v_alue to var before execution |
|         -o | Enable pretty printing of awk prog  |
|         -d | _d_ump variables to awkvars.out     |
|         -p | Enable profiling                    |
|         -D | Enable _D_ebug mode                 |
|         -S | Run in sandbox mode                 |
|         -- | End of cmdline options              |

**Others**
- You can use `-` to refer to stdin on the cmd line
- nonoption command-line args are placed in the ARGV array
- gawk allows you to include other awk source file using @include
- gawk allows you to load C/C++ functions using @load


## Reading Input: Records and Fields

- _records_ : input is split into records and rules acts on record
  - default: one line `RS="\n"`
  - `RS` -> _record separator_ 
  - `RS=""` -> empty string means records are seperated by one or more blank lines
  - `RS="\0"` -> whole file becomes one record
  - `RT` -> when RS is regex, RT will be set to actual matched text by gawk
- _fields_ : each record is  split into fields
  - default: whitespace `" "`
  - `FS` - _field separator_ how fields are separated
  - `FS=""` -> making each char a seperate field
  - `FS="\n"` -> making full line as a single field
  - `NF` -> number of fields in the current record
  - `$n` -> dollar sign refers to field
  - `$0` -> the full record 
  - `$any_numeric_var` or `$(some num exp 2+3)` -> non constant number field
  - `$n=` -> changing the contents of the field with '=' ; $0 will be recalculated if any change 
  - Fixed-Width Data: `FIELDWIDTHS="3 3 5 10"` (gawk)
- Separator
  - can be single char
  - can be regex like `FS="[ \t\n]+"`
  - can be multi chars `FS=", \t"`
- BEGIN pattern's action can be used to set custom values
  - BEGIN{ RS="\n"; FS="\t"}

_Dark Corner_
- FPAT
- getline
- reading i/p with a timeout

## Printing Output: Formatting, Records and Fields

- _print_
  - `print item1, item2` separated by single space 
  - string, number, field , var or any awk exp 
  - no args means $0
  - can be used only in action part - not pattern part
- _printf format, item1, item2_
  - format-specifier => % + (modifer)? + format-control-letter
    - `%` format specifier starts with
    - `d D e E f g G o s x X %` format-control letter 
      - decimal, integer, float, scientific, scientific or float, octal, string, hex
    - `n .n n$ - + # 0 '` modifier
      - width, precision, positional specifier, left-justify, , padding with zero, only int part
- Output Separator
  - `OFS` output field separator
  - `ORS` o/p record separator 
  - `OFMT` o/p format while doing number to string before printing e.g. `OFMT="%3.2f"` 
  - BEGIN pattern's action can be used to set custom values
- Redirect Output
  - print xyz > file
  - print xyz >> file
  - print | command 
  - close() close open file in the END's action 

## Regular Expressions

_Regex: describes sets of strings to be matched_

- Regex as pattern in awk `field-exp (!)~ /regex/`
  - '\~' & '!~' regex operator for comparisions
  - awk '$1 ~/J/' => if ($1 ~/J/)

- Dynamic regex allows to store regex as string
  - Using regex constants makes your prog less error-prone
  - regexname = "regex"; $0 ~ regex_name {print}

- RegEx Operators provide grouping, alternation, and repetition
- Bracket Experssion give you a shorthand for specifying sets of chars
- Escape sequence let you represent nonprintable chars 

_Regular Expression Operators_

### Basic

| Expression | Explanations                                                                                     |
| ---------- | ------------------------------------------------------------------------------------------------ |
| ^          | Matches the expression to its right, at the start of a string before it experiences a line break |
| $          | Matches the expression to its left, at the end of a string before it experiences a line break    |
| .          | Matches any character except newline                                                             |
| a          | Matches exactly one character a                                                                  |
| xy         | Matches the string xy                                                                            |
| "a\| b"    | Matches expression a or b. If a is matched first, b is left untried.                             |

### Quantifiers
| Expression | Explanations                                                   |
| ---------- | -------------------------------------------------------------- |
| +          | Matches the expression to its left 1 or more times.            |
| *          | Matches the expression to its left 0 or more times.            |
| ?          | Matches the expression to its left 0 or 1 times                |
| {p}        | Matches the expression to its left p times, and not less.      |
| {p, q}     | Matches the expression to its left p to q times, and not less. |
| {p, }      | Matches the expression to its left p or more times.            |
| { , q}     | Matches the expression to its left up to q times               |

### Bracket Experssion (Sets)
| Expression | Explanations                                                                                     |
| ---------- | ------------------------------------------------------------------------------------------------ |
| [abc]      | Matches either a, b, or c. It does not match abc.                                                |
| [a-z]      | Matches any alphabet from a to z.                                                                |
| [A-Z]      | Matches any alphabets in capital from A to Z                                                     |
| [a\-p]     | Matches a, -, or p. It matches – because \ escapes it.                                           |
| [-z]       | Matches – or z                                                                                   |
| [a-z0-9]   | Matches characters from a to z or from 0 to 9.                                                   |
| [(+*)]     | Special characters become literal inside a set, so this matches (, +, *, or )                    |
| [^ab5]     | Adding ^ excludes any character in the set. Here, it matches characters that are not a, b, or 5. |
| \[a\]      | Matches [a] because both parentheses [ ] are escaped                                             |

### Character Classes (set)

- special notation for describing lists of characters (gawk regex operators are included in this list)
- POSIX char class are allowed only inside bracket experssion [: :]
- locale-specific names [= =]

| Expression | Explanations                                                                                                |
| ---------- | ----------------------------------------------------------------------------------------------------------- |
| \w         | [:alnum:] Matches alphanumeric characters, that is a-z, A-Z, 0-9, and underscore(_)                         |
| \W         | ^[:alnum:] Matches non-alphanumeric characters, that is except a-z, A-Z, 0-9 and _                          |
| \d         | [:digit:] Matches digits, from 0-9.                                                                         |
| \D         | ^[:digit:] Matches any non-digits.                                                                          |
| [:blank:]  | Space and Tab                                                                                               |
| [:lower:]  | lowercase                                                                                                   |
| [:upper:]  | uppercase                                                                                                   |
| [:punct:]  | punctuation                                                                                                 |
| [:cntrl:]  | ctr chars                                                                                                   |
| [:print:]  | all non ctr chars                                                                                           |
| \s         | [:space:] Matches whitespace characters, which also include the \t, \n, \r, and space characters.           |
| \S         | ^[:space:] Matches non-whitespace characters.                                                               |
| \A         | Matches the expression to its right at the absolute start of a string whether in single or multi-line mode. |
| \Z         | Matches the expression to its left at the absolute end of a string whether in single or multi-line mode.    |
| \n         | Matches a newline character                                                                                 |
| \t         | Matches tab character                                                                                       |
| \b         | Matches the word boundary (or empty string) at the start and end of a word.                                 |
| \B         | Matches where \b does not, that is, non-word boundary                                                       |
| \<         | match empty string at the beginning                                                                         |
| \>         | match empty string at the end                                                                               |
| \y         | match empty string at either at the start or the end                                                        |

### Escape Sequence

| Code | Action             | Note                                                                                          |
| ---- | ------------------ | --------------------------------------------------------------------------------------------- |
| \a   | alert              | (BEL)                                                                                         |
| \b   | Backspace          | (BS) Backspace                                                                                |
| \f   | Form Feed          | (FF) Form Feed page break(Return)                                                             |
| \n   | New Line           | (LF) Shift the cursor control to the new line                                                 |
| \r   | Carriage Return    | (CR) Shift the cursor to the beginning of the current line                                    |
| \t   | Tab (Horizontal)   | (HT) Shift the cursor to a couple of spaces(Eight blank spaces) to the right in the same line |
| \v   | Vertical Tab       | (VT) Vertical Tab                                                                             |
| \\   | Backslash          | the backslash character                                                                       |
| \/   | Fwd slash          | fwd slash character                                                                           |
| \'   | Single Quote       | the single-quotation mark.                                                                    |
| \"   | Double Quote       | the double-quotation mark                                                                     |
| \?   | Question Mark      | the question mark                                                                             |
| \nnn | octal number       | Represent an octal number                                                                     |
| \xhh | hexadecimal number | Represent a hexadecimal number                                                                |
| \0   | Null               | Termination of the string                                                                     |

### Groups
| Expression | Explanations                                                                                 |
| ---------- | -------------------------------------------------------------------------------------------- |
| ( )        | Matches the expression inside the parentheses and groups it which we can capture as required |
| (?#…)      | Read a comment                                                                               |
| (?PAB)     | Matches the expression AB, which can be retrieved with the group name.                       |
| (?:A)      | Matches the expression as represented by A, but cannot be retrieved afterwards.              |
| (?P=group) | Matches the expression matched by an earlier group named “group”                             |

### Assertions
_python_
| Expression | Explanations                                                                                             |
| ---------- | -------------------------------------------------------------------------------------------------------- |
| A(?=B)     | This matches the expression A only if it is followed by B. (Positive look ahead assertion)               |
| A(?!B)     | This matches the expression A only if it is not followed by B. (Negative look ahead assertion)           |
| (?<=B)A    | This matches the expression A only if B is immediate to its left.  (Positive look behind assertion)      |
| (?<!B)A    | This matches the expression A only if B is not immediately to its left. (Negative look behind assertion) |
| (?()       | )                                                                                                        | If else conditional |

### Flags
| Expression | Explanations                                         |
| ---------- | ---------------------------------------------------- |
| a          | Matches ASCII only                                   |
| i          | Ignore case                                          |
| L          | Locale character classes                             |
| m          | ^ and $ match start and end of the line (Multi-line) |
| s          | Matches everything including newline as well         |
| u          | Matches Unicode character classes                    |
| x          | Allow spaces and comments (Verbose)                  |

- IGNORECASE
