`This page is the outcome of learning awk programming. it contains learning notes and act as my quick reference card`

- [GAWK Quick Reference Notes](#gawk-quick-reference-notes)
  - [Basics: Getting Started](#basics-getting-started)
    - [Structure](#structure)
    - [Running AWK](#running-awk)
  - [Regular Expressions](#regular-expressions)
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


### Records and Fields

### variables and Operations

### Control Structures

### Formatting Output

### Combining AWk with Other Tools

### Handy AWK Program Files
