---
title: Fixing Cyberduck
author: Anson Liu
layout: post
permalink: /2012/09/fixing-cyberduck
dsq_thread_id:
  - 836178141
categories:
  - Development
tags:
  - "%tmp%"
  - Cyberduck
  - SFTP
---
If you have been using Cyberduck on Windows and have encountered the error` Could find part of the path` when you try have Cyberduck automatically download an open a file for editing, you `tmp` directory may be corrupted from a previous instance of editing.  
The `tmp `directory is used by Cyberduck to store the downloaded files when you edit them directly from the program.

**A quick fix:**  
&#8211; Run > `%temp%`  
&#8211; Delete Cyberduck&#8217;s `tmp` directories (or delete all if you don&#8217;t need the contents of tmp)

Try to edit the file again and it will open successfully.