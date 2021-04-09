## About

tmux lets you set up development environments that you can pause and resume at will. 

What do you mean by pause-and-resume?
It keeps things running persistently on servers, so you can disconnect and connect as needed without interrupting tasks in progress.

Still, Not clear?
It is one of those things that at first sounds peculiar and confusing. When you discover about them, and you can't quite grasp what the heck they do, how they can be valuable, or why anybody desires to use them. But it is one of those things that will turn out to be fantastic when given a chance.

## Why Should I Care

When you run into the need of having lots of terminals running different tasks for different projects for different themes (servers, log view, editors, git, building, testing, interacting with remote servers, etc for project, devops, exploration…), You're likely to use different terminal windows or tabs, which you could create on-demand and arrange now and then with the help of your mouse. 

This process is typically slow and will require you to redo the whole setup any time restart happens or loose your old session. I've been there and It is not pretty. tmux eases the creation and management of terminal windows and panes with a few keyboard shortcuts, and it is entirely customizable.

## Basics 
You can think of a tmux session as a workspace. Your session can have more discreet components, called windows and panes. The panes let you divide the screen horizontally and vertically within the same window. These are good for organizing multiple activities in a logical way. <img src="https://user-images.githubusercontent.com/82016952/114131171-bf73b800-991f-11eb-9fcd-f55798464769.png" alt="session view img" width="250"/>

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

#### The Kill Switch 
If you no-longer need the working session, windows, or panes, here is the kill switch. Give a thought before you kill a session, becuase the power session is the reason why we are here in the first place.  

 - _To kill the current pane_ ```⌨️ bind-key, then, press x```
 - _To kill the current window_ ```⌨️ bind-key, then, press &``` 
 - _To kill session selectively_ ```$ tmux kill-session -t ${session_name}```
 - _To kill all sessions in one go_ ```$ tumex kill-server``` 


## 5 Key Takeaways
- _tmux_ Terminal multiplexer will save you a lot of headaches if you spend a lot of time in the terminal. There are other ways of doing multi-tasking like using _bg_ & _fg_ commands or using _screen_. However, Tmux is considered to be the next evolutionary step forward from screen multiplexer.
- _tmux_ provides session, window & pane to organize multiple activities in a logical way. With few key-commands, you can manage them well.
- You can detach a session, and it becomes a headless entity running in the background; and, you can even close the terminal that launched it. When you reconnect, you can start a new terminal and reattach the still-running background session. Ta da ! (Word of Caution: Keep an eye on your sessions, I updated my terminal rc config to list active sessions at the start)
- You can use sessions for themes (e.g, projects-work, explore, devops...), windows for projects, panes for activites.

## Footnote
Intended Audience: Should I read this? If you are spending time in the terminal, then, Yes. If not so, check out the 'why' & 'key-takeaways' sections to see if it can be a valuable addition to your toolbox.

I tried to put the basic & best usage of the tool in the context of typical dev workflow rather than a simple-cheat-sheet. If you would like to geek around advance options, check out the man page and cheat-sheets avaialble [online](https://tmuxcheatsheet.com/).

tags: "Dev Productivity", "Up n Running", "Build Your Toolbox", "Terminal Multiplexing". 

