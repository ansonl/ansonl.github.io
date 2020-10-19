---
published: false
---
## Clean install OS X on a Macintosh computer made during or after 2011 with an unknown EFI password.

My father and I were trying to use a [Mid-2011 Apple iMac](https://everymac.com/systems/apple/imac/specs/imac-core-i7-2.8-21-inch-aluminum-mid-2011-thunderbolt-specs.html) to run some games and it was exhibiting strange issues with no clear fix. Before I left California for college in 2012 I had upgraded this iMac from stock HDD by adding an internal 256 GB Sandforce SSD. The 2011 iMac curiously enough has enough space inside the display case to fit 2 storage drives. This wasn't the ole' optical drive <-> second storage drive swap; there is enough space to keep the optical drive behind the display! I recall the second storage drive fit behind the optical drive but it was a tight fit to refit the display on the case (no glue for this model, either!). I had installed OS X 10.7 Lion on the 256 GB SSD and set my home directory to be located on the 1 TB HDD to maximize space savings on the smaller capacity SSD. The applications folder was also half mapped onto the HDD for "large" games [30 GB of StarCraft was big]. After 8 years of almost nonexistent usage and trusting the automatic OS X updater to update this strange configuration every few years, errors started to impede using it for games:

- **Safari** - *Not Enough Free Disk Space*. 
  - There was enough disk space. A recent OS X major upgrade had decided to recreate an identical home directory on the SSD where the installer expected the home directory to exist. This new home directory's Downloads folder was being used by Safari as the default download location but I suspect the new home's access permissions were never set up correctly, leading for Safari to conclude that no new file creation meant no more disk space. 

- **Finder** - Choose file dialog freeze
  - Likely related to the new "fake home directory" permission issue described above. 
  
- **Battle.net** - *Another copy of Blizzard setup is already running on this computer. Please close it and try again.*
  - We couldn't find another Blizzard/BattleNet agent setup process running on the computer. 
  



TLDR: The USB drive with the OS X Installer **must be formatted using the GUID Partition Table (GPT)** before writing the OS X Installer files to it. Set startup disk to a USB drive formatted with OS X Installer using the System Preferences app. 