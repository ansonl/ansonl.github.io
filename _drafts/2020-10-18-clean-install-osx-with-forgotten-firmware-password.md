---
published: false
---
## Clean install OS X on a Macintosh computer made during or after 2011 with an unknown EFI password.

My father and I were trying to use a [Mid-2011 Apple iMac](https://everymac.com/systems/apple/imac/specs/imac-core-i7-2.8-21-inch-aluminum-mid-2011-thunderbolt-specs.html) to run some games and it was exhibiting strange issues with no clear fix. Before I left California for college I had upgraded this iMac from stock HDD by adding an internal 256 GB Sandforce SSD. The 2011 iMac curiously enough has enough space inside the display case to fit 2 storage drives. This wasn't the ole' optical drive <-> second storage drive swap; there is enough space to keep the optical drive behind the display! I recall the second storage drive fit behind the optical drive but it was a tight fit to refit the display on the case (no glue, either!). 

TLDR: The USB drive with the OS X Installer **must be formatted using the GUID Partition Table (GPT)** before writing the OS X Installer files to it. Set startup disk to a USB drive formatted with OS X Installer using the System Preferences app. 