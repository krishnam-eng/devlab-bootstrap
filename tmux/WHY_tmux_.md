***DRAFT***

# Dev Productivity: Command Line Happiness with Terminal Multiplexing
```
Who Should Read It:  
  - Anyone who uses the command line daily and not yet explored tmux in-depth
  - If you are already using tmux, check out 'beyond basics' section
  - Others, check out the 'why should you care' section to see if it can be a valuable addition to your toolbox
```
You do not need this blog to use tmux. If you want a technical guidebook, look at the manpage for tmux. however, Manpages are seldom adequate to wrap your brain around concepts (why & when); they're there for reference (how) sorted alphabetically instead logically. This blog is the outcome of learning and experimenting with tmux in-depth, along with standard-essentials & my personal recipes for beginners. We will see some of the practical uses of tmux and how to quickly start using it in your day-to-day workflow.

## Why Should You Care
Suppose you are working on many projects or many contexts (DevOps, development, exploring, etc.). In that case, each needs a set of terminals to control various activities, "creating more tabs & windows and using a mouse to organize them" isn't the best solution. This process is typically slow, and the context-switching between different kinds of work is very unproductive (especially if you end up redoing the same setup afresh).

Of course, there are other ways of managing multi-tasking, like using simple _bg_ & _fg_ commands or using GNU _screen_. However, Tmux is considered to be the next evolutionary step forward. I am not overstating; the screen packages have been [replaced by tmux in RHEL8](https://access.redhat.com/solutions/4136481).

**"T"erminal "mu"ltiple"x"ing**

I am writing this in GitHub-managed MD-file from vi running in a pane, inside a window, in session managed by a tmux server, through a client running in my zsh terminal from Ubuntu VM using VirtualBox that installed in win10.

Tmux is a powerful tool; It is one of those things that at first sounds peculiar, involved and intensive; you can't quite grasp what the heck they do, how they can be valuable or why anybody even wants to use them. Nonetheless, it is actually one of those things that will turn out to be a fantastic swiss-army-knife when given a chance. Let's give a chance for the below reasons.

**Why Tmux?**

tmux help solves the weaknesses of standard terminal emulators. The followings are some of the reasons why I became a tmux fan:

- It expedites the creation and management of terminal windows and pane
  - Once you get familiarized with working within sessions, windows, panes, you are into an excellent developer environment.
- It provides the ability to connect to existing local and remote sessions
  - It uses a client-server model, which lets you pause and resume your work where everything is precisely how you left it.
  - It makes it easy for context-switching between multiple themes of your work
- It is totally customizable and gives the ability to automate creating a specific layout
  - It comes with the heavy load of built-in commands that let you build your own script to automate your dev env
- It provides 100% mouse-free control

Overall, it can be an incredible productivity booster once you get the hang of it.

## Basics
Ok, Lets' break down tmux by its objects, from servers down to panes.

- **Server** is what powering tmux behind the scenes. It is so streamlined, and zero-config needed. It runs in the background; you will hardly notice it is there. When you execute a tmux command, a tmux server is launched. Every activity that is launched in the tmux happen within the server. What you see in your shell is merely a client connection. The server holds sessions.
- **Session** is essentially the base unit holding windows. You can have multiple sessions also. e.g., you could have one session for each application your developing or a session for work and a session for your cool side project/exploration.
- **Window** is what you see when tmux is open in front of you. Think of it as a tab in your browser. The window layout is customizable, and tmux has many preset layouts also.
- **Panes** are a terminal in a terminal, or you could call it pseudoterminals. The panes let you divide the screen horizontally and vertically within the same window. A window and a pane are perfect analogies to their real-world counterparts.

![session.window.pane](https://user-images.githubusercontent.com/82016952/114665020-20cdc980-9d1a-11eb-8feb-6cfc5c883ec3.png)

Session, Window, Pane: These are good for logically organizing multiple activities. You can resize /reorg your layout in any way you want in mouse-free style.

I think we got the basics covered. Now, Let's see the general usage of the tool in the context of typical dev workflow.

### Typical Workflow
This flow is how a typical day of tmux-using developers follow. First things first, one grabs a coffee and bossily commands GoogleHome to play BG Music on Spotify. Then, let's say that we are starting the work on project A.

- **Step 1:** You can start just by invoking ```$ tmux```. However, I would suggest that you always begin by creating a session with a name; it is better than a default session name. The name could be the project or a theme you are working on, so it will be easy to recognise and switch between them.
```
 $ tmux                 # Launch tmux with defalut session    
 $ tmux new-session –s  # Launch tmux with a named session
 *<prefix> X            Closing Session

 *this is a custom key-binding
```
- **Step 2:** Now, You can create as many panes as needed, (typically, the most user go with three panes in a window; one editor in the main terminal and two other terminals for running ad-hoc processes, like interacting with git, running tests, a web server, etc.…)
Click here to see pane management commands and keys...
```
#### Pane Management
*<prefix> _            Split the window into two vertical panes
*<prefix> |            Split the window into two horizontal panes (horizontal )

 <prefix> q            Show the pane number in each pane briefly.
 <prefix> arrow-keys   Switch focus to different pane
 C-d                   Close the pane just like how you will close a terminal

#### Layout Management
<prefix> <space> Rotate through the default layouts
<prefix> <alt>1  Switch to Even Horizontal Layout
<prefix> <alt>2  Switch to Even Vertical Layout
<prefix> <alt>3  Switch to Main Vertical Layout
<prefix> <alt>4  Switch to Main Horizontal Layout
<prefix> <alt>5  Switch to Tiled Layout

### Resizing Panes
<prefix> z             zoom current pane to full window size

<prefix> <ctrl>up      increase the height of this pane by one row
<prefix> <ctrl>down    decrease the height of this pane by one row
<prefix> <ctrl>left    increase the width of this pane by one column
<prefix> <ctrl>right   decrease the width of this pane by one column

*<prefix> H             increase the height of this pane by two row (shift+)
*<prefix> J             decrease the height of this pane by one row
*<prefix> K             increase the width of this pane by one column
*<prefix> L             decrease the width of this pane by one column

<prefix> <alt>up       increase the height of this pane by five rows
<prefix> <alt>down     decrease the height of this pane by five rows
<prefix> <alt>left     increase the width of this pane by five columns
<prefix> <alt>right    decrease the width of this pane by five columns

*this is a custom key-binding
```
- **Step 3:** Then, You start working, click clack clickity clack, and while your at it, you can create additional windows as you see fit.
Click here to see window management commands and keys...
```
Frequent Use:
 <prefix> c      Create a new window
 <prefix> ,      Rename current window

 <prefix> w      Choose a window from a menu
 <prefix> 0-9    Switch to window 0-9
 <prefix> p      Cycle to previous window
 <prefix> n      Cycle to next window
 <prefix> l      Back to the last window

 <prefix> x      Closing Window

Sporadic Use:
 <prefix> M-p    Previous window with activity
 <prefix> M-n    Next window with activity

 <prefix> !      Breaking Window Panes If you have too many panes in a single window.

 $ move-window  –t {target session}         # Move the window from one session to another
 $ link-window –t {target session}          # Link a window between two sessions         
 $ unlink-window                            # Unlink the window from the current session
 $ join-pane -t {session}:{window}          # Join the current pane to a target window
```
- **Step 4:** Then, you just realized that you need to finish off something for project B, you can create new session for project B and switch out from the first session. You can come back to project A workspace later, tomorrow, or next year as long as you tmux server is running (using resurrect plugin, you even resume after server death).
Click here to see session management commands and keys...
```
<prefix> s      Choose from a list of sessions
<prefix> (      Switch to previous session
<prefix> )      Switch to next session
<prefix> L      Switch the attached client back to the last session.
<prefix> $      Rename the session
```
- **Step 5:** When you are done for the day, you may leave the working session open, or you can detach from the session. The session will remain active in the tmux server with the same state, ready for whenever you want to resume the work.
Click here to see command...
```
 <prefix> d      Detach from your current session
```
- **Step 6:** Next day, You attach to the target session that contains your work in progress. So you could jump right back in and start making your keyboard sing again.
Click here to see command...
```
$ tmux attach-session -t {session-name} # Start tmux and attach a session by name
```

### Beyond Basics: Personalizing Environments & Scripting tmux

With the basics under our belt, let's put together a custom configuration. It wraps up with a whirlwind of useful tricks you can use with tmux to improve day to day development.

**Takeaways**

- tmux is a versatile addition to your terminal toolbelt

Looked at how the typical workflow along with some important shortcuts

You can detach a session, and it becomes a headless entity running in the background; and, you can even close the terminal that launched it. When you reconnect, you can start a new terminal and reattach the still-running background session. Ta da !

A word to absolute beginners: Don’t feel you need to grasp the concepts of the
command line and terminal multiplexing in a single sitting

Being able to efficiently manage your tmux windows and panes is a skill that usually is acquired over a long period of time, as you find yourself becoming more comfortable with this powerful screen-management tool.
