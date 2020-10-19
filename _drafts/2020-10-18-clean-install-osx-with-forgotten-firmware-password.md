---
published: false
---
## Clean install OS X on a Macintosh computer made during or after 2011 with an unknown EFI password.

My father and I were trying to use a [Mid-2011 Apple iMac](https://everymac.com/systems/apple/imac/specs/imac-core-i7-2.8-21-inch-aluminum-mid-2011-thunderbolt-specs.html) to run some games and it was exhibiting strange issues with no clear fix. Before I left California for college in 2012 I had upgraded this iMac from stock HDD by adding an internal 256 GB Sandforce SSD. The 2011 iMac curiously enough has enough space inside the display case to fit 2 storage drives. This wasn't the ole' optical drive <-> second storage drive swap; there is enough space to keep the optical drive behind the display! I recall the second storage drive fit behind the optical drive but it was a tight fit to refit the display on the case (no glue for this model, either!). I had installed OS X 10.7 Lion on the 256 GB SSD and set my home directory to be located on the 1 TB HDD to maximize space savings on the smaller capacity SSD. The applications folder was also half mapped onto the HDD for "large" games [30 GB of StarCraft was big]. After 8 years of almost nonexistent usage and trusting the automatic OS X updater to update this strange configuration every few years, errors started to impede using it for games:

- **Safari** - *Not Enough Free Disk Space*
  - There was enough disk space. A recent OS X major upgrade had decided to recreate an identical home directory on the SSD where the installer expected the home directory to exist. This new home directory's Downloads folder was being used by Safari as the default download location but I suspect the new home's access permissions were never set up correctly, leading for Safari to conclude that no new file creation meant no more disk space. 

- **Finder** - Summoning choose file dialog leds to 1 minute spinning beach ball.
  - Likely related to the new "fake home directory" permission issue described above. 
  
- **Battle.net** - *Another copy of Blizzard setup is already running on this computer. Please close it and try again.*
  - We couldn't find another Blizzard/BattleNet agent setup process running on the computer. 
  
- **iMessage Screen Sharing** - *Screen sharing option grayed out*
  - Yes, Apple has built in a VNC tunneling capability that traverses the internet and NAT! The screen share is supposed to be initiated between iMessage users through the contact detail popover > screen share icon.
  - This issue was partially resolved by adding the iMessage contact's **Apple ID email** to the correct contact card. 
  - iMessage appears to use phone numbers to tie together messages and recipients. iMessage Screen Sharing creates a connection between two Apple IDs. The glue that ties phone numbers to Apple IDs needs help associating the two types of identification and this requires both sides of the screen share to have the other side's Apple ID email and phone number in the same contact card.
  
We wanted to use the iMac to play games such as Starcraft 2 and Call of Duty. A clean install to the latest supported OS X 10.13 High Sierra would be the easiest way to resolve all our issues. Unfortunately I forgot the iMac's firmware password over 8 years away from home so we were unable to select an alternate start up disk at EFI startup by holding any of the ALT/OPTION combinations. 

2011 was also the first year where Apple moved the firmware password storage from PRAM to a [separate chip](https://www.cnet.com/news/efi-firmware-protection-locks-down-newer-macs/)(apparently Atmel [ATtiny13](http://ww1.microchip.com/downloads/en/DeviceDoc/2535S.pdf)) with persistent storage on the logic board. 

Pre-2011 Mac EFI passwords could be reset by removing power and making a hardware change such as changing the amount of memory installed on the computer. Due to the new EFI password storage design, the only way to change the password short of desoldering or attaching a hardware based EFI unlocker is the bring the computer to an Apple Store or Authorized Apple Repair location. The technicians as the location can send the computer's EFI hash to the mothership which will use a master key to create binary file with unlock commands which are loaded onto a USB drive. This binary file is checked by the EFI on start up reset the password if the matching binary is found.
  



TLDR: The USB drive with the OS X Installer **must be formatted using the GUID Partition Table (GPT)** before writing the OS X Installer files to it. Set startup disk to a USB drive formatted with OS X Installer using the System Preferences app. 