---
published: false
---
## Keep using Adobe Creative Suite (CS) after upgrading your host machine to a newer macOS (OS X). 

I purchased Adobe CS5 a decade ago and have been keeping around an older Apple computer to use it for graphic and photo editing. macOS versions newer than macOS Mojave 10.14 will not run 32-bit applications such as the Adobe CS5 suite. An accidental macOS upgrade requires a clean reinstall to get Adobe CS5 running again which is a hassle. 

Switching 3 DisplayPort displays with a KVM between a Windows 10/new Mac/old Mac (the Adobe CS5 machine) also rearranges visible windows in my main Windows 10 workstation which is unfortunate. Windows 10 does not remember which display your windows were in when multiple displays are reconnected while macOS does remember to restore the windows correctly. 

It took me a while before I thought of a solution: **Run the older version of macOS in a virtual machine and run Adobe CS5 inside that virtual machine!**

After some trial and error here are the steps:

1. Download [Virtual Box](https://www.virtualbox.org/) for your host machine. I am using my Windows 10 workstation as the host.

2. Download the macOS High Sierra 10.13 or Mojave 10.14 DMG from Apple on an existing installation of macOS and then convert the DMG to ISO with Disk Utility OR download a [premade VMDK from Geekrar](https://www.geekrar.com/install-macos-high-sierra-on-virtualbox-on-windows/). *Many steps in this post are from Geekrar but there are some additions to fix the final display resolution.*

3. 