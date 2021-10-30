---
published: false
---
## Keep using Adobe Creative Suite (CS) after upgrading your host machine to a newer macOS (OS X). 

I purchased Adobe CS5 a decade ago and have been keeping around an older Apple computer to use it for graphic and photo editing. macOS versions newer than macOS Mojave 10.14 will not run 32-bit applications such as the Adobe CS5 suite. An accidental macOS upgrade requires a clean reinstall to get Adobe CS5 running again which is a hassle. 

![Adobe CS5 working again](/wp-content/uploads/2021/10/osx-vm-adobe-cs5.PNG)

Switching 3 DisplayPort displays with a KVM between a Windows 10/new Mac/old Mac (the Adobe CS5 machine) also rearranges visible windows in my main Windows 10 workstation which is unfortunate. Windows 10 does not remember which display your windows were in when multiple displays are reconnected while macOS does remember to restore the windows correctly. 

It took me a while before I thought of a solution: **Run the older version of macOS in a virtual machine and run Adobe CS5 inside that virtual machine!**

After some trial and error here are the steps:

1. Download [Virtual Box](https://www.virtualbox.org/) for your host machine. I am using my Windows 10 workstation as the host.

2. Download the macOS High Sierra 10.13 or Mojave 10.14 DMG from Apple on an existing installation of macOS and then convert the DMG to ISO with Disk Utility OR download a [premade VMDK from Geekrar](https://www.geekrar.com/install-macos-high-sierra-on-virtualbox-on-windows/). *Many steps in this post are from Geekrar but there are some additions to fix the final display resolution.*

3. Create a new guest virtual machine in Virtual Box and select the ISO as the inserted CD or the VMDK as the storage device. 

4. Set processor count to 4. 

5. Set memory to 8192mb.

6. Set video memory to 128mb.

7. Quit VirtualBox. Run the below VBoxManage commands in Powershell or equivalent terminal after navigating to the VirtualBox installation directory. Replace `VMNAME` with the name of your new virtual machine in Virtual Box.

```
cd "C:\Program Files\Oracle\VirtualBox\"

.\VBoxManage.exe modifyvm "VMNAME" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
.\VBoxManage setextradata "VMNAME" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
.\VBoxManage setextradata "VMNAME" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
.\VBoxManage setextradata "VMNAME" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
.\VBoxManage setextradata "VMNAME" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "VMNAME" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1

.\VBoxManage setextradata "VMNAME" VBoxInternal2/EfiGraphicsResolution 1920x1080
```

The last command sets the resolution to 1920x1080. I tried 4K 3840x2160 resolution but the lag was too great with the simulated VBox graphics controller. 

8. Start your virtual machine.

9. If you have a 4K display and are using 1080p resolution for the virtual machine, scale the display with View > Virtual Screen 1 > Scale to 200% which will make each pixel in the virtual machine appear twice as large on the host display. It's not real scaling but it's the best solution I've found so far. 