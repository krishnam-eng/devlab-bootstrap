# Dev Productivity: Command Line Happiness with Terminal Multiplexing

_Who Should Read It:  Anyone who uses the command line daily and not yet explored terminal multiplexing in-depth_

**Terminal Multiplexing**
It is one of those things that at first sounds peculiar and involved; you can't quite grasp what the heck they do, how they can be valuable or why anybody even wants to use them. However, it is actually one of those things that will turn out to be a fantastic swiss-army-knife when given a chance.

## Why Should You Care
When you run into the need of having lots of terminals running different tasks, You're likely to use other terminal windows or tabs. If you are working on multiple projects and each needs a set of terminals to control various activities, using tabs & windows is not good enough to get the best productivity. This process is typically slow.

- _tmux_ (**t**erminal **mu**ltiple**x**er) eases the creation and management of terminal windows and panes with a few keyboard shortcuts (mouse-free development), and it is entirely customizable.
- It will save you a lot of headaches if you spend a lot of time in the terminal. Ofcourse, There are other ways of doing multi-tasking like using basic _bg_ & _fg_ commands or using GNU _screen_. However, Tmux is considered to be the next evolutionary step forward. In version RHEL8, the decision was made to [deprecate _screen_ and use _tmux_](https://access.redhat.com/solutions/4136481) instead.

## Basics
You can think of a tmux session as a workspace. Your session can have more discreet components, called windows and panes. The panes let you divide the screen horizontally and vertically within the same window. These are good for organizing multiple activities in a logical way. You can use session for themes (e.g, team-projects, exploration, devops...), window for projects, pane for activites.

You can detach a session, and it becomes a headless entity running in the background; and, you can even close the terminal that launched it. When you reconnect, you can start a new terminal and reattach the still-running background session. Ta da !

### Typical Workflow
This flow is how a typical day of a tmux-using developers follow. First things first, one grabs a coffee and bossily commands Google-Home to play BG Music on Spotify. Then, let's say that we are starting the work.

- **Step 1:** You can start using just by invoking ```$ tmux```. However, I would suggest - always begin by creating a session with a name; it is better than a defult session name [0][1].. **Tip:** The name could be the project or a theme that you are working on, so it will be easy to recognise and switch between them.
  - _To **s**tart new session with a name_ ```$ tmux new -s $new-feature/project-name/theme-name```
  - _To **s**witch between sessions_ ```⌨️ bind-key, then, press s```
  - _To **l**ist all active sessions_ ```$ tmux ls```
- **Step 2:** Now, You can create as many panes as needed, (typically, the most user go with three; one editor/log viewer in the main terminal and two other terminals for running ad-hoc processes, like interacting with source control, running tests, a web server, etc.…)
  - _To create windows_```⌨️ bind-key , then, press c```
  - _To give a name to your window (please do)_ ```⌨️ bind-key, then, press ,```
  - _To create panes_ ```⌨️ bind-key, then, press % for vertical and " for horizontal pane```
- **Step 3:** Then, You start working, click, clap, clickity, clap, (this is how my machanical keyboard sings to me) and I'll create additional windows and panes as I see fit.
  - _To switch between windows_ ```⌨️ bind-key, then, press 0..9 (ID of the window)``` or ```⌨️ bind-key, then, press p for previous window and n for next window```
  - _To switch between panes_ ```⌨️ bind-key , then, use Arrows to navigate panes```
- **Step 4:** When you'r done for the day, you may leave the session open, or you can **d**etach from the session ```⌨️ bind-key , then, press d```. The session will remain active in the tmux server with the same state, ready for whenever I want to jump back to work.
- **Step 5:** Next day, You **attach** to the **t**arget session that contains your work in progress. Where everything is exactly how you left it. So you could jump right back in and start making your keyboard sing. ```$ tmux attach(or a) -t $session_name``` or ```$ tmux attach(or a) #to the previously-opened session.```

## Byond Basics: Tips & Tricks

### Key Binding

Using default bind-key of tmux is like a tongue-twister to my figures; if you feel the same, start customizing keys for your comfort. The below are the most commonly remapped keys. Create ~/.tmux.conf and start customizing it.

**Remap bind-key to Ctr+a from Ctr+b**
```shell
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix
```

**Splitting a window in panes is much easier to remember if you use | for vertical splits and - for horizontal splits**
```shell
unbind %
bind | split-window -h    
unbind '"'
bind - split-window -v    
````
### Windows & Panes
#### Using Window List

- _To get a visual overview of sessions_ ```⌨️ bind-key, then, press w```
- _To rename a session_ ```⌨️ bind-key, then, press $```

#### Resizing Pane
- _To bring the selected pane to full size(**z**oom mode) and toggle between modes_ ```⌨️ bind-key, then, press z```

### The Kill Switch
If you no-longer need the working session, windows, or panes, here is the kill switch. Give a thought before you kill a session, becuase the power of resuming session is the reason why we are here in the first place.  

 - _To kill the current pane_ ```⌨️ bind-key, then, press x```
 - _To kill the current window_ ```⌨️ bind-key, then, press &```
 - _To kill session selectively_ ```$ tmux kill-session -t ${session_name}```
 - _To kill all sessions in one go_ ```$ tumex kill-server```

### Few Other Time Savers
- You can autostart tmux with last dettached session (configure it in your _shell rc_ file)
```
# if tmux is executable and not inside a tmux session, then try to attach.
# if attachment fails, start a new session
[ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ] && (tmux attach || tmux) >/dev/null 2>&1
```
- You set aliases to freuqently used tmux commands (configure it in your _shell rc_ file)
```
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
```
- You start tmux with default session layout (can be done by writing our own bash script or we could use tmuxinator)

If you would like to geek around advance options, check out the man page and cheat-sheets avaialble [online](https://tmuxcheatsheet.com/).

## Footnote
Intended Audience: Should I read this? If you are spending time in the terminal, then, Yes. If not so, check out the 'why' & 'key-takeaways' sections to see if it can be a valuable addition to your toolbox.

tags: "Dev Productivity", "Up n Running", "Build Your Toolbox", "Terminal Multiplexing".
