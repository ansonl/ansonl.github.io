---
title: Ford Escape Faulty Door Lock Actuator Patch
excerpt: |
  Vehicle alarm going bump in the night? Persistent door ajar alarm? Join me as we fix it.

  ![Ford Escape door lock actuator electrical connector wire jump](wp-content/uploads/2016/08/wire-jump-min.jpg "Ford Escape door lock actuator electrical connector wire jump")
author: Anson Liu
layout: post
categories:
  - Vehicle
tags:
  - ford escape
  - rr door
  - lock actuator assembly
---

I recently bought a used 2007 Ford Escape Hybrid and [installed a DIY audio AUX input in it]({{ site.baseurl }}/2016/08/ford-escape-audio-aux-input/). 

### Rear right door ajar issue

Starting last month, the Escape dashboard began showing the right rear door as ajar at random times. Sometimes the door would be detected as ajar while driving or going over bumps. Opening and reclosing the door repeatedly sometimes made the ajar warning go away for a while but there was not real pattern to it. The the vehicle was still under the Autonation 60 day limited warranty so I brought it in for repair at the dealership. 

![Dealer repair receipt]({{ site.baseurl }}/wp-content/uploads/2016/08/autonation-receipt.jpg "Dealer repair receipt")

The issue was diagnosed as right rear (RR) door lock actuator assembly (part #6L8Z7826412B) needing replacement. This part was on back order with no ETA so the dealer could not fix the problem. 

Meanwhile, I kept driving the car to work and the right rear door was detected as ajar more frequently. The right rear door kept being detected ajar when the vehicle was in motion. Often the door sensor would flip between ajar and closed detections multiple times during a trip; leading to nonstop door ajar warning beepings. 

![Ford Escape miles to empty dashboard display]({{ site.baseurl }}/wp-content/uploads/2016/08/miles-to-empty-dashboard.jpg "Ford Escape miles to empty dashboard display")

When a door is ajar, the Escape dashboard display refuses to show you any other information until the door is closed. For example, I would not be able to view the miles to empty estimate.

### The problem manifests

All the above was livable -- until the Escape decided to intrude on life outside the car. The vehicle alarm would start honking at random times when the car was not being driven. 

Initially I suspected that the vehicle had a faulty alarm system or the eBay sourced key fobs I reprogramed for the vehicle were activating the alarm. 

The random alarm activation and right rear door coming 'ajar' occured more and more frequently.

#### Remember how the right rear door would randomly detect itself as ajar? 

When the car is locked from the outside and the door came 'ajar', the vehicle's perimeter alarm system, assuming the door was forced open by an intruder, would activate the vehicle's horn every second for a few minutes or until I silenced it with the key fob.

I currently live in an apartment complex and frequently walking to my window to silence the alarm gave me exercise (but it was probably worse for neighbors...). 

![Dorman 937-641 Door Lock Actuator](http://www.dormanproducts.com/images/product/medium/937-641-007.JPG "Dorman 937-641 Door Lock Actuator")

Sourcing a replacement door lock actuator was not inexpensive. The OEM [Dorman 937-641 Door Lock Actuator](http://www.dormanproducts.com/itemdetail.aspx?ProductID=66586&SEName=937-641) ran over $100 [online](https://www.google.com/search?q=Dorman+937-641+Door+Lock+Actuator&oq=Dorman+937-641+Door+Lock+Actuator&tbm=shop) and I was not able to find any alternative manufacturers.

### The fix (slaying the b̶e̶a̶s̶t̶ alarm)

In the meantime I patched both the door ajar issue by modifying the door lock actuator cabling to have the door always detected as closed. 

1. Remove the door sail panel (the interior aesthetic door panel) with instructions from [Autozone](http://www.autozone.com/repairinfo/repairguide/repairGuideContent.jsp?pageId=0996b43f8075bf0f). 

![Autozone Ford Escape door diagram](http://repairguide.autozone.com/znetrgs/repair_guide_content/en_us/images/0996b43f/80/20/2c/12/medium/0996b43f80202c12.gif)

2. Disconnect any wires connected to the sail panel and put the sail panel aside. 

3. Peel back the plastic water shield. 6 inches should be enough to let you get at the door lock actuator electrical connector. 

4. Move the red locking tab underneath the electrical connector towards the edge of the connector to unlock the connector. 

5. Disconnect the connector. 

6. Using fordjunkyNC's [tip](http://www.ford-trucks.com/forums/1188276-05-escape-anti-theft-alarm-going-off-2.html#post14439971), jump (connect) the top 2 left wires on the actuator connector. '
  * fordjunkyNC uses 2 T-Taps and 2 male flat spades to jump the two wires. I used another style of wire splice/connectors that I found at my workplace as seen below.
  ![Ford Escape door lock actuator electrical connector wire jump]({{ site.baseurl }}/wp-content/uploads/2016/08/wire-jump.jpg "Ford Escape door lock actuator electrical connector wire jump")
  * The aim here is to complete the circuit between the top 2 left wires of the connector so the door is detected as closed. 
  * You do not need to remove any wires from the connector itself to do this operation. 

7. Reconnect the connector.

8. Reattach the water shield.

9. Reattach the door sail panel. 

The door that you just modified will always be detected as closed. The related issue of the alarm going off because of a detected right rear door breach is also resolved by this patch.

#### Important: The perimeter alarm system no longer protects that door. 

### The result

- No more door ajar warnings on the road.
- You can now view other information on the dashboard display
- Alarm will no longer invade your life and make neighbors hate you.
