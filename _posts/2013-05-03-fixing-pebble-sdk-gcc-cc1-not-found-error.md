---
title: 'Fixing Pebble SDK gcc &#8216;cc1&#8242; not found error'
author: Anson Liu
layout: post
permalink: /2013/05/fixing-pebble-sdk-gcc-cc1-not-found-error
dsq_thread_id:
  - 1260500888
categories:
  - Development
tags:
  - cc1
  - gcc
  - path
  - pebble SDK
---
The Pebble SDK is out in the public, but you&#8217;ll need some command line mashing to get the environment setup. 

So you can follow along the official guide on the Pebble site <a href="http://developer.getpebble.com/1/01_GetStarted/01_Step_2" target="_blank">here</a>. If all goes well, you can stop reading this post and go coding for your Pebble. 

However, you may be getting an exec error when running the guide&#8217;s test compile command in part *2.3.2.E*. 

`arm-none-eabi-gcc: error trying to exec 'cc1': execvp: No such file or directory`

Either the *$PATH* variable mentioned earlier in* 2.3.2.C* isn&#8217;t set correctly or *cc1 *really doesn&#8217;t exist. 

To permanently correct the $PATH variable, open *.bash_profile* or *.profile* — whichever one exists in your home directory */home/USERNAME*. 

Add or modify the PATH command to `PATH=$PATH:$HOME/bin:$HOME/pebble-dev/arm-cs-tools/bin`.  
This will add the *~/pebble-dev/arm-cs-tools/bin* directory to the list of directories to look in for executables when commands are run. This directory where the compiler commands will reside if you have organized your files according to the official guide. 

*.bash_profile* (*.profile* applied to me) is run on logon and changes made apply <a href="http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html" target="_blank">globally </a>to all command line sessions. 

Save changes to the file and logout and log back into the same account. 

Try running the test compile command. If the *cc1* file or another file cannot be found, the compile toolchain archive may not be extracted properly.  
The official guide says to use `tar xjf arm-cs-tools-*.tar.bz2` to extract the archive, but that does not give you a list of extracted files, nor tell the status of the extraction.  
Delete the previously extracted *arm-cs-tools* folder and run `tar -xvf arm-cs-tools-*.tar.bz2 `.  
The -v option will give you a verbose log of all files extracted as the command is executed. 

With both the $PATH variable and extraction completed correctly, the test compile should work and you can continue on with the official guide for installing the Pebble SDK. Any problems? Let me know in the comments and I&#8217;ll get back to you.