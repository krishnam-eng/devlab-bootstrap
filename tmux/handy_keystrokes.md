# Session
```
 <prefix> s     Choose from a list of sessions

 <prefix> (      Switch to previous session
 <prefix> )      Switch to next session
 <prefix> L      Switch the attached client back to the last session.

 <prefix> $      Rename the session

 <prefix> d      Detach from your current session

 <prefix> X      Closing Session
```
## Window
```
 <prefix> c      Create a new window

 <prefix> 0-9    Switch to window 0-9 - good enough for quick switch
 <prefix> w      Choose a window from a menu

 <prefix> p      Cycle to previous window
 <prefix> n      Cycle to next window
 <prefix> l      Back to the last window

 <prefix> ,      Rename current window

 <prefix> !      Breaking Window Panes If you have too many panes in a single window.

 <prefix> x      Closing Window

 tmux move-window /movew -s -t

```
### Pane
```
 <prefix> _     split pane by horizontal line
 <prefix> |     split pane by vertical line

 <prefix> 0-9    Switch to window 0-9 - good enough for quick switch
 <prefix> w      Choose a window from a menu

 <prefix> p      Cycle to previous window
 <prefix> n      Cycle to next window
 <prefix> l      Back to the last window

 <prefix> ,      Rename current window

 <prefix> !      Breaking Window Panes If you have too many panes in a single window.

 <prefix> x      Closing Window

 tmux move-window /movew -s -t

```

### Default Layouts
```
 <prefix> <space> Rotate through the default layouts

 <prefix> <alt>1  Switch to Even Horizontal Layout
 <prefix> <alt>2  Switch to Even Vertical Layout
 <prefix> <alt>3  Switch to Main Vertical Layout
 <prefix> <alt>4  Switch to Main Horizontal Layout
 <prefix> <alt>5  Switch to Tiled Layout
```

### Resizing Panes (remember we have enabled Vim Style also)
```
 <prefix> z             zoom current pane to full window size

 <prefix> <ctrl>up      increase the height of this pane by one row
 <prefix> <ctrl>down    decrease the height of this pane by one row
 <prefix> <ctrl>left    increase the width of this pane by one column
 <prefix> <ctrl>right   decrease the width of this pane by one column

 <prefix> H             increase the height of this pane by two row (shift+*)
 <prefix> J             decrease the height of this pane by one row
 <prefix> K             increase the width of this pane by one column
 <prefix> L             decrease the width of this pane by one column

 <prefix> <alt>up       increase the height of this pane by five rows
 <prefix> <alt>down     decrease the height of this pane by five rows
 <prefix> <alt>left     increase the width of this pane by five columns
 <prefix> <alt>right    decrease the width of this pane by five columns
```


#### Copy Mode

```
 <prefix> [     Enter Copy Mode
 <prefix> ]     Paste current buffer
 <prefix> =     List all buffers and choose one from which to paste
 <prefix> C-b   Choose a buffer and paste the contents   

 <space>        (in copy mode) Start selection
 <enter>        (in copy mode) Exit copy mode, copy selection to buffer

 <prefix> M-s   Save a copy of the current pane to ~/.tmux/screenshots/*$date.screenshots

 show-buffer
```

#### Vim Style Navigation for tmux

```
 h j k l          Move one space left, up, down, right, respectively
 <ctrl>b          Scroll up one “page”
 <ctrl>f          Scroll down one “page”
 g                Jump to the top of the buffer
 G                Jump to the end of the buffer
 w                Jump to the beginning of the next word
 b                Jump back one word

 fn               Jump forward to the next occurrence of n on that line
 Fn               Jump backward to the previous occurrence of n on that line
 ?*search*<enter> Search backwards through the buffer for search
 /*search*<enter> Search forwards through the buffer for search
 n                Repeat the last / or ? search in the same direction
 N                Repeat the last / or ? search in the opposite direction
```

### Status Bar

```
Meaning of Symbol next to window name
*   Denotes the current window.
-   Marks the last window (previously selected).
#   Window is monitored and activity has been detected.
!   A bell has occurred in the window.
+   Window is monitored for content and it has appeared.
~   The window has been silent for the monitor-silence interval.
Z   The window's active pane is zoomed.
```

```
State Name & style
Default window-status-style           Any window that isn’t doing anything special.
Current window-status-current-style   This is the window you are looking at right now.
Bell window-status-bell-style         This window has had a UNIX “bell” sent, usually from an error of some sort
Activity window-status-activity-style This window has had something happen in it since last you looked.
Content window-status-content-style   You set a “content” alert on this window, and your content has been added.
```
```
There are four types of commands we can put in the format string:
Directive     What it does
#(command)    Insert the first line of the results from that command
#[attributes] Change the attributes for the rest of the string.
##            Print the # Character.
#{Format}     Expand the Format variable.
```
```
Shortcut Long version What it does Sample Output
#H host         Hostname of computer dev.natedickson.com
#h host_short   Hostname without domain name dev
#D pane_id      Unique Pane ID 15 (if it’s pane 3 of window 5?)
#P pane_index   Index of current pane 3
#T pane_title   Title of current pane vim
#S session_name Name of the session Coding
#W window_name  Name of Window Editor
```
```
ANSI color is represented by an integer from 0-7, and then you add eight for the bright color

• Black (0) & Bright Black (8)
• Red (1) & Bright Red (9)
• Green (2) & Bright Green (10)
• Yellow (3) & Bright Yellow (11)
• Blue( 4) & Bright Blue (12)
• Magenta (5) & Bright Magenta (13)
• Cyan (6) & Bright Cyan (14)
• White (7) & Bright White (15)
```
