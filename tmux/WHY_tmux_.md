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
  - It uses a server/client model, which lets you pause and resume your work where everything is precisely how you left it.
  - It makes it easy for context-switching between multiple themes of your work
- It is totally customizable and gives the ability to automate creating a specific layout
  - It comes with the heavy load of built-in commands that let you build your own script to automate your dev env
- It provides 100% mouse-free control

Overall, it can be an incredible productivity booster once you get the hang of it.

## Basics
Ok, Lets' break down tmux by its objects, from servers down to panes.

- Server gives life to the unseen workhorse behind the scenes powering tmux. You will hardly see the mention of server in any tmux book or blog; they are that seamless, unlike any other server that you interact with.
- Sessions are the containers holding windows. Your session can have more components, called windows and panes. These are good for logically organizing multiple activities. You can have multiple sessions. e.g., you could have one session for each application your developing or a session for work and a session for your cool side project/exploration.
- Windows are what you see when tmux is open in front of you.
- Panes are a terminal in a terminal. The panes let you divide the screen horizontally and vertically within the same window. You can resize /reorg your layout in any way you want with only the keyboard ( no mouse needed).

![session.window.pane](https://user-images.githubusercontent.com/82016952/114665020-20cdc980-9d1a-11eb-8feb-6cfc5c883ec3.png)

Now, Let's see the common bread-and-butter uses of tmux in the context of our typical workflow.

### Typical Workflow
This flow is how a typical day of tmux-using developers follow. First things first, one grabs a coffee and bossily commands GoogleHome to play BG Music on Spotify. Then, let's say that we are starting the work.

- **Step 1:** You can start just by invoking ```$ tmux```. However, I would suggest that you always begin by creating a session with a name; it is better than a default session name. The name could be the project or a theme you are working on, so it will be easy to recognise and switch between them.
```
 $ tmux                 # Launch tmux with defalut session    
 $ tmux rename-session  # Rename a session
 $ tmux new-session –s  # Launch tmux with a named session:
 $ tmux attach-session -t {session-name} # Start tmux and attach a session by name

 <prefix> s     Choose from a list of sessions

 <prefix> (      Switch to previous session
 <prefix> )      Switch to next session
 <prefix> L      Switch the attached client back to the last session.

 <prefix> $      Rename the session

 <prefix> d      Detach from your current session

 *<prefix> X      Closing Session

 *this is a custom key-binding
```
- **Step 2:** Now, You can create as many panes as needed, (typically, the most user go with three; one editor/log viewer in the main terminal and two other terminals for running ad-hoc processes, like interacting with source control, running tests, a web server, etc.…)
  - _To create windows_```⌨️ bind-key , then, press c```
  - _To give a name to your window (please do)_ ```⌨️ bind-key, then, press ,```
  - _To create panes_ ```⌨️ bind-key, then, press % for vertical and " for horizontal pane```
- **Step 3:** Then, You start working, click, clap, clickity, clap, (this is how my machanical keyboard sings to me) and I'll create additional windows and panes as I see fit.
  - _To switch between windows_ ```⌨️ bind-key, then, press 0..9 (ID of the window)``` or ```⌨️ bind-key, then, press p for previous window and n for next window```
  - _To switch between panes_ ```⌨️ bind-key , then, use Arrows to navigate panes```
- **Step 4:** When you'r done for the day, you may leave the session open, or you can **d**etach from the session ```⌨️ bind-key , then, press d```. The session will remain active in the tmux server with the same state, ready for whenever I want to jump back to work.
- **Step 5:** Next day, You **attach** to the **t**arget session that contains your work in progress. Where everything is exactly how you left it. So you could jump right back in and start making your keyboard sing. ```$ tmux attach(or a) -t $session_name``` or ```$ tmux attach(or a) #to the previously-opened session.```

### Beyond Basics: Personalizing Environments & Scripting tmux

With the basics under our belt, let's put together a custom configuration. It wraps up with a whirlwind of useful tricks you can use with tmux to improve day to day development.

**Takeaways**

Looked at how the typical workflow along with some important shortcuts

You can detach a session, and it becomes a headless entity running in the background; and, you can even close the terminal that launched it. When you reconnect, you can start a new terminal and reattach the still-running background session. Ta da !

A word to absolute beginners: Don’t feel you need to grasp the concepts of the
command line and terminal multiplexing in a single sitting

Being able to efficiently manage your tmux windows and panes is a skill that usually is acquired over a long period of time, as you find yourself becoming more comfortable with this powerful screen-management tool.
