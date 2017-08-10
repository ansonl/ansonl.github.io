---
title: Making Ford AUX Audio Expansion w/ Stock Inline Control
author: Anson Liu
layout: post
image: /wp-content/uploads/2017/07/all_pcb_bench.jpg
categories:
  - Vehicle
tags:
  - ford escape
  - acp
  - cd changer
  - aux
  - pcb
  - eagle
published: false
---

I finished an AUX audio system that plugs directly into my Ford Escape's electrical system and uses the original head unit controls to manage playback on iPhone. This expands upon my [previous project]({{ site.baseurl }}/2016/07/ford-escape-audio-aux-input/) to add an AUX audio connection to the vehicle. 

1. [Backstory](#backstory)
2. [AUX Audio version 1 - Splicing audio wires](#aux-audio-version-1---splicing-audio-wires)
3. [Ford ACP Timeline](#ford-acp-timeline)
4. [AUX Audio version 2 - Emulating the CD Changer with Arduino](#aux-audio-version-2---emulating-the-cd-changer-with-arduino)
   1. [Setting Up Serial](#setting-up-serial)
   2. [Setting Up TX_ENABLE Pin](#setting-up-tx_enable-pin)
      - [Chart for `PORTA |= (1<<PA6)`](#chart-for-porta-1-lt-lt-pa6-)
   3. [Breadboard the Project](#breadboard-the-project)
   4. [Protoboard the Project](#protoboard-the-project)
5. [AUX Audio version 3 - Adding head unit playback control](#aux-audio-version-3---adding-head-unit-playback-control)
   1. [Inline Playback Control](#inline-playback-control)
      - [Android Inline Control](#android-inline-control)
      - [Apple Inline Control](#apple-inline-control)
   2. [Inline Control Timing](#inline-control-timing)
6. [AUX Audio version 4 - Pulling It All Together](#aux-audio-version-4---pulling-it-all-together-on-pcb-)
   1. [Learning EAGLE](#learning-eagle)
   2. [PCB Fabrication](#pcb-fabrication)
   3. [Vehicle Wiring](#vehicle-wiring)
      - [Ford Escape head unit access](#to-the-access-the-back-of-the-ford-escape-head-unit-)
   3. [PCB Arrives](#pcb-arrives-2-weeks-later-)
7. [Finishing Up](#finishing-up)
   1. [Credits](#credits)

## Backstory

Last July I added an AUX audio input to a recently acquired 2007 Ford Escape Hybrid. The reasons for adding an AUX audio input were:

- No built in AUX audio input.
- Expensive (>$50) third [party](http://www.ycarlink.com/pd_12391_Digital-CD-USB-SD-AUX-Bluetooth-changer-emulator-adapter-for-new-Ford-quadlock-Fakra-12-pin-6000CD-6006CDC-5000C.htm) [accessories](http://www.discountcarstereo.com/AUX-FRDW.html) that emulated the CD changer to add AUX audio capability. 

## AUX Audio version 1 - Splicing audio wires

At the time, I found the correct CD changer connector pin out from a [Taurus Car Club Forum post](https://web.archive.org/web/20151102133458/http://www.taurusclub.com/forum/attachments/electronics-security-audio-visual/34387d1106003765-cd-changer-interface-cdchanger_pinout.jpg). I stripped a normal Tip Ring Sleeve (TRS) audio jack cable to expose the three wires within: Left, Right, Ground. These wires were then connected to their respective pins in the CD changer connector. 

<img alt="AUX1" data-src="{{ '/wp-content/uploads/2017/07/aux_1.jpg' | prepend:site.baseurl }}" class="lazyload" />

The result was an operational CD changer and a spliced in AUX audio jack for a phone. 

There were a few drawbacks to the spliced in AUX audio:

- Not standalone. Reliant on original CD changer to send the "disc loaded" signal to the Ford Navigation CD Player head unit. 
- Sometimes unreliable connection due to aging brittle connection wires to the head unit.
- No original **Next/Previous** and **Fast Forward/Rewind** functionality for attached audio source.
- Spliced AUX wire aesthetics. 

Current Progress | Goals
--- | ---
✔ | AUX audio in
🗴 | Standalone from CD changer
🗴 | Reliable connection
🗴 | **Next/Previous** and **Fast Forward/Rewind** functionality
🗴 | Aesthetics

Unsatisfied, I looked to create a more integrated solution for AUX audio and forgot about this for a few months after not finding more resources online. 

In November 2016 I came across [Krysztof Pintscher](http://www.instructables.com/id/Ford-CD-Emulator-Arduino-Mega/) and [Dale Thomas](http://www.instructables.com/id/Ford-Bluetooth-Interface-Control-phone-with-stock-/)' projects by chance ⚄. 

## Ford ACP Timeline

- 1994
  - Ford Motor Corporation presents [Ford Audio Communication Protocol (ACP)](http://papers.sae.org/940142/) at SAE International Conference and Exposition. Paper available [here](http://www.mictronics.de/projects/cdc-protocols/#FordACP).
- June 2003
  - Simon J. Fisher creates [acpmon](http://www.mictronics.de/projects/cdc-protocols/#FordACP), an ACP monitor and decoder.
- July 2003
  - Andrew Hammond creates modified yampp-3/usb firmware meant for Ford 4/5/6000 series CD Changer head unit.
  - The firmware allows the head unit and steering column controls to be used to control Yampp and Yampp audio to be played through the head unit.
- September 2008
  - sorban creates [iPod remote control](http://ipod-remote.blogspot.com) with external display that interfaces with Ford CD6000 head unit.
- Dcember 2013
  - Krysztof Pintscher ports Andrew Hammond's Yampp code to run on Arduino Mega 2560. [Instructable](http://www.instructables.com/id/Ford-CD-Emulator-Arduino-Mega/)
- November 2014
  - Dale Thomas adds AT Command integration for Bluetooth Audio support using OVC3868. [Instructable](http://www.instructables.com/id/Ford-Bluetooth-Interface-Control-phone-with-stock-/)
  - AT Command integration sends head unit controls to connected Bluetooth device.
- 2017
  - Anson Liu finally does something???
  
## AUX Audio version 2 - Emulating the CD Changer with Arduino

Krysztof and Dales' code was made for the Arduino Mega 2560. The code would need to be modified to compile on an Arduino UNO I had. Refactoring Krysztof and Dales' code required replacing the constants in `ACP.ino` to be the correct pins on the Arduino UNO. 

<figure>
<img alt="AUX2" data-src="{{ '/wp-content/uploads/2017/07/aux_2.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>A soldering warm up project.</figcaption>
</figure>

By May 2017, I had gathered up the needed parts and modified Dale Thomas's code to compile on Arduino UNO. The most significant steps were

- [Setting Up Serial](#setting-up-serial)
- [Setting Up TX_ENABLE Pin](#setting-up-tx_enable-pin)

### Setting Up Serial

Arduino Mega 2560 serial ports
- `Serial`
- `Serial1`
- `Serial2`
- `Serial3`

Arduino UNO serial ports
- `Serial`

The ACP code for Arduino Mega 2560 uses the port `Serial1` to communicate over RS485 for the Ford ACP protocol. 

As seen, `Serial` must be used on the Arduino UNO. Constants for `Serial1` – the **"1st"** Serial – must be replaced with `Serial` – the **"0th"** Serial. For example: `RXEN1` → `RXEN0`.

`Serial` port is also used by Arduino for communicating with the computer via USB. 
- **0 (RX)** and **1 (TX)** pins are connected to the microcontroller through a pair of 1K Ω resistors. 
- **USB logic (D+/D-)** pins are connected to the microcontroller through a pair of 22 Ω resistors. 

As a result, when the both **USB logic** and **RX/TX** pins are connected, the USB serial connection takes precedence. 

### Setting Up TX_ENABLE Pin

The ACP code for Arduino Mega 2560 uses a digital pin to control **TX_ENABLE** on the **TTL to RS485** module. 
```
PORTA |= (1<<PA6); //set high state on digital pin 28
PORTA &= ~(1<<PA6); //set low state on digital pin 28
```
<figure>
<img alt="ATMega2560 Arduino pin mapping" data-src="{{ '/wp-content/uploads/2017/07/atmega2560_pin_mapping.png' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>ATMega 2560 Arduino pin mapping</figcaption>
</figure>

The pin is addressed by constants that rely on the Arduino Mega's [ATmega2560 pin mapping](https://www.arduino.cc/en/Hacking/PinMapping2560). 

The first line sets pin 28 on the ATmega2560 to a high state. 
- `(1<<PA6)` returns the result of the value binary `00000000` with `1` bit shifted to the left `PA6` times. Constant `PA6` equals `6`. Returned value binary is `01000000` (value decimal`64`).
- `PORTA |= ` sets the `PORTA` variable to the result of a bitwise OR operation between `PORTA` and `(1<<PA6)`. We know `(1<<PA6)` is `01000000` in binary. The result is PORTA with the bits in `01000000` set to `1` set to `1`.

#### Chart for `PORTA |= (1<<PA6)`

Variable | Binary value
--- | ---
PORTA | 00000000
 | &
(1<<PA6) | 01000000
Result (PORTA) | 01000000

The second line sets a low state by performing bitwise AND operation on `PORTA` with an "opposite" NOT value of `(1<<PA6)`.

`PORTA` and `PA6` constants must be updated to reference a valid pin on the Arduino UNO. 

<figure>
<img alt="ATMega168/328 Arduino pin mapping" data-src="{{ '/wp-content/uploads/2017/07/atmega168-328_pin_mapping.png' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>ATMega168/328 Arduino pin mapping</figcaption>
</figure>

I choose to use **digital pin 7** on the UNO to control **TX_ENABLE**. Locating **digital pin 7** on the [UNO ATmega328 pin mapping](https://www.arduino.cc/en/Hacking/PinMapping168) shows it as chip pin `PD7`. The `D` in `PD7` indicates `PORTD` of the ATmega328 chip.

Original | New
--- | ---
PORTA | PORTD
PA6 | PD7

Replace the constants.

### Breadboard the Project

I breadboarded the circuit according to Dale Thomas's schematic. I ignored the LCD and Bluetooth module at this step. You may need two breadboards to accomodate the rectangular **TTL to RS485** module.

***IMPORTANT:** Of note is that the capacitor polarity directions for the **LM7805 voltage regulator** shown on the schematic are incorrect and the **negative** end of the capacitors should be connected to ground.

Progress | Goals
--- | ---
✔ | AUX audio in
✔ | Standalone from CD changer
🗴 | Reliable connection
🗴 | Head unit controlled **Next/Previous** and **Fast Forward/Rewind** functionality
🗴 | Aesthetics

### Protoboard the Project

I prototyped the board on a clone protoshield based off the [Adafruit Proto Shield v.5](https://www.adafruit.com/product/51). 

<figure>
<img alt="AUX3" data-src="{{ '/wp-content/uploads/2017/07/aux_3.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>The finished protoboard.</figcaption>
</figure>

I used an [shield fabrication print](https://learn.adafruit.com/adafruit-proto-shield-arduino/download) for planning wiring. To prepare the file for acceptable printing, I reversed the colors and increased the contrast. This results in a white background and darker colored circuit board pads – good for drawing on a piece of paper.

##### Inverted protoshield schematic for printing

<img alt="Inverted protoshield schematic for printing" data-src="{{ '/wp-content/uploads/2017/07/adafruit_protoshield_v6_inverted.png' | prepend:site.baseurl }}" class="lazyload" />

My protoshield wiring

<img alt="LIU ACP only protoshield wiring diagram" data-src="{{ '/wp-content/uploads/2017/07/liu_acp_aux_uno_protoshield_diagram.png' | prepend:site.baseurl }}" class="lazyload" />

The finished protoshield

<img alt="LIU ACP only protoshield wiring top side" data-src="{{ '/wp-content/uploads/2017/07/liu_acp_aux_uno_protoshield_side.jpg' | prepend:site.baseurl }}" class="lazyload" />
<img alt="LIU ACP only protoshield wiring bottom" data-src="{{ '/wp-content/uploads/2017/07/liu_acp_aux_uno_protoshield_bottom.jpg' | prepend:site.baseurl }}" class="lazyload" />
<img alt="LIU ACP only protoshield wiring connected" data-src="{{ '/wp-content/uploads/2017/07/liu_acp_aux_uno_protoshield_connected.jpg' | prepend:site.baseurl }}" class="lazyload" />

Progress | Goals
--- | ---
✔ | AUX audio in
✔ | Standalone from CD changer
✔ | Aesthetics

So this looked like the end. I had completed the goal of adding a standalone AUX audio in capability that did not require the original CD changer to operate. 

The setup plugged into the CD changer connector under the front passenger seat. It was out mostly out of sight but still reachable for kicking by a someone in the backseat. 

## AUX Audio version 3 - Adding head unit playback control

All the other ACP projects implemented some sort of **"control"** functionality and my project hadn't added much value. Everything I had done was remove capabilities from the other projects and fit a smaller form factor (Mega → UNO). Functionally, I hadn't achieved more than the wire splicing of **AUX Audio version 1**. 

Additionally, I wanted to add playback control without needing Bluetooth. 

### Inline Playback Control

Many Apple and third party headphones have an inline remote control containing three buttons with intended functionalities:

1. Play/Pause & Next/Previous & Fast Forward/Rewind
2. Volume Up
3. Volume Down

In a standard stereo headphone with three connectors of *Tip Ring Sleeve (TRS)*, 2 channels of sound are transmitted.

Pins | Function
--- | ---
Tip | Left audio
Ring | Right audio
Sleeve | Ground

<figure>
<img alt="Cable Chick TRRS diagram" data-src="http://www.cablechick.com.au/resources/image/trrs-diagram2.jpg" class="lazyload" />
  <figcaption>TS, TRS, TRRS from <a href="http://www.cablechick.com.au/resources/image/trrs-diagram2.jpg">Cable Chick</a></figcaption>
</figure>

Vendors' solution to transmitting a third channel of data (ex: microphone/playback control) was to add a second ring to the connector, forming the *Tip Ring Ring Sleeve (TRRS)* connector. 

The inline remote control headphones mentioned earlier connect to the audio source via a *TRRS* connector. iOS and recent (2012 and later) Android devices utilize the CTIA pinout for *TRRS*.

Pins | Function
--- | ---
Tip | Left audio
Ring1 | Right audio
Ring2 | Ground
Sleeve | Microphone

The **Ring2** is simply cut out from the previous *TRS* **Sleeve** length so compatibility is preserved between *TRS* and *TRRS*. 

*There is also the alternative OMTP TRRS pinout that swaps the Ring2 and Sleeve functionality so that Sleeve is Ground. The OMTP pinout was initially used by Nokia and early Android devices.*

Cable Chick's *[Understanding TRRS and Audio Jacks](http://www.cablechick.com.au/blog/understanding-trrs-and-audio-jacks/)* is a good explanation of TRRS audio jacks with pictures.

> How can we duplicate these inline control capabilities for programmatically triggered remote control?

#### Android Inline Control

The Android convention for playback control is pretty simple. Pressing the playback control buttons connects the **Ring2** and **Sleeve** lines with varying resistances. 

Playback Control | Resistance *(**Ring2**-**Sleeve**)*
--- | ---
Play/Pause | 0 Ω
Next Track | ~ 600 Ω
Previous Track | ~ 220 Ω

As you can see, Android playback control would be easy to implement if you do use an Android regularly. For reference, Rich Kappemeier created a [custom remote control](http://www.wisebread.com/build-a-cable-to-control-your-android-phone-while-you-drive) in 2010 for his Android. I choose not to implement controls for Android because I do not own a newer Android device. 

#### Apple Inline Control

The Apple convention for track control is also simple on paper. Pressing the center headset button shorts the **Ring2** and **Sleeve** lines. Shorting at specific intervals represents different commands. In David Carne's [Reverse Engineering the iPod Shuffle 3G headphone remote protocol](http://david.carne.ca/shuffle_hax/shuffle_remote.html), David lists the **Volume Up/Down** control buttons as inducing voltage drop between **Ring2** and **Sleeve**. 

Playback Control | Resistance (**Ring2**-**Sleeve**) | Number of Presses
--- | ---
Play/Pause/Answer Call/Hang Up Call/Switch to New Call | 0 Ω | 1
Next Track | 0 Ω | 2
Previous Track | 0 Ω | 3
Fast Forward | 0 Ω | 2 (Long last press for duration of fast foward.)
Rewind | 0 Ω | 3 (Long last press for duration of rewind.)
Send to Voicemail/Hang Up 2nd Call/Siri | 0 Ω | 1 (Long press)
Volume Up | ~ 4.7k Ω | 1
Volume Down | ~ 10k Ω | 1

##### Mystery Control Chip

David Carne analyzed the initial connection "chirp" that the Apple headset control chip produces in his [post](http://david.carne.ca/shuffle_hax/shuffle_remote.html). This "chirp" is required for the iOS device to begin accepting inline remote commands. The chirp took David a microcontroller and a small circuit to reproduce. I did not want to spend to much time on getting the "chirp" to work at this stage and was more interested in getting the entire inline control project working. 

Apparently all the no-name manufacturers have created a working clone control chip to emulate the genuine Apple control chip but I wasn't able to find any information on obtaining *just* the control chip. I ended up cheating by adding an additional audio port for a headset with the chip. I was able to order some headsets with inline control chip for under $2 on Ebay/dollar store.

As the control chip "chirp" only occurs when the audio jack is first plugged into the iOS device, I modified my setup to have a separate TRRS audio jack just for the dongle with the control chip. This jack was connected by only **Ring2** and **Sleeve** to another jack containing the actual *TRRS* cable to the iOS device. 

To simulate a button press, I initially tried using a *2N2222* transistor to short **Ring2** and **Sleeve**. For some reason the transistor did not short the two lines. Perhaps not enough current produced by the iPhone audio jack? After some more testing I was able to achieve a button press by using a reed relay. I only choose a reed relay at the time because I had on hand from a Radioshack closing sale — the reed relay was a good choice as will be explained later. 

I did not emulate the volume up and down buttons as there was no need for those controls in this use case. The ACP protocol is not known to transmit volume control signals.

<img alt="AUX3.5" data-src="{{ '/wp-content/uploads/2017/07/aux_3-5.jpg' | prepend:site.baseurl }}" class="lazyload" />

Because I did not design my first CD changer emulating protoboard with this in mind, I added yet another TRRS audio jack to this second protoboard to pipe the audio from the iOS device to the first shield. If you plan on hand wiring a protoboard, this can be easily avoied by having upward facing female pin headers on the bottom shield connect with bottom facing male pin headers on the top shield!

### Inline Control Timing

After setting up my protoboard, I modified my previous Arduino program to execute the appropriate button press sequence upon receiving playback commands from the audio navigation system head unit. 

Some testing revealed that iPhone SE is able to interpret a button press interval a small as 60 ms and that the interval must be under 200 ms to qualify for adjacent button presses to be considered part of the same sequence. I choose to use a round value of 100 ms in the program. 

Back to the why a reed relay was a good choice. If I had used a larger electromagnetic relay - one with a spring and arm, depending on which relay I choose, the relay might not have had a fast enough switching speed to switch every 1/10 s.

Progress | Goals
--- | ---
✔ | Head unit controlled **Next/Previous** and **Fast Forward/Rewind** functionality

<img alt="AUX3.5 side by side" data-src="{{ '/wp-content/uploads/2017/07/aux_3-5_side_side.jpg' | prepend:site.baseurl }}" class="lazyload" />

I got playback control functionality at the cost of aesthetics due to inefficient wiring — in retrospect. But hey, everything was put together and working! I had an external audio AUX input for my vehicle and **could control my iPhone from the head unit**. 

The iPod Shuffle, iPod Classic, and laptops also support headset controls and could be used in theory.

## AUX Audio version 4 - Pulling It All Together \[on PCB\]

What improvements could be made? I could rearrange my hand wired layout, but was getting tired of hand wiring protoboards. There were also some physical limitations to how intricately I could hand route wires. 

### Learning EAGLE

I learned how to use Autodesk EAGLE for printed circuit board (PCB) design using the following resources in order. Going through all three should take about 2 hours. 

1. [KTOWN's Ultimate Creating Parts in Eagle Tutorial](https://learn.adafruit.com/ktowns-ultimate-creating-parts-in-eagle-tutorial?view=all)
2. [SparkFun - Using EAGLE: Schematic](https://learn.sparkfun.com/tutorials/using-eagle-schematic)
3. [SparkFun - Using EAGLE: Board Layout](https://learn.sparkfun.com/tutorials/using-eagle-board-layout)

### PCB Fabrication

I used [OSHPark](https://oshpark.com/) for my first two prototype PCB orders. I ordered the minimum 3 PCBs —
good for when mistakes are made. 

*Make sure to verify that your board pads' drill sizes are large enough! EAGLE's default pad drill size was too narrow.*

### Vehicle Wiring

<img alt="040 Multilock Connectors" data-src="{{ '/wp-content/uploads/2017/07/multilock_connectors.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>Some 040 Multilock Connectors</figcaption>

In the meantime, I experimented with hiding my existing protoboard inside the body of the car by removing the head unit and plugging my protoboard directly into the head unit. 

<img alt="Head unit connections" data-src="{{ '/wp-content/uploads/2017/07/head_unit_back.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>Ford Escape navigation head unit connections.</figcaption>

<img alt="Head unit ACP" data-src="{{ '/wp-content/uploads/2017/07/acp_connection_back.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>12 position ACP connector - the one you want to use.</figcaption>

> It works. But nothing happens when I press the fuel economy and energy flow buttons on the head unit!

As it turns out, the vehicle contains a CAN-ACP convertor module located on the right side of the body compartment behind the glovebox. This module sends energy flow information (MPG, battery charge, etc) to the nav unit to be displayed to the user. 

<img alt="CAN ACP Module" data-src="{{ '/wp-content/uploads/2017/07/can_acp_bus.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>The Mystery CAN to ACP module</figcaption>

In order to place the protoboard behind the head unit, I needed to create a three 040 Multilock Connector headed cable that connected the head unit, CAN-ACP convertor, and CD changer (or CD changer emulator). The cable would consist of:

Quantity | Type | Manufacturer Number
--- | --- | ---
2 | Male Connector| [TE 174045-2](http://www.te.com/usa-en/product-174045-2.html)
1 | Female Connector | [TE 174058-2](http://www.te.com/usa-en/product-174058-2.html)
24 | Receptacle Contact | [TE 175180-1](http://www.te.com/usa-en/product-175180-1.html)
12 | Tab Contact | [TE 173682-1](http://www.te.com/usa-en/product-173682-1.html)

The female connector listed above is a **Wire-to-Wire** connector. The tab contacts are crimped and slid into the connector. 
We used a **Wire-to-Board** female 040 Multilock Connector ([TE 174051-2](http://www.te.com/usa-en/product-174051-2.html)) for the protoboard. The **Wire-to-Board** has pins that fit into the circuit board. This connection is less bendable when squeezed behind the head unit and was difficult to solder and make solder bridges. The **Wire-to-Wire** connector is better suited to creating our three headed extension. 

#### To the access the back of the Ford Escape head unit:

1. Pop out the silver bezel. You can use a flathead screwdriver to do so.
2. Use double DIN removal tools or wire to pull out the head unit. 
  - If the tools do not work for you, the plastic side wall holding the head unit can be conveniently drilled through to provide access to the clips holding the head unit.
  - Any drilled holes will be covered up by replacing the silver bezel.


Progress | Goals
--- | ---
✔ | Reliable connection

<img alt="Center console location" data-src="{{ '/wp-content/uploads/2017/07/center_console_location.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>Beneath the center console - one of many possible locations to place the system.</figcaption>


### PCB Arrives (2 weeks later)

<img alt="Yay" data-src="{{ '/wp-content/uploads/2017/07/cheering_nascar.gif' | prepend:site.baseurl }}" class="lazyload" />

<img alt="AUX4" data-src="{{ '/wp-content/uploads/2017/07/aux_4.jpg' | prepend:site.baseurl }}" class="lazyload" />

It works and doesn't disappoint. 

<img alt="AUX4 before after top" data-src="{{ '/wp-content/uploads/2017/07/aux_4_before_after_top.jpg' | prepend:site.baseurl }}" class="lazyload" />
<img alt="AUX4 before after side" data-src="{{ '/wp-content/uploads/2017/07/aux_4_before_after_side.jpg' | prepend:site.baseurl }}" class="lazyload" />

<a href="{{ '/wp-content/uploads/2017/07/inline_control_acp_aux_schematic.png' | prepend:site.baseurl }}"><img alt="Inline control schematic" data-src="{{ '/wp-content/uploads/2017/07/inline_control_acp_aux_schematic.png' | prepend:site.baseurl }}" class="lazyload" /></a>

<img alt="AUX3.5 and AUX4" data-src="{{ '/wp-content/uploads/2017/07/aux_3-5_aux_4.jpg' | prepend:site.baseurl }}" class="lazyload" />

As you may have noticed, I was able to fit both CD changer emulation and playback control functionality on a single Arduino UNO size shield. 

Progress | Goals
--- | ---
✔ | AUX audio in
✔ | Standalone from CD changer
✔ | Reliable connection
✔ | Head unit controlled **Next/Previous** and **Fast Forward/Rewind** functionality
✔ | Aesthetics

I made the wiring mistake of placing the ACP activity indicator LED in series instead of parallel 
(across ACP A and ACP B lines). The LED in series dropped the voltage below the **TTL to RS485** module "high" logic level. A quick fix was to bypass the resistor and indicator LED with a wire and solder bridge. I fixed this mistake in a second PCB order with [Seeed Studio Fusion PCB](https://www.seeedstudio.com/fusion_pcb.html). At the time of writing, Seeed Studio gives $5 coupon to first time customers with a Fusion PCB order in their cart for a few hours. 

1. Place Fusion PCB order in your cart.
2. Do not proceed immediately to checkout.
3. Wait a day for the coupon to appear on your account. 
4. Proceed to checkout and apply coupon within 2 days.

<img alt="AUX5" data-src="{{ '/wp-content/uploads/2017/07/aux_5.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>Revised PCB from Seeed</figcaption>

<img alt="AUX5 top" data-src="{{ '/wp-content/uploads/2017/07/aux_5_inline_top.jpg' | prepend:site.baseurl }}" class="lazyload" />

<img alt="AUX5 side" data-src="{{ '/wp-content/uploads/2017/07/aux_5_inline_side.jpg' | prepend:site.baseurl }}" class="lazyload" />

<img alt="AUX5 pcb before soldering" data-src="{{ '/wp-content/uploads/2017/07/aux_5_before.jpg' | prepend:site.baseurl }}" class="lazyload" />

## Finishing Up

Last thing to do is to plug the finished assembly [behind the head unit](#vehicle-wiring) in a secure position within the Ford Escape.

<img alt="TRRS Audio jack bezel" data-src="{{ '/wp-content/uploads/2017/07/audio_jack_bezel.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>I drilled a hole in the bezel to fit a TRRS jack.</figcaption>

A year after first [splicing the audio cable into the CD connector]({{ site.baseurl }}/2016/07/ford-escape-audio-aux-input/), I now have a fully integrated AUX audio system that lets me use the original radio head unit controls to control playback on iPhone.

> I want this for my Ford XXX but don't want to order 10 boards. 

You're in luck, the Seeed Studio order came in a 10 pack so I have a couple boards to spare - I only have one car after all. [Send me an email](mailto:anson@ansonliu.com) and we can talk.

### Credits

Thanks to the work of those below. Their contributions have made this project possible:

- Simon J. Fisher - [acpmon](http://www.mictronics.de/projects/cdc-protocols/#FordACP)
- Andrew Hammond - [yampp-3/usb firmware](http://www.mictronics.de/projects/cdc-protocols/#FordACP)
- sorban - [iPod remote control](http://ipod-remote.blogspot.com)
- Krysztof Pintscher - [Yampp → Arduino Mega 2560](http://www.instructables.com/id/Ford-CD-Emulator-Arduino-Mega/)
- Dale Thomas - [Bluetooth Audio support](http://www.instructables.com/id/Ford-Bluetooth-Interface-Control-phone-with-stock-/)

### To be continued?

Bookmark and check back soon for a future post on wiring up your remote key fob for Bluetooth Low Energy vehicle security control.

<img alt="AUX5.5 stacked" data-src="{{ '/wp-content/uploads/2017/07/aux_5-5_stacked.jpg' | prepend:site.baseurl }}" class="lazyload" />
<figcaption>BLE control to come in a future post.</figcaption>
