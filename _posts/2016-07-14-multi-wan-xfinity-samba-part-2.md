---
title: Multi-WAN + Xfinity + Samba - Part 2/2
excerpt: |
  Finish up setting up the router from [part 1]({{ site.baseurl }}/2016/07/multi-wan-xfinity-samba-part-1/). ✓

  Complete your development environment by setting up an encrypted connection for soley Samba access over Xfinity internet.

  ![Per device VPN client vs Router VPN client](wp-content/uploads/2016/07/per-device-vs-router-vpn-client.png)
author: Anson Liu
layout: post
categories:
  - Development
tags:
  - openwrt
  - comcast
  - xfinitywifi
  - openvpn
  - split tunnel
  - routing mode
  - samba
  - workaround
  - multi-wan
  - mwan
  - luci
  - nohup
---

## Working Beyond the Xfinity with Samba

Now that load balancing is operational, we still have an issue with Samba connectivity thanks to Comcast trying to protect us from ourselves. 

#### This post builds on the [part 1]({{ site.baseurl }}/2016/07/multi-wan-xfinity-samba-part-1/) of this series. If you have not read [Multi-WAN + Xfinity + Samba - Part 1/2]({{ site.baseurl }}/2016/07/multi-wan-xfinity-samba-part-1/) and would like to setup a multi-WAN environment, jump back and read [part 1]({{ site.baseurl }}/2016/07/multi-wan-xfinity-samba-part-1/) now. If you only want to setup VPN on the router and possibly get Samba working, keep reading.

Comcast's list of blocked ports can be found [here](https://customer.xfinity.com/help-and-support/internet/list-of-blocked-ports). Samba (SMB) is one of the services blocked by default.

I tried modifying my remote VM smbd ports and redirecting ports on the router but was not able to get Samba connectivity for unknown reasons. 

