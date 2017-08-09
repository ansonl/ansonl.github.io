---
published: false
---
---
title: Making the Ford AUX Audio Expansion w/ Inline Control
author: Anson L
layout: post
categories:
  - Vehicle
tags:
  - ford escape
  - acp
  - cd changer
  - aux
---

## Backstory

Last July I added an AUX audio input to a recently acquired 2007 Ford Escape Hybrid. The reasons for adding an AUX audio input were:

- No built in AUX audio input.
- Expensive (>$50) third [party](http://www.ycarlink.com/pd_12391_Digital-CD-USB-SD-AUX-Bluetooth-changer-emulator-adapter-for-new-Ford-quadlock-Fakra-12-pin-6000CD-6006CDC-5000C.htm) [accessories](http://www.discountcarstereo.com/AUX-FRDW.html) that emulated the CD changer to add AUX audio capability. 

## AUX Audio version 1 - Splicing audio wires

At the time, I found the correct CD changer connector pin out from a [Taurus Car Club Forum post](https://web.archive.org/web/20151102133458/http://www.taurusclub.com/forum/attachments/electronics-security-audio-visual/34387d1106003765-cd-changer-interface-cdchanger_pinout.jpg). I stripped a normal Tip Ring Sleeve (TRS) audio jack cable to expose the three wires within: Left, Right, Ground. These wires were then connected to their respective pins in the CD changer connector. The result was an operational CD changer and a spliced in AUX audio jack for a phone. 

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

In November 2016 I came across [Krysztof Pintscher](http://www.instructables.com/id/Ford-CD-Emulator-Arduino-Mega/) and [Dale Thomas](http://www.instructables.com/id/Ford-Bluetooth-Interface-Control-phone-with-stock-/)' projects by chance. 

## Ford ACP Timeline

- 1994
  - Ford Motor Corporation presents [Ford Audio Communication Protocol (ACP)](http://papers.sae.org/940142/) at SAE International Conference and Exposition. Paper available [here](http://www.mictronics.de/projects/cdc-protocols/#FordACP).
- June 2003
  - Simon J. Fisher creates [acpmon](http://www.mictronics.de/projects/cdc-protocols/#FordACP), an ACP monitor and decoder.
- July 2003
  - Andrew Hammond creates modified yampp-3/usb firmware meant for Ford 4/5/6000 series CD Changer head unit.
  - The firmware allows the head unit and steering column controls to be used to control Yampp and Yampp audio to be played through the head unit.
- September 2008
  - sorban creates iPod remote control with external display that interfaces with Ford CD6000 head unit.
- Dcember 2013
  - Krysztof Pintscher ports Andrew Hammond's Yampp code to run on Arduino Mega 2560.
- November 2014
  - Dale Thomas adds AT Command integration for Bluetooth Audio support using OVC3868.
  - AT Command integration sends head unit controls to connected Bluetooth device.
  
## AUX Audio version 2 - Emulating the CD Changer with Arduino

Krysztof and Dales' code was made for the Arduino Mega 2560. The code would need to be modified to compile on an Arduino UNO I had. Refactoring Krysztof and Dales' code required replacing the constants in `ACP.ino` to be the correct pins on the Arduino UNO. 

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
![ATMega2560 Arduino pin mapping]({{ site.baseurl }}/wp-content/uploads/2017/07/atmega2560_pin_mapping.png)

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

![ATMega168/328 Arduino pin mapping]({{ site.baseurl }}/wp-content/uploads/2017/07/atmega168-328_pin_mapping.png)

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

I used an [shield fabrication print](https://learn.adafruit.com/adafruit-proto-shield-arduino/download) for planning wiring. To prepare the file for acceptable printing, I reversed the colors and increased the contrast. This results in a white background and darker colored circuit board pads – good for drawing on a piece of paper.

##### Inverted protoshield schematic for printing

![Inverted protoshield schematic for printing]({{ site.baseurl }}/wp-content/uploads/2017/07/adafruit_protoshield_v6_inverted.png)

My protoshield wiring

![LIU ACP only protoshield wiring diagram]({{ site.baseurl }}/wp-content/uploads/2017/07/liu_acp_aux_uno_protoshield_diagram.png)

The finished protoshield

![LIU ACP only protoshield wiring top side]({{ site.baseurl }}/wp-content/uploads/2017/07/liu_acp_aux_uno_protoshield_side.png)
![LIU ACP only protoshield wiring bottom]({{ site.baseurl }}/wp-content/uploads/2017/07/liu_acp_aux_uno_protoshield_bottom.png)
![LIU ACP only protoshield wiring connected]({{ site.baseurl }}/wp-content/uploads/2017/07/liu_acp_aux_uno_protoshield_connected.png)

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

David Carne analyzed the initial connection "chirp" that the Apple headset control chip produces in his [post](http://david.carne.ca/shuffle_hax/shuffle_remote.html). This "chirp" is required for the iOS device to begin accepting inline remote commands. The chirp took David a microcontroller and a small circuit to reproduce. I did not want to spend to much time on getting the "chirp" to work at this stage and was more interested in getting the entire inline control project working. 

Apparently all the no-name manufacturers have created a working clone control chip to emulate the genuine Apple control chip. I was able to order some headsets with inline control chip for under $2 on Ebay/dollar store.

As the control chip "chirp" only occurs when the audio jack is first plugged into the iOS device, I modified my setup to have a separate TRRS audio jack just for the dongle with the control chip. This jack was connected by only **Ring2** and **Sleeve** to another jack containing the actual *TRRS* cable to the iOS device. 

To simulate a button press, I initially tried using a *2N2222* transistor to short **Ring2** and **Sleeve**. For some reason the transistor did not short the two lines. Perhaps not enough current produced by the iPhone audio jack? After some more testing I was able to achieve a button press by using a reed relay. I only choose a reed relay at the time because I had on hand from a Radioshack closing sale — the reed relay was a good choice as will be explained later. 

I did not emulate the volume up and down buttons as there was no need for those controls in this use case. The ACP protocol is not known to transmit volume control signals.

Because I did not design my first CD changer emulating protoboard with this in mind, I added yet another TRRS audio jack to this second protoboard to pipe the audio from the iOS device to the first shield. If you plan on hand wiring a protoboard, this can be easily avoied by having upward facing female pin headers on the bottom shield connect with bottom facing male pin headers on the top shield!

### Inline Control Timing

After setting up my protoboard, I modified my previous Arduino program to execute the appropriate button press sequence upon receiving playback commands from the audio navigation system head unit. 

Some testing revealed that iPhone SE is able to interpret a button press interval a small as 60 ms and that the interval must be under 200 ms to qualify for adjacent button presses to be considered part of the same sequence. I choose to use a round value of 100 ms in the program. 

Progress | Goals
--- | ---
✔ | Head unit controlled **Next/Previous** and **Fast Forward/Rewind** functionality

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

In the meantime, I experimented with hiding my existing protoboard inside the body of the car by removing the head unit and plugging my protoboard directly into the head unit. 

It works. But nothing happens when I press the fuel economy and energy flow buttons on the head unit!

As it turns out, the vehicle contains a CAN-ACP convertor module located on the right side of the body compartment behind the glovebox. This module sends energy flow information (MPG, battery charge, etc) to the nav unit to be displayed to the user. 

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


### PCB Arrives (2 weeks later)

![Yay](https://media.giphy.com/media/119HWcqAtGGfJK/giphy.gif)

It works and doesn't disappoint. 

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



Revised PCB from Seeed

## Finishing up


