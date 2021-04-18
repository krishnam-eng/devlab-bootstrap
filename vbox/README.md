
#### Mount Shared Folder
1. Open VirtualBox
1. Right-click your VM, then click Settings
1. Go to Shared Folders section
1. Add a new shared folder. Select the Folder Path in your host that you want to be accessible inside your VM. (e.g C:/vbox_shared/) 
1. Uncheck Read-only and Auto-mount, and check Make Permanent and set mount point (e.g win_shared)
1. Start your VM

1. Create "shared" directory in your home
1. Mount the shared folder from the host to your ~/shared directory
```sudo mount -t vboxsf  win_shared  ~/shared```
