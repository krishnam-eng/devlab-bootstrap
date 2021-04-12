#### Default Layouts
```
 <prefix> <alt>1  Switch to Even Horizontal Layout
 <prefix> <alt>2  Switch to Even Vertical Layout
 <prefix> <alt>3  Switch to Main Vertical Layout
 <prefix> <alt>4  Switch to Main Horizontal Layout
 <prefix> <alt>5  Switch to Tiled Layout
 <prefix> <space> Rotate through the default layouts
```
#### Resizing Panes (remember we have enabled Vim Style also)
```
 <prefix> <ctrl>up      increase the height of this pane by one row
 <prefix> <ctrl>down    decrease the height of this pane by one row
 <prefix> <ctrl>left    increase the width of this pane by one column
 <prefix> <ctrl>right   decrease the width of this pane by one column
 <prefix> <alt>up       increase the height of this pane by five rows
 <prefix> <alt>down     decrease the height of this pane by five rows
 <prefix> <alt>left     increase the width of this pane by five columns
 <prefix> <alt>right    decrease the width of this pane by five columns
```
#### Switching Windows
```
 <prefix> 0-9    Switch to window 0-9 - good enough for quick switch
 <prefix> w      Choose a window from a menu
 <prefix> c      Create a new window
 <prefix> ,      Rename current window
 <prefix> n      Cycle to next window
 <prefix> p      Cycle to previous window
 <prefix> !      Breaking Window Panes If you have too many panes in a single window.
```
#### Session Commands
```
 <prefix> ( Switch to previous session
 <prefix> ) Switch to next session
 <prefix> s Choose from a list of sessions
 <prefix> $ Rename the session
 <prefix> d Detach from your current session
```
#### Copy Mode

```
 <prefix> [ Enter Copy Mode
 <prefix> ] Paste current buffer
 <prefix> = List all buffers and choose one from which to paste
 <space> (in copy mode) Start selection
 <enter> (in copy mode) Exit copy mode, copy selection to buffer
 show-buffer
 list-buffer
 choose-buffer
```

#### Vi mode keystroke

```
 h j k l Move one space left, up, down, right, respectively
 <ctrl>b Scroll up one “page”
 <ctrl>f Scroll down one “page”
 g Jump to the top of the buffer
 G Jump to the end of the buffer
 w Jump to the beginning of the next word
 b Jump back one word
 fn Jump forward to the next occurrence of n on that line
 Fn Jump backward to the previous occurrence of n on that line
 ?*search*<enter> Search backwards through the buffer for search
 /*search*<enter> Search forwards through the buffer for search
 n Repeat the last / or ? search in the same direction
 Repeat the last / or ? search in the opposite direction
```

#### Others
 if-shell "[ test ]" "execute"

