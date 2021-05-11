`This page is the outcome of learning awk programming. it contains learning notes and act as my quick reference card`

![Mimetypes-application-x-awk-icon](https://user-images.githubusercontent.com/82016952/117792222-b8b2ca80-b268-11eb-9bdb-6afbd8bb8ade.png)

- [GAWK Quick Reference Notes](#gawk-quick-reference-notes)
  - [Basics: Getting Started](#basics-getting-started)
    - [Structure](#structure)
    - [Running AWK](#running-awk)
  - [Regular Expressions](#regular-expressions)
    - [Regular Expression Operators](#regular-expression-operators)
  - [Others](#others)
    - [Records and Fields](#records-and-fields)
    - [variables and Operations](#variables-and-operations)
    - [Control Structures](#control-structures)
    - [Formatting Output](#formatting-output)
    - [Combining AWk with Other Tools](#combining-awk-with-other-tools)
    - [Handy AWK Program Files](#handy-awk-program-files)


# GAWK Quick Reference Notes
Basic function of awk is to search files for lines and perform actions on that line using awk program. This program consist of _pattern-action_ pairs.

- awk program is data driven where as most others are procedural - where you describe every steps in great details.
- awk program is consists of a series of rules.
- a rule consists of a pattern followed by an action. `pattern {}`

**When to use**
- very useful for producing reports from large amounts of raw data
- easy to compose and use: avoids the edit-complie-test-debug cycle
- consider using a different languages(bash, python...) if you need write 100+ lines of awk program to get what you want

## Basics: Getting Started

### Structure
```
BEGIN{ # BEGIN rule run this block before reading any input

}
_pattern1_{ # run this block for each records that matchs the given pattern
    statement1; 
    statement2; # ';' used to seperate statements or rules if rules are on the same line
}
_pattern2_{

}
_pattern..n_{

}
END{ # END rule run this block at the end of reading all inputs

}
# This is comment in awk
```
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

**Options**

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

## Regular Expressions

- Regex as pattern  `field-exp (!)~ /regex/`
  - '~' & '!~' regex operator for comparisions
  - awk '$1 ~/J/' => if ($1 ~/J/)

- Dynamic regex allows to store regex as string
  - Using regex constants makes your prog less error-prone
  - regexname = "regex"; $0 ~ regex_name {print}



### Regular Expression Operators

_These are regex metachar_

**Basic Characters:**

| Expression | Explanations                                                                                     |
| ---------- | ------------------------------------------------------------------------------------------------ |
| ^          | Matches the expression to its right, at the start of a string before it experiences a line break |
| $          | Matches the expression to its left, at the end of a string before it experiences a line break    |
| .          | Matches any character except newline                                                             |
| a          | Matches exactly one character a                                                                  |
| xy         | Matches the string xy                                                                            |
| "a\| b"    | Matches expression a or b. If a is matched first, b is left untried.                             |

**Quantifiers:**
| Expression | Explanations                                                   |
| ---------- | -------------------------------------------------------------- |
| +          | Matches the expression to its left 1 or more times.            |
| *          | Matches the expression to its left 0 or more times.            |
| ?          | Matches the expression to its left 0 or 1 times                |
| {p}        | Matches the expression to its left p times, and not less.      |
| {p, q}     | Matches the expression to its left p to q times, and not less. |
| {p, }      | Matches the expression to its left p or more times.            |
| { , q}     | Matches the expression to its left up to q times               |


|**Sets:**
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


**Character Classes (set):**

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
**Escape Sequence**

_These are valid inside regex_

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

**Groups:**
| Expression | Explanations                                                                                 |
| ---------- | -------------------------------------------------------------------------------------------- |
| ( )        | Matches the expression inside the parentheses and groups it which we can capture as required |
| (?#…)      | Read a comment                                                                               |
| (?PAB)     | Matches the expression AB, which can be retrieved with the group name.                       |
| (?:A)      | Matches the expression as represented by A, but cannot be retrieved afterwards.              |
| (?P=group) | Matches the expression matched by an earlier group named “group”                             |

**Assertions:**
| Expression | Explanations                                                                                             |
| ---------- | -------------------------------------------------------------------------------------------------------- |
| A(?=B)     | This matches the expression A only if it is followed by B. (Positive look ahead assertion)               |
| A(?!B)     | This matches the expression A only if it is not followed by B. (Negative look ahead assertion)           |
| (?<=B)A    | This matches the expression A only if B is immediate to its left.  (Positive look behind assertion)      |
| (?<!B)A    | This matches the expression A only if B is not immediately to its left. (Negative look behind assertion) |
| (?()       | )                                                                                                        | If else conditional |

**Flags:**
| Expression | Explanations                                         |
| ---------- | ---------------------------------------------------- |
| a          | Matches ASCII only                                   |
| i          | Ignore case                                          |
| L          | Locale character classes                             |
| m          | ^ and $ match start and end of the line (Multi-line) |
| s          | Matches everything including newline as well         |
| u          | Matches Unicode character classes                    |
| x          | Allow spaces and comments (Verbose)                  |

## Others

### Records and Fields

### variables and Operations

### Control Structures

### Formatting Output

### Combining AWk with Other Tools

### Handy AWK Program Files

