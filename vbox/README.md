# Virtual Box Setup For Devloper Lab
- [Virtual Box Setup For Devloper Lab](#virtual-box-setup-for-devloper-lab)
    - [Get VBox & Guest OS](#get-vbox--guest-os)
    - [Create Virtual Machince](#create-virtual-machince)
      - [Setup Guest OS](#setup-guest-os)
      - [Setup Graphics](#setup-graphics)
      - [Shared Clipboard Between Host & Guest](#shared-clipboard-between-host--guest)
      - [Ubunutu Dev Env](#ubunutu-dev-env)
      - [Mount Shared Folder](#mount-shared-folder)

### Get VBox & Guest OS

**Download Virtual Box**
```powershell
Invoke-WebRequest -Uri https://download.virtualbox.org/virtualbox/6.1.20/VirtualBox-6.1.20-143896-Win.exe -UseBasicParsing -Outfile VirtualBox-6.1.20-143896-Win.exe
.\VirtualBox-6.1.20-143896-Win.exe
```

**Download Guest OS** (ubuntu)
```powershell
Invoke-WebRequest -Uri https://releases.ubuntu.com/21.04/ubuntu-21.04-desktop-amd64.iso -Outfile ubuntu-21.04-desktop-amd64.iso
```

**Lesson Leared in Hard Way**

_Pre Install_
- Always Download New Version or at least the version that is used for building this repo (21.04); Changing version within Ubuntu is painfull compare to start with new version and select update option while installing
- Use 4GiB RAM and 40GiB for Disk (min expected for unbuntu21.04 is 4GiBMem-25GiBDisk)
    - Use SSD Drive
    - Setup Harddisk Size: Choose Dynamically Grow Option
    - Setup RAM Size: Do not forget that  your host computer will use only the remaining available RAM)

_While Installing_
- Don't even try to do two things at a time while VBOX is loaded with Ubuntu (It freezes a lot and will end up redoing all again). Do one by one and do clean restart. Then, start using it.
- Choose "Minimal Installation" & "Download Updates Option" - This is best optimized way of installing for dev box
- Login: Choose "Log in Automatically" and Machine Name "ubuntu-vm" (This is better than the fancy name that you will create after spending 15 mins thinking about the name. Trust me. 
- Estimated Install Time: while installing, please make sure win doesn't run any resource intense operation (network, disk, cpu)
    - 12 mins: install ubuntu 21.04 version 
    - eject install iso and hit enter while the first time auto-restart


_After Install_

- Make VBOX Window Flexible Size: Install Guest Addon CD from Devices menu of the vbox app (pic is attached) (4 mins)
    - Do a gracefull restart once it is done. Now the "Auto Re Size Guest OS" will be enabled. Eject the Guest Addon Image from Ubuntu now.
- Run Update and upgrade commands (5 mins)
    - sudo apt upgrade ; sudo apt update;
    - Do a graceful restart & take a snapshot from vbox (name: Adam or Eve)
- Configure Shared Folder, Shared Clipboard, Drag and Drop Options to create communication channel between host and gues os (from vbox -> menu -> Devices)
- Finally, Make Effective Dev Env (ohmylinuxdev)
    - ` follow the cmds from make script to create effective dev env`
    - `\rm -rf Desktop Documents Downloads Music Pictures Public Templates Videos`
    - Take snapshot from Vbox (name: ohmylinux-bootstrap)

![Annotation 2021-08-14 092221](https://user-images.githubusercontent.com/82016952/129433234-819f6bce-f75a-4512-a04d-56a0883021a8.png)


Estimated Time: 9am

### Create Virtual Machince

<img src="https://user-images.githubusercontent.com/82016952/115802609-d96fc900-a3fc-11eb-8a64-8834279eee0f.png" width="550">

<img src="https://user-images.githubusercontent.com/82016952/115802695-002dff80-a3fd-11eb-809d-48868b0a5f62.png" width="550">


#### Setup Guest OS
![image](https://user-images.githubusercontent.com/82016952/115802788-26539f80-a3fd-11eb-965a-2940bbb05d1e.png)

![image](https://user-images.githubusercontent.com/82016952/115802873-5602a780-a3fd-11eb-8d38-6e46aa51a55b.png)

![image](https://user-images.githubusercontent.com/82016952/115802997-9104db00-a3fd-11eb-977f-3cef2122fc0e.png)

![image](https://user-images.githubusercontent.com/82016952/115803028-a548d800-a3fd-11eb-8ba4-8ba869e8991c.png)

![image](https://user-images.githubusercontent.com/82016952/115803045-af6ad680-a3fd-11eb-88ce-35ca4c8a141b.png)

![image](https://user-images.githubusercontent.com/82016952/115803064-bf82b600-a3fd-11eb-9689-82483ec45d84.png)
![image](https://user-images.githubusercontent.com/82016952/115803312-39b33a80-a3fe-11eb-9e1a-1ba483b650b0.png)
![image](https://user-images.githubusercontent.com/82016952/115803359-50599180-a3fe-11eb-9c47-9af699830ead.png)
![image](https://user-images.githubusercontent.com/82016952/115803401-6a936f80-a3fe-11eb-87e4-c34ac7567e5e.png)

![image](https://user-images.githubusercontent.com/82016952/115803564-c78f2580-a3fe-11eb-939b-92ce89e12ad9.png)
![image](https://user-images.githubusercontent.com/82016952/115803961-9531f800-a3ff-11eb-886f-c5caaed32853.png)

![image](https://user-images.githubusercontent.com/82016952/115804110-ea6e0980-a3ff-11eb-87b1-0cca9c4f862e.png)

#### Setup Graphics

![image](https://user-images.githubusercontent.com/82016952/115804323-66685180-a400-11eb-8d28-fb9fb68f85c1.png)

![image](https://user-images.githubusercontent.com/82016952/115804395-89930100-a400-11eb-82a2-5b5d59ee48eb.png)

![image](https://user-images.githubusercontent.com/82016952/115805098-e0e5a100-a401-11eb-8a48-ae1d921bb04b.png)
![image](https://user-images.githubusercontent.com/82016952/115805260-38840c80-a402-11eb-8c97-6238b0a01706.png)
![image](https://user-images.githubusercontent.com/82016952/115805307-56517180-a402-11eb-8aa0-f35df4ae4a27.png)

![image](https://user-images.githubusercontent.com/82016952/115805391-80a32f00-a402-11eb-87f8-efaaaee0d0dc.png)
![image](https://user-images.githubusercontent.com/82016952/115805418-90227800-a402-11eb-9ab7-c2f024bfd8d8.png)
![image](https://user-images.githubusercontent.com/82016952/115805641-fe673a80-a402-11eb-95ec-a3192329de63.png)

#### Shared Clipboard Between Host & Guest

![image](https://user-images.githubusercontent.com/82016952/115805943-9402ca00-a403-11eb-9ce0-c8c7870f1364.png)

#### Ubunutu Dev Env

![image](https://user-images.githubusercontent.com/82016952/115805806-51d98880-a403-11eb-9a50-b1f53d920274.png)

```
$ \rm -rf Desktop Documents Downloads Music Pictures Public Templates Videos
```
#### Mount Shared Folder
1. Open VirtualBox
1. Right-click your VM, then click Settings
1. Go to Shared Folders section
1. Add a new shared folder. Select the Folder Path in your host that you want to be accessible inside your VM. (e.g C:/vbox_shared/)
1. Uncheck Read-only and Auto-mount, and check Make Permanent and set mount point (e.g win_shared)
1. Start your VM

1. Create "shared" directory in your home
1. Mount the shared folder from the host to your ~/shared directory
```sudo mount -t vboxsf  vbox_shared  ~/shared```
![image](https://user-images.githubusercontent.com/82016952/115995823-69c72d00-a5fa-11eb-91ce-24a29d93c671.png)

