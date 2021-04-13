# Dev Productivity: Command Line Happiness with Terminal Multiplexing

_Who Should Read It:  Anyone who uses the command line daily and not yet explored tmux in-depth_

You do not need this blog to use tmux. If you want a technical guidebook, look at the manpage for tmux. Manpages are seldom adequate to wrap your brain around concepts (why & when); they're there for reference (how). This blog is the outcome of learning and experimenting with tmux in-depth, along with standard essentials and my personal recipes.

**Terminal Multiplexing**
It is one of those things that at first sounds peculiar and involved; you can't quite grasp what the heck they do, how they can be valuable or why anybody even wants to use them. Nonetheless, it is actually one of those things that will turn out to be a fantastic swiss-army-knife when given a chance.

## Why Should You Care
If you are working on many projects or many contexts (DevOps, development, exploring,...) and each needs a set of terminals to control various activities, using tabs & windows isn't the best solution. This process is typically slow, and the context switching between different kinds of work is inefficient at best and headaches at worst.
Of course, there are other ways of managing multi-tasking, like using simple _bg_ & _fg_ commands or using GNU _screen_. However, Tmux is considered to be the next evolutionary step forward. I am not overstating; the screen packages have been [replaced by tmux in RHEL8](https://access.redhat.com/solutions/4136481).

**Why tmux?**

- It eases the creation and management of terminal windows and pane
- It provides the ability to connect to existing local and remote sessions
- It is entirely customizable and gives the ability to automate creating a specific layout
- It is %100 completely mouse-free control

This is not only for neckbeard; it is for anyone who wants to boost productivity around working from CLI.

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
