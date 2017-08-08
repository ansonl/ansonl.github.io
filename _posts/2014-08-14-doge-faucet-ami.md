---
title: 'Doge Faucet AMI &#8211; Let the doge flow!'
author: Anson Liu
layout: post
permalink: /2014/08/doge-faucet-ami
dsq_thread_id:
  - 2926769547
categories:
  - Development
tags:
  - ami
  - aws
  - cudaminer
  - doge faucet
  - poclbm
  - rc.local
  - upstart
---
<div id="attachment_3085" style="width: 710px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/doge-faucet.jpg"><img class="wp-image-3085" src="https://ansonliu.com/wp-content/uploads/2014/08/doge-faucet.jpg" alt="Doge Faucet - AMI-984d9ff0" width="700" height="94" /></a><p class="wp-caption-text">
    Doge Faucet &#8211; <em>AMI-984d9ff0</em>. Let the doge flow!
  </p>
</div>

<p style="text-align: center;">
  <!--more-->
</p>

CUDA/CPU mining [setup][1] (AMI-984d9ff0 is a ready made version of this script for public use.):  

{% gist a01911113d264976fb49 %}


Poclbm/CPU mining [setup][2] (Use [Erik Hazzard][3]&#8216;s AMI-87377cee. Erik has already setup CUDA, OpenCL, and PyOpenCL on the AMI):  

{% gist 472c619ade1328fa66a2 %}

**UPDATE:** What fun is it when you need to login to each spawned instance and run `~/commands.sh` to start mining? Copy pasting each instances&#8217; public IP/DNS gets old quick. I would like to be able to mine when the spot instance is low with minimal effort.  
Create a script that will be run on boot at `/home/ubuntu/boot.sh`  

{% gist 8251d327fb73b93807f3 %}

Finally add `start autodoge` to the `/etc/rc.local` file right before the `exit` call.  
Now `rc.local` will start the `autodoge` service on boot which in turn runs `boot.sh`. You can edit `boot.sh` with your pool details and parameters. I have created *AutoDoge Faucet &#8211; AMI-70439e18* which has this setup.

 [1]: https://gist.github.com/ansonl/a01911113d264976fb49
 [2]: https://gist.github.com/ansonl/472c619ade1328fa66a2
 [3]: http://vasir.net/blog/opencl/installing-cuda-opencl-pyopencl-on-aws-ec2
 [4]: http://infovore.org/archives/2013/08/09/running-scripts-on-startup-with-your-raspberry-pi/