Several posts on the internet suggest VPN for using Samba in a restricted environment so I gave it a try.
I setup OpenVPN server on my remote machine using [openvpn-install](https://github.com/Nyr/openvpn-install), a script by [Nyr](https://github.com/Nyr). During the script setup, it may not be obvious as per this [issue](https://github.com/Nyr/openvpn-install/issues/138#issuecomment-196056166), but make sure to enter the correct IPv4 addresses (interface versus public) when prompted by the script. 

The OpenVPN server setup provides us with a *.ovpn client config profile that we can feed into the OpenVPN client in order to connect to the server.

Starting the OpenVPN client on my local workstation allowed me to tunnel my traffic through my OpenVPN server and get around Comcast restrictions to connect with Samba. 

We now have the below setup:

![Triple WAN + VPN]({{ site.baseurl }}/wp-content/uploads/2016/07/diagram-3-triple-wan-vpn.png)

### Unreachable Website Issues over AWS

Actually there was a big issue when connecting to remote servers with VPN. I was using an AWS instance to host the OpenVPN server. Several internet web servers such as those of Google and Yahoo would refuse to connect when I web browsing through the VPN. Other sites such as Bing and CNN worked fine. Ping and DNS were successful for all sites. 

It seems that some sites block certain AWS traffic. I spun up a VM instance on Microsoft Azure and setup OpenVPN server on that VM. The same sites that blocked AWS traffic turned out to not block Azure. VPN server blocking solved. 

### Minimizing VPN Session Overhead

I could stop here and just run the OpenVPN client on each device that I needed Samba access with. However, I would need to distribute the OpenVPN profile to each device on the LAN that needed Samba access across the internet. The OpenVPN server would also need to be configured to handle more concurrent connections and performance would suffer from the overhead of managing multiple VPN sessions. 

![Per device VPN client vs Router VPN client]({{ site.baseurl }}/wp-content/uploads/2016/07/per-device-vs-router-vpn-client.png)

The solution is to run OpenVPN client on the router. I adapted Logan Marchione's [helpful steps](https://www.loganmarchione.com/2014/10/openwrt-with-openvpn-client-on-tp-link-tl-mr3020/) to installing and configuring the OpenVPN client through the command line. 
Adapted OpenVPN client setup from Logan's post:

- Install openvpn-openssl package either through the web GUI or opkg. 

```
opkg update
opkg install openvpn-openssl
```
- Add `tun0` interface to `/etc/config/network`.

```
cat >> /etc/config/network << EOF
config interface 'PIA_VPN'
    option proto 'none'
    option ifname 'tun0'
EOF
```
- Add new firewall zone for `PIA_VPN` in `/etc/config/firewall`.

```
cat >> /etc/config/firewall << EOF
config zone
    option name 'VPN_FW'
    option input 'REJECT'
    option output 'ACCEPT'
    option forward 'REJECT'
    option masq '1'
    option mtu_fix '1'
    option network 'PIA_VPN'
config forwarding                               
    option dest 'VPN_FW'                    
    option src 'lan' 
EOF
```
- Reboot router for changes to take effect.

```
reboot
```

*If copy pasting the commands fails, just append the new config settings to the existing config files.*

Logan uses the command line interface (CLI) because the installable web GUI version of OpenVPN was broken at the time of his writing. It has since been fixed, but you must run `touch /etc/config/openvpn` to pre-create the program's config file if you do decide to use the GUI package as mentioned in this [issue](https://dev.openwrt.org/ticket/19788). 

After installing and setting up OpenVPN on OpenWRT, I copied my setup OpenVPN server's **client profile to `/etc/openvpn/`** on the router. 

When starting the OpenVPN client with `openvpn --config /etc/openvpn/client.ovpn` the created VPN connection hangs after a few minutes. The remedy for my setup was starting `openvpn` with the `--mssfix 1300` option. ServerFault [solution](http://serverfault.com/a/636437). 

To manually start OpenVPN client in the background and persist after closing the shell we need to modify our command.

- Have openvpn ignore the SIGHUP signal that is sent when closing the terminal session with `nohup`. OpenWRT BusyBox does not include `nohup` by default so **install the `coreutils-nohup` package** using either the web GUI or `opkg` over the CLI. 
- To discard logging from nohup we redirect `stderr` to `stdout` with `2>&1`. 
- Start the program in the background by appending `&`. 

The final command looks similar to

```
nohup openvpn --config /etc/openvpn/client.ovpn --mssfix 1300 2>&1 &
```

Now you can manually start the OpenVPN on the router and all internet traffic will be tunnelled through your VPN server. Devices that do not natively support VPN are now secured. A lot less work than setting up OpenVPN on each device I wanted to use!

A simple command line script to run openvpn:

```
#!/bin/sh
nohup openvpn --config /etc/openvpn/client.ovpn --mssfix 1300 2>&1 &
```

If saved to `~/startOpenVPN.sh` and `chmod 700 ~/startOpenVPN.sh`, you can start the client by running `~/startOpenVPN.sh`.

I decided to not start the client on router startup because a failed startup would leave me in an undesired connectivity status. Starting the client automatically can be left as an exercise for the reader.

### Optimized Routing with Split Tunnel

When tunneling traffic VPN, I noticed that my 2x `xfinitywifi` speed advantage was eliminated and I was getting speeds comparable to not combining two wireless networks. VPN traffic was being routed to the VPN `tun0` interface and `openvpn` was only utilizing wan2 -> radio0 for VPN traffic. 

I was unable to figure out how to get `openvpn` to load balance over two WANs. There are many posts on the internet about done this the opposite direction, an OpenVPN server ultilizing multiple interfaces but no resources that I have found for the OpenVPN client.

- `mwan3` operates at the routing layer of the network stack. 
- `openvpn` operates at the routing layer in [routed mode](https://community.openvpn.net/openvpn/wiki/OpenVPNBridging).

Both programs modify routes `/etc/config/network` to work, `mwan3` sets routes according to load balancing policies on system startup and `openvpn` adds a route for all traffic to go through `tun0` by default. `tun0` traffic is then handled by `openvpn` and I haven't figured out how to configure the `openvpn` client actually utilize more than one WAN. I know that the client is still using more than one WAN because the VPN connection will disconnect when one WAN goes down.

I only need VPN for Samba connectivity. Samba operating at 1x `xfinitywifi` speed is acceptable for my purposes. 

The solution for maximum throughput was configuring OpenVPN with a split tunnel. In a split tunnel we define rules that determine whether traffic should pass through the tunnel or not.

A split tunnel can be setup to a range of IP addresses with the `--route network/IP [netmask] [gateway]` option for openvpn. Any traffic destined for the specified `network/IP` address range will be routed through the `gateway`. [OpenVPN command reference](https://openvpn.net/man.html)

Setup a split tunnel by **adding the below** to the end of the `*.ovpn` client config profile

```
route-nopull
route x.x.x.x 255.255.255.255 vpn_gateway
```

where `x.x.x.x` is the IP address of our Samba server.

`route-nopull` tells the client to ignore any routes that the OpenVPN server pushes to it. A normal OpenVPN server (the one I setup) is configured as a full tunnel for all traffic. We want to use ONLY our own routes. This way we will be able to have a normal full tunnel to the OpenVPN server without modifying configurations on server or other clients.

`route x.x.x.x 255.255.255.255 vpn_gateway` specifies that all traffic to `x.x.x.x` in the netmask of `255.255.255.255` will be routed through `vpn_gateway`. 

ONLY Samba traffic to my remote server will be sent through the VPN, all other traffic will be handled according to my multi-WAN policies and benefit from load balancing speed up.

We now have the below setup:

![Triple WAN + VPN + Split Tunnel]({{ site.baseurl }}/wp-content/uploads/2016/07/diagram-4-mwan3-vpn-split-tunnel-diagram.png)

### Samba Hardening

Lastly, the remote Samba server can be hardened by updating Samba, enabling encryption, and specifying minimum supported protocol. 
Add these options to /etc/samba/smb.conf on the Samba server immediately after the `[global]` line:

```
# Enable encryption and disable insecure LANMAN hash usage for authentication
smb encrypt = mandatory
lanman auth = no

#server signing not needed due to smb encrypt being selected
#https://git.samba.org/?p=samba.git;a=commitdiff;h=51ae17b0703eaa481d602ffc7d8231a629fcb5fd
#server signing = mandatory

#Support win7 and up
server min protocol = SMB2_10
```

### Does it wifi *[again]*? 

After following the steps from the part 1 post and above, you should be able to access Samba over VPN while getting close to 2x or 3x speed for all other traffic. 

If you run into problems check out the [mwan](https://wiki.openwrt.org/doc/howto/mwan3), [OpenVPN](https://openvpn.net/index.php/open-source/documentation/manuals/openvpn-20x-manpage.html), and [Samba](https://www.samba.org/samba/docs/man/manpages/smb.conf.5.html) documentation. 

Let me know how it goes in the comments! 