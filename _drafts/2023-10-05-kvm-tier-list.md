---
published: false
title: >-
  The Weird, Wacky World of Consumer Level KVMs
author: Anson Liu
layout: post
categories:
  - hardware
tags:
  - kvm
  - tierlist
excerpt: >
  SUNLU T3 printer Marlin 2 configuration can be downloaded [here](https://github.com/MarlinFirmware/Configurations/tree/import-2.1.x/config/examples/Sunlu/T3). 


  This configuration fixes a bug where the extruder cooling fan would only turn on when the motors were active and not when the extruder was hot. This could lead to heat creep and a clogged hotend if the hotend heater was left on and the motors were off.


  ![sunlu t3 bottom](/wp-content/uploads/2023/08/sunlu-t3-motherboard.JPG)
---

There are a lot of KVM (keyboard, video, mouse) switches out there and they are not all the same. The most obvious difference between KVMs is the display connector type (VGA/DVI/HDMI/DP), switching display (1+) count, and switching computer (2+) count offered on a single unit. This post will focus on DVI/DP consumer level KVMs and touch on secure KVMs at the end.

Some KVMs only switch display or HID (mouse/keyboard) exclusively. These are often much cheaper but are for different use cases and usually don't switch between more than two computers. You could buy a separate display only and HID only switch, but the costs may be similar after buying two switches. Why use two switches when one switch does the job?

### KVM Connections and Pricing

For consumer KVMs of the same display connector type, the number of displays and computers that you can connect to it are the primary determinant of price. The price tends to scale linearly with the number of connections with number of displays having a stronger scaling factor. For example, a KVM with 1 DVI port switched between 2 computers may cost $100. The same manufacturer's model switching between 4 computers may increase the price by a factor of 2. Doubling or quadrapling the number of DVI ports will often increase the price by more than the expected factor of 2 or 4. KVMs with a high amount of display and computer ports will cost much more than buying the equivalent amount of KVMs with fewer ports due to the specialty nature of these products.

Why the high prices? The manufacturers know that you aren't looking for a KVM the same way you would a mouse pad.

### Why Get a KVM Switch?

You buy a KVM on purpose because you are one or a combination of the following:

1. Desperate for a KVM because your workspace set up cannot be rearranged to avoid it.

    - You could have spent the money on buying a second or third set of keyboards, mice, and monitors (and don't forget about mounting equipment and extra desk space). Obviously you didn't and now you're here.

2. Want a minimal workspace, the fewest number of monitors, and maximized desk space. You prefer the monitors to always be "in front" of you. The monitors may also be expensive relative to the KVM cost.

3. Regulations for work say so. You work in a SCIF and never see sunlight.

The user experience varies between frustrating and mostly seamless depending on the KVM you choose.

### USB Emulation/Switching

KVMs support varying levels of USB and display emulation to connected computers.

KVMs with no emulation will physically or electronically switch the USB devices and displays between the connected computers.

Within KVMs that have USB emulation, functionality ranges from standard keyboard and mouse functions to full time communication passthrough to all connected computers (this is marketed as Dynamic Device Mapping (DDM) by ConnectPro). Using USB HID emulation, KVMs can intercept keyboard and mouse commands to offer more user friendly capabilities.

#### Keyboard Emulation

KVMs can intercept keyboard strokes as hotkeys to trigger KVM features such as switching to specific ports or modifying KVM settings. 

On many KVMs, pressing a special key such as Control or Scroll Lock twice in a row causes the KVMs to intercept the next keystroke as a command to the KVM that is not passed onto the computer. E.g. ScrLk+ScrLk+2 may command the KVM to switch to computer #2 so you no longer need to physically press a switch on the KVM unit.

#### Mouse Emulation

Mouse position is typically reported in relative position to the last position report. Mice and OSes also support [absolute mouse mode (ABS)](https://www.blackbox.com/en-nz/insights/blogs/detail/technology/2021/01/27/absolute-mouse-mode-explained) which interprets position data as absolute X and Y coordinates.

***Picture this:** You have two computers hooked up to a KVM and are doing tasks with the mouse pointer on the left side of the desktop on computer #1. When you switch the displays and mouse to computer #2 using the KVM, where would your mouse pointer be?*

1. Relative mouse mode would keep your mouse pointer wherever it was the last time you used computer #2. This could be on the right side of the screen, hidden in the corner, or any number of places.

2. Absolute mouse mode would report your mouse pointer's last position in computer #1 to computer #2. With proper OS support, your mouse pointer would be moved to the same location on the screen in computer #2 as it was in computer #1.

Some KVMs have setting to switch between relative and absolute mouse mode sync up the mouse position between computers. 

#### Non-HID USB Switching

Some KVMs come with a switchable general purpose USB2/USB3 port for non HID devices. This switchable USB port comes in handy if you want to switch a USB flash drive or smart card reader between computers.

### Display Emulation

#### DDC EDID Emulation

At the entry level, KVM display emulation involves saving the connected monitors' [EDID](https://www.omnivex.com/support/kb/200#:~:text=EDID%20is%20what%20enables%20a,monitor%20and%20a%20display%20adapter.) data to the KVM controller and passing the EDID data to all connected computers. EDID describes a display's characterics such as manufacturer model and supported resolutions and timings. EDID is passed from the display to the computer over a communication channel on the video cable called DDC.

If a KVM only passes on video signal, the computer will not get display characteristics and it is difficult for a computer to know if the same display was reconnected and what the optimal resolution and refresh rate should be.

The majority of DVI and DisplayPort KVMs support DDC EDID Emulation as a standard feature.

Before DisplayPort became widespread, connection protocols for video data (VGA/DVI/HDMI) were one way. KVM display handling essentially had three options that affected the user experience:

1. **Don't emulate DDC EDID.** Physically disconnect and reconnect displays to the selected computer on the fly. Each computer would detect a display disconnection/reconnection with every switch. This led to long reinitialization times. The display would resync with the computer and do auto adjustments. The computer would resize and rearrange windows and resolutions going from the absence of a display to a new display. Windows jumping to the wrong screen or being repositioned in awkward locations was highly disruptive. This process could take anywhere from 1-10 seconds depending on your computer and display combination.

2. **Emulate DDC EDID only to the currently selected computer.** Disconnect and reconnect displays to the selected computer on the fly. The same result as #1 but with reduced auto adjustment and resync side affects.

3. **Emulate DDC EDID to all computers.** Electronically switch displays to the selected computer on the fly. Each computer would read the displays as always connected and be sending video data over the cable to the KVM. Only selected computer's video data would actually be passed on to the real display. Switch times were improved to 1-5 seconds since the computer would not resize and rearrange windows after each switch - after all, the computer never knew that the display was switched away.

4. **Emulate DDC EDID to all computers. Emulate a virtual screen in KVM memory.** Electronically switch the virtual screen to the selected computer video data on the fly. Keeping an internal representation of the screen data and buffering and merging the video data between different switching computers. In theory this method would have near zero lag as both the displays and computers would not be switching between video data feeds.

Almost every DVI KVM available uses method #3. What actually differs between new DVI KVM switches is the amount of display/computer connections built into one switch.

#### DisplayPort Emulation

The KVM landscape changed with the advent of DisplayPort (DP). Unlike predecessor video protocols which were one way where a computer blindly sent video data to the monitor, DP uses [packetized data transmission](https://en.wikipedia.org/wiki/DisplayPort) where the computer and display communicate in a two way data stream. The two data stream allows the computer and display to sync up with faster timings for more data transfer and extensible features. More data transfer means higher resolutions at a faster refresh rate. Extensible features include audio transmission and daisy chaining displays to each other.

The packetized data transfer is more easily converted to a one way video protocol such as DVI or HDMI than the other way around. **The takeaway is that DP to other connector adapters are all ONE WAY.** DP→DVI and DP→HDMI adapters are widespread and low cost. HDMI→DP adapter are significantly more expensive and almost always require an external power source (often in the form of a USB cable) to power the communication module. There are a few exceptions such as the [Lindy HDMI→DP adapter](https://www.lindy-international.com/HDMI-to-DisplayPort-Converter.htm?websale8=ld0101.ld021102&pi=38146) that is powered off the cable but this adapter comes with the trade off of not supporting 4k resolution at a refresh rate faster than 30Hz.

DP packetized data transmission also meant that KVMs that simply cut off data communication between monitors and computers would disrupt the two way communication stream between the two and force a resync the next time they were connected. This disruption also gave away to the computer, the fact that the display was "disconnected", leading to the window rearrangement hell that occured before DDC EDID emulation was widespread.

ConnectPro attempted to solve switching DP connections by implementing "[full-time EDID emulation](https://connectpro.com/collections/advanced-displayport-1-4-kvm-switch)". ConnectPro KVMs save a connected DP monitor's EDID information and emulate an equivalent DP monitor on every switched computer's DP connection port.

When I got my first DP KVM in 2020 to switch between Windows and Mac computers, I noticed that the Mac computers would persist window positions between display switches while Windows would rearrange windows as soon as it detected that a DP connection was disrupted.

Eventually Microsoft silently released a Windows 10 update sometime in 2021-22 in which window persistence was kept between DP communication disruptions but where the DP cable was not physically unplugged.

Today both Windows and Mac do well at maintaining window persistence and remembering where displayed windows should be when switching DP monitors with a KVM.

### Choosing a DVI KVM

DVI DDC EDID Emulation is now so widespread that the display switching between DVI KVMs is the same no matter which DVI KVM you get. Depending on your needs, you may already be restricted to a choice of 1-2 KVMs on the consumer market. However there is still a reliability and aftermarket support difference between brands which will be covered after the DP section.

I have used the Belkin F1DN104E Secure 4 Port Dual DVI-I KVM and IOGear GCS1644 4 Port Dual DVI KVM for 2 years each and had a good experience. Both models are sturdily built in metal casing and I never had a failure with either.

Belkin Secure DVI KVM is a barebones model that does not come with non HID USB switching. It simply switches 2 DVI displays and a usb keyboard and mouse between 4 computers.

- The Belkin Secure KVM line offers a KVM model that supports a USB smart card reader but I have not used it myself.

IOGear GCS1644 KVM switches 2 DVI displays and a usb keyboard and mouse between 4 computers. It also has a switchable USB 2.0 peripheral port that is switched among the connected computers.

- This KVM supports keyboard hotkeys and has settings to configure USB emulation and keyboard command hotkeys.
- GCS1642 and GCS1644 KVMs can be controlled over a serial interface through a RJ45 port. You can remotely send the KVM signals to control switching and other settings which gives these KVMs massive flexibility and customizability.
- Two IOGear KVMs can be connected to each other over serial interface in a master/slave arrangement and switching with the master KVM will switch the slave KVM. This allows you to increase the amount of switched displays by using two KVMs at once.

### Choosing a DisplayPort KVM

Finding a list of current DP KVMs is hard. Here it is:




I have used the ConnectPro UDP2-12AP 2 Port Dual DP 1.4 KVM and IOGear GCS1942 (2 Port) and GCS1944 (4 Port) Dual DP KVMs. 

The ConnectPro UDP2-12AP was work in progress when I used it between 2021-2022. I got the model second hand and it worked well with Mac. However Windows did not respond properly to the "full-time EDID emulation" when the KVM was switched away from the Windows computer leading to window rearrangement. 

- The KVM has a switchable USB3 peripheral port.
- ConnectPro claims to have updated firmware for their DP KVMs that fixes compatibility problems with new OSes. However ConnectPro does not openly distribute the firmware and they will NOT provide you with updated firmware for a ConnectPro KVM obtained second hand without original purchase receipt. 
- I would only recommend trying a ConnectPro KVM if you have the additional money to buy one new or find a second hand model for a steep discount and are willing to take the chance on the KVM not working on your setup. I ended up selling my ConnectPro UDP2-12AP to a buyer who was likewise willing to take the risk.

The IOGear GCS1942 and GCS1944 switch 2 and 4 computers respectively. I currently use 1 GCS1942 and 1 GCS1944 connected to each other over serial port (DDC).

- The IOGear KVM has a switchable USB3 peripheral port that I use with my trackball and smart card reader. These KVMs have USB emulation for keyboards and mice that can be turned off if you use nonstandard keyboard or multibutton mouse.
- GCS1942 and GCS1944 KVMs can be controlled over a serial interface through a RJ45 port. You can remotely send the KVM signals to control switching and other settings which gives these KVMs massive flexibility and customizability.
- Two IOGear KVMs can be connected to each other over serial interface in a master/slave arrangement and switching with the master KVM will switch the slave KVM. This allows you to increase the amount of switched displays by using two KVMs at once.
- I have [confirmed](https://youtu.be/NlyIbFiSxfk?si=9BGVQbmipHlZiEIH) that the GCS1942 2 Port and GCS1944 4 Port KVM are compatible with each other when connected over serial port. Switching to the 3rd or 4th port when master is the 4 Port KVM results in the slave 2 Port KVM switching to its second port (its highest port). I had preferred and expected the 2 Port KVM to ignore a serial command to switch to a higher port than it physically has but its actual behavior of switching to the 2nd port is also acceptable.


![sunlu t3 bottom](/wp-content/uploads/2023/08/sunlu-t3-bottom.JPG)