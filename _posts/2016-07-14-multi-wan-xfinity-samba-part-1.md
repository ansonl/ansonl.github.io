---
title: Multi-WAN + Xfinity + Samba - Part 1/2
excerpt: |
  Add some extra bandwidth to your Xfinity internet connection by setting up Multi-WAN on your router. 

  ![OpenWRT Wifi Scan](wp-content/uploads/2016/07/openwrt-wifi-scan.png)
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

## From Zero to Xfinity

Comcast subscribers who use the rented modem get to take part in the festival of wifi — `xfinitywifi`. Comcast also blocks Samba which makes things hard because I would like to mount my remote development filesystem on my main Windows workstation. 

#### If you are only interested in accessing Samba over Comcast internet, jump to [Multi-WAN + Xfinity + Samba - Part 2/2]({{ site.baseurl }}/2016/07/multi-wan-xfinity-samba-part-2/).

I wanted faster internet at my second work location to supplement cellular tethering. As an existing Comcast subscriber, I am able to get internet using other Comcast subscribers' broadcast `xfinitywifi` hotspot networks. 

Some adjacent tenants use Comcast and they participate in `xfinitywifi`. 

I read Mike Solomon's [post](https://msol.io/blog/tech/how-i-doubled-my-internet-speed-with-openwrt/) on how he doubled his bandwidth with an OpenWRT multi-WAN setup and wanted to see if I could get a stable setup using two `xfinitywifi` networks. 

I followed roughly the same steps as Mike and did some additional configuration to complete my multi-WAN setup and get Samba working with a Comcast internet connection. 

If you haven't read Mike's post yet, follow up through his step 5 and come back for more multi-WAN action. After setting up our network for dual WAN with Mike's instructions, we have the below setup: 

![Dual WAN]({{ site.baseurl }}/wp-content/uploads/2016/07/diagram-1-dual-wan.png)

### 1. Connect to `xfinitywifi` (again)

Go to Network > Wifi. 

Scan and connect to a second `xfinitywifi` network with your router's second wireless radio. 
The second wireless radio may be named `radio1`. 

(You probably need a dual band router to do this easily.)

![OpenWRT Wifi Scan]({{ site.baseurl }}/wp-content/uploads/2016/07/openwrt-wifi-scan.png)

### 2. Create new MWAN interface configuration

Go to Network > Load Balancing > Configuration > Interfaces.

Create a new configuration for MWAN called `wan3`. 
Use the same values of `wan2` configuration for that of `wan3`. 

![OpenWRT MWAN Interface]({{ site.baseurl }}/wp-content/uploads/2016/07/openwrt-mwan-interface.png)

### 3. Create MWAN member configuration for `wan3`

Go to Network > Load Balancing > Configuration > Members.

Create a two new members for the interface of `wan3` called `wan3_m2_w2` and `wan3_m1_w2`.
Use metric of `2` and `1` respectively and weight of `2` for both members. 

![OpenWRT MWAN Members]({{ site.baseurl }}/wp-content/uploads/2016/07/openwrt-mwan-members.png)

### 4. Include `wan3` in MWAN policies.

Go to Network > Load Balancing > Configuration > Policies.

If you are utilizing an ethernet internet connection, edit the `balanced` policy to include the `wan3_m1_w2 member`. 
If you do not have an ethernet internet connection and will be utilizing both `xfinitywifi` networks for improved internet speed, create a new policy `wan2_wan3` and assign members `wan2_m1_w2` and `wan3_m1_w2` to it. 

Use the sort buttons to the right to move your desired policy to the top of the list. 

![OpenWRT MWAN Policies]({{ site.baseurl }}/wp-content/uploads/2016/07/openwrt-mwan-policies.png)

### 5. Edit network config for wan3.

Add the following to `/etc/config/network`.

```
config route 'default_wan3'
	option interface 'wan3'
	option target '0.0.0.0'
	option netmask '0.0.0.0'
	option gateway '192.168.1.1'
	option metric '30'
```

We now have the below setup:

![Triple WAN]({{ site.baseurl }}/wp-content/uploads/2016/07/diagram-2-triple-wan.png)

### Does it wifi?

Each surrounding xfinitywifi network provides about 16mbps/2mbps. I tested my setup and can get 32mbps/4mbps, confirming that load balancing across two wireless networks is working as expected. 

#### Read on to [Multi-WAN + Xfinity + Samba - Part 2/2]({{ site.baseurl }}/2016/07/multi-wan-xfinity-samba-part-2/) to cover forbidden knowledge such as:

- Samba connectivity in a restricted environment such as Comcast
- Setting up OpenVPN client on OpenWRT
- Setting up a split tunnel to maximize multi-WAN speed up