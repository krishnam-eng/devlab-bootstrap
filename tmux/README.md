_Who Should Read It:_
  - Anyone who uses the command line daily and not yet explored tmux in-depth, this blog is for you.
  - If you are already using tmux, check out 'beyond basics' section.
  - Others, check out the 'why should you care' section to see if it can be a valuable addition to your toolbox.

You do not really need this post to use tmux; If you want a technical guidebook, you could look at the manpage for tmux. However, manpages are seldom adequate to wrap your brain around concepts (why & when); they're there for reference (how-to) sorted alphabetically instead of logically. Here, We will see 'why tmux', some of its practical uses, and how to quickly start using it in your day-to-day workflow.

## Why Should You Care
"Give me six hours to chop down a tree and I will spend the first four sharpening the axe" - Abraham Lincoln

Suppose you are working on many projects or many contexts (DevOps, development, exploring, etc.). In that case, each needs a set of terminals to control various activities, "creating more tabs & windows and using a mouse to organize them" isn't the best solution. This process is typically slow, and the context-switching between different kinds of work is very unproductive (especially if you end up redoing the same setup afresh).

Of course, there are other ways of managing multi-tasking, like using simple _bg_ & _fg_ commands or using the GNU _screen_. However, Tmux is considered to be the next evolutionary step forward. I am not overstating; even the screen packages have been [replaced by tmux in RHEL8](https://access.redhat.com/solutions/4136481).

**"T"erminal "mu"ltiple"x"ing**

I am writing this in a github-managed .md file from vim running in a pane, inside a window, in a session managed by a tmux server, through a client running in my zsh terminal in Ubuntu VM using VirtualBox that installed in win10.

Tmux is a powerful tool; It is one of those things that at first sounds peculiar, involved and intensive; you can't quite grasp what the heck they do, how they can be valuable or why anybody even wants to use them. Nonetheless, it is one of those things that will turn out to be a fantastic swiss-army-knife when given a chance. Let's give a chance for the below reasons.

**Why Tmux?**

tmux help solves the weaknesses of standard terminal emulators. The followings are some of the reasons why I became a tmux fan:

- It expedites the creation and management of terminal windows and pane
  - Once you get familiarized with working within sessions, windows, panes, you are into an excellent developer environment.
- It provides the ability to connect to existing local and remote sessions
  - It uses a client-server model, which lets you pause and resume your work where everything is exactly how you left it.
  - It makes it easy for context-switching between multiple themes of your work
- It is totally customizable and gives the ability to automate creating a specific layout
  - It comes with the heavy load of built-in commands that let you build your script to automate your dev env
- It provides 100% mouse-free control

Overall, it can be an incredible productivity booster once you get the hang of it.

## Basics
Ok, Let's break down tmux by its objects, from servers down to panes.

- **Server** is what powering tmux behind the scenes. It is so streamlined, and zero-config needed from you. It runs in the background; you will hardly notice it is there. When you execute a tmux command, a tmux server is launched. Every activity that is launched in the tmux happen within the server. What you see in your shell is merely a client connection. The server holds sessions.
- **Session** is essentially the base unit holding windows. You can have multiple sessions also. e.g., you could have one session for each application your developing or a session for work and a session for your cool side project or exploration.
- **Window** is what you see when tmux is open in front of you. Think of it as a tab in your browser. The window layout is customizable, and tmux has many preset layouts also to arrange panes.
- **Panes** are a terminal in a terminal, or you could call it pseudoterminals. The panes let you divide the screen horizontally and vertically within the same window. A window and a pane are perfect analogies to their real-world counterparts.

Sessions, Windows & Panes: These are good to logically organize multiple activities (totally mouse-free).

![session.window.pane](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/69mupucxk4ec0l0py5cr.png)

I think we got the basic concepts covered. Now, Let's see the general usage of the tool in the context of typical dev workflow.

### Typical Workflow
This flow is how tmux-using developers' day looks like. First things first, one grabs a coffee ☕ and bossily command GoogleHome to play [Mozart](https://open.spotify.com/track/7kCQHbrTpu7lzm22uGMKMG?si=caab7dc2fd454728) 🎵 on Spotify. Then, let's say that we are starting the work on project A.

- **Step 1:** You can start just by invoking ```$ tmux```. However, I suggest that you always begin by creating a session with a name; it is better than a default session name. The name could be the project or a theme you are working on, so it will be easy to recognize and switch between them.

```
 $ tmux                 # Launch tmux with defalut session    
 $ tmux new-session –s  # Launch tmux with a named session
*[prefix] X            Closing Session

# By default, all key bindings will require a "prefix" key before they are active. It is like a <leader> key in vim. The default is Ctrl-b; I changed to Ctrl-a. 

* this is a custom key-binding
```

</details>

- **Step 2:** Now, You can create as many panes as needed (typically, the most user go with three panes in a window; one editor in the main terminal and two other terminals for running processes like interacting with git, running tests, a web server, etc.…)

```
#### Pane Management
*[prefix] _            Split the window into two vertical panes
*[prefix] |            Split the window into two horizontal panes (horizontal )

 [prefix] q            Show the pane number in each pane briefly.
 [prefix] arrow-keys   Switch focus to different pane
 C-d                   Close the pane just like how you will close a terminal

#### Layout Management
[prefix] <space> Rotate through the default layouts
[prefix] <alt>1  Switch to Even Horizontal Layout
[prefix] <alt>2  Switch to Even Vertical Layout
[prefix] <alt>3  Switch to Main Vertical Layout
[prefix] <alt>4  Switch to Main Horizontal Layout
[prefix] <alt>5  Switch to Tiled Layout

### Resizing Panes
[prefix] z             zoom current pane to full window size

[prefix] <ctrl>up      increase the height of this pane by one row
[prefix] <ctrl>down    decrease the height of this pane by one row
[prefix] <ctrl>left    increase the width of this pane by one column
[prefix] <ctrl>right   decrease the width of this pane by one column

*[prefix] H             increase the height of this pane by two row (shift+)
*[prefix] J             decrease the height of this pane by one row
*[prefix] K             increase the width of this pane by one column
*[prefix] L             decrease the width of this pane by one column

[prefix] <alt>up       increase the height of this pane by five rows
[prefix] <alt>down     decrease the height of this pane by five rows
[prefix] <alt>left     increase the width of this pane by five columns
[prefix] <alt>right    decrease the width of this pane by five columns

*this is a custom key-binding
```

- **Step 3:** Then, you start working, 🎵click-clack clickity-clack🎵, while you'r at it, if a single window can't hold all related terminal works, you can create additional windows as you see fit.

```
Frequent Use:
 [prefix] c      _C_reate a new window
 [prefix] ,      Rename current window

 [prefix] w      Choose a _w_indow from a menu
 [prefix] 0-9    Switch to window 0-9
 [prefix] p      Cycle to _p_revious window
 [prefix] n      Cycle to _n_ext window
 [prefix] l      Back to the _l_ast window

 [prefix] x      Closing Window

Sporadic Use:
 [prefix] M-p    _p_revious window with activity
 [prefix] M-n    _n_ext window with activity

 [prefix] !      Breaking Window Panes If you have too many panes in a single window.

 $ move-window  –t {target session}         # Move the window from one session to another
 $ link-window –t {target session}          # Link a window between two sessions         
 $ unlink-window                            # Unlink the window from the current session
 $ join-pane -t {session}:{window}          # Join the current pane to a target window
```


- **Step 4:** Then, you just realized that you need to finish off something for project B; now, you can create a new session for project B and switch out from the first session. You can come back to project A workspace later (maybe tomorrow or next year as long as your tmux server runs).

```
[prefix] s      Choose from a list of _s_essions
[prefix] (      Switch to previous session
[prefix] )      Switch to next session
[prefix] L      Switch the attached client back to the _L_ast session.
[prefix] $      Rename the session
```
</details>

- **Step 5:** When it is closing time, you could leave the **working session** open or detach the session. When you detach a session, it becomes a headless entity running in the background and remain active in the server, ready for whenever you want to resume the work. You can even close the terminal that launched it.

```
 [prefix] d      _d_etach from your current session
```

- **Step 6:** The next day, when you reconnect, you can start a new terminal and reattach the still-running background session that contains your work in progress. Tada! You just jumped right back in. Now, you can start making your keyboard sing again 🎵.

```
$ tmux attach-session -t {session-name}   # Start tmux and attach a _t_arget session by name
```

## Beyond Basics: Personalizing Environments & Scripting tmux
Intended Audience:
* tmux users (beginners) or you read part one of "Command line Happiness" post

This post is part two of the " x" blog. With the basics under our belt, let's explore a custom configuration and automation of the developer workspace now.

### tmux: 13 Cool Tweaks to Make It Personal and Powerful
Here are your ready-to-use valuable tmux tips-&-tweaks. Try these to improve your day-to-day development while start using tmux.

**Why do you want to tweak the default setup ?**

In general, I prefer using the default setting with any tech/tools that I use as long as it serves my purpose. However, tmux is different. It is designed to be customizable. On Top of that, these are my reasons why you should tweak it.

1. Keyboard shortcuts in tmux are a bit of a stretch, both physically and sometimes mentally
2. tmux has a lot of less-than-stellar default setting
3. Moreover, the configuration is fun, especially when you personalize it to suit your needs; after all, that's what it's for!

Follow along, and let's make your tmux friendly. Along the way, do not forget to put more comments in your configuration file; they'll jog your memory later. Treat your tmux config as a living document; Learn, practice, and update.

Start with the biggie !

#### 1. Prefix Should be Simple
By default, all key bindings will demand a "prefix" key before they are active. It is similar to a <leader> key in vim. The default is `Ctrl-b`.

The default is a little hard to trigger as the keyboard button is pretty far. Most prefer the 'C-a' as prefix key:
- It puts your prefix in the home row.
- CapsLock can be remapped with a Ctr key, and A sits just next to the CapsLock.
- If you have already used the GNU screen, 'C-a' is already the standard key for you.

```
unbind-key C-b              # free the original bind-key key
set-option -g prefix C-a    # setting the prefix from C-b to C-a
bind-key C-a send-prefix    # ensure that we can send Ctrl-A to other apps or the shell that your interacting
```

#### 2. Just Reload the Config

Considering you will be doing config tweaks and testing the impact, it is good to introduce the shortcut here.

By default, there are two ways of reloading
1. shutting down all tmux sessions and start them
2. executing 'source-file ~/.tmux.conf' on all the sessions

What on earth you want to follow the above approach! let's create the shortcut - `Ctr+r`
```
bind-key C-r source-file ~/.tmux.conf \; display "Config Reloaded !"
```

#### 3. This is Where I Want to Start
If you do not want to use your default shell and prefer something else, it is easy to set in tmux.
tmux allows you to set default shell and default commands to run when it launches a new pane.

Let me set my default to my fav shell - zsh. Macs now use zsh as the default login shell across the operating system. It is for a reason. Give it a try if you don't already use zsh as your default shell.
```
set-option -g default-shell /usr/bin/zsh        # login shell for new windows/pane
set-option -g default-command "cd ~/github/"    # command used for new windows
```

#### 4. I Can't See Enough !
- By default, the message that comes in the status bar disappears in the blink of an eye and the pane number display time also too short to notice. Tweak the time as you wish.
- If you feel your default history limit is not good enough for your case, crank that up too.
- Lock the session after x mins of inactivity. Sometimes, it is good to protect your screen to make sure other's should not see enough.
- Default names given to the window are too vague even if you can see. Hi tmux, let me name it.

```
set-option -g display-time 2000            # By default, status msg disappears in the blink of an eye (750ms)
set-option -g display-panes-time 2000      # By default, pane number disappears in 1 s
set-option -g history-limit 50000          # maximum number of lines held in window history - crank it up from 2k default
set-option -g lock-after-time 3600         # lock the session after 60 mins of inactivity. Sometimes, it is good to protect your screen to make sure other's can't see enough.
set-option -wg automatic-rename off        # default names are too vague to see. Let me name it.
```
#### 5. Count like Human

- By default, the windows or panes start with index 0 (silly programmers!). Though tmux is one of those "created by and for programmers", this indexing makes it challenging to do switching windows; window 0 will be all the way to left in the status bar and the 0 in keyboard is all way to the right, then 1 key comes in the left...it messes with you.

- Let's imagine you have three windows. If we removed the second window, the default result would be two remaining windows, numbered 1 and 3. but, tmux could automatically renumber the windows to 1 and 2 with the right setting.

Ok, Let's make tmux a human for a bit,

```
set-option -g base-index 1                # window index will start with 1
set-window-option -g pane-base-index 1    # pane index will start with 1
set-option -g renumber-windows on         
```
#### 6. Kill it with X-Force !

By default, if you press <prefix> x, tmux will ask if you're sure you want to kill a pane before it does it. That's nice and all, but what if you'd rather just kill it? Let's do that. And, while we’re at it, let’s create a custom key combo for killing the entire session too.

```
unbind-key x               # unbind-key “x” from it’s current job of “ask and then close”
bind-key x kill-pane       # rebind-key it to just “close”
bind-key X kill-session    # key combo for killing the entire session - <prefix> + shift + x
```

#### 7. Make Splitting Panes Intuitive

Splitting a window in panes are currently bound to <prefix> % and <prefix> ”>, which are hard to remember. It is much easier to remember if you use | for vertical splits and - for horizontal splits. For now, I will leave the default binding as it is since I don’t have any other use for these weird key commands.

Additionally, you also mention the directory to open in the new pane when you split.

```
bind-key | split-window -h -c "#{pane_current_path}" # let's open pane with current directory with -c option
bind-key _ split-window -v -c "#{pane_current_path}"
```
