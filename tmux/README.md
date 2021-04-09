## About

tmux lets you set up development environments that you can pause and resume at will. 

What do you mean by pause-and-resume?
It keeps things running persistently on servers, so you can disconnect and connect as needed without interrupting tasks in progress.

Still, Not clear?
It is one of those things that at first sounds peculiar and confusing. When you discover about them, and you can't quite grasp what the heck they do, how they can be valuable, or why anybody desires to use them. But it is one of those things that will turn out to be fantastic when given a chance.

## Why Should I Care

When you run into the need of having lots of terminals running different tasks for different projects for different themes: servers, editors, git, building, testing, interacting with remote servers, etc for project, devops , exploration… 

You're likely to use tabs or different terminal windows, which you could create on-demand and arrange now and then with the help of your mouse. 

This process is typically slow and will require you to redo the whole setup any time restart happens or loose your old session. I've been there and It is not pretty. tmux eases the creation and management of terminal windows and panes with a few keyboard shortcuts, and it is entirely customizable.

## Basics 
You can think of a tmux session as a workspace or project work environment. Your session can have more discreet components, called windows and panes. The panes let you divide the screen horizontally and vertically within the same window. These are good for organizing multiple activities in a logical way.
![session view](https://user-images.githubusercontent.com/82016952/114131171-bf73b800-991f-11eb-9fcd-f55798464769.png)

### Typical Workflow 
This flow is a how a typical day in the life of a tmux-using developer looks like. First things first, one grabs a coffee and setup a BG to play. Then, let's say that we are starting on a new project. 

- **Step 1:** You can start using just by invoking ```$ tmux```. However, I would suggest - always begin by creating a new tmux session with a name. The name could be the project or a theme that you are working with, so it will be easy to switch between them, and each will have its terminal state. This way, it boosts productivity significantly during context switch.
  - _To **s**tart new session with a name_ ```$ tmux new -s $new-feature/project-name/theme-name```
  - _To **s**witch between sessions_ ```⌨️ bind-key, then, press s```
  - _To **l**ist all active sessions_ ```$ tmux ls```
  - _To rename a session_ ```⌨️ bind-key, then, press $```
- **Step 2:** Now, You can create as many panes as needed, (typically, I go with three; one editor/log viewer in the main terminal and two other terminals for running ad-hoc processes, like interacting with source control, running tests, a web server, etc.…)
  - _To create windows_```⌨️ bind-key , then, press c```
  - _To give a name to your window (please do)_ ```⌨️ bind-key, then, press ,```
  - _To close current window_ ```⌨️ bind-key, then, press &``` 
  - _To create panes_ ```⌨️ bind-key, then, press % for vertical and " for horizontal pane```
  - _To kill the current pane_ ```⌨️ bind-key, then, press x```
- **Step 3:** Then, You start working, click, clap, clickity, clap, (this is how my machanical keyboard sings to me) and I'll create additional windows and panes as I see fit.
  - _To switch between windows_ ```⌨️ bind-key, then, press 0..9 (ID of the window)``` or ```⌨️ bind-key, then, press p for previous window and n for next window``` 
  - _To switch between panes_ ```⌨️ bind-key , then, use Arrows to navigate panes```
- **Step 4:** When you'r done for the day, you may leave the session open, or you can **d**etach from the session ```⌨️ bind-key , then, press d```. The session will remain active in the tmux server with the same state, ready for whenever I want to jump back to work.
- **Step 5:** Next day, You **attach** to the **t**arget session that contains your work in progress. Where everything is exactly how you left it. So you could jump right back in and start making your keyboard sing. ```$ tmux attach(or a) -t $session_name``` or ```$ tmux attach(or a) #to the previously-opened session.``` 

## Byond Basics: Tips & Tricks

### Key Binding

Using default bind-key is like a tongue twister to my figure; if you feel the same, start customizing keys for your comfort. The below are the most common remapped keys. 

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

## Key Takeaways
- 

## Footnote
Intended Audience: Should I read this? If you are spending time in the terminal, then, Yes. If not so, check out the 'why' section and skim over the workflow to see if it can be a valuable addition to your toolbox.

I tried to put the basic & best usage of the tool in the context of typical dev workflow rather than a simple-cheat-sheet. If you would like to geek around advance options, check out the reference section. 


I would tag it as "Dev Productivity", "Up n Running", "Build Your Toolbox", "Terminal Multiplexing". 

