---
published: true
title: SUNLU T3 Fast Print Analyzed
author: Anson Liu
layout: post
categories:
  - 3dprinting
tags:
  - sunlu t3
  - fast print
excerpt: >
  What does Fast Print on the SUNLU T3 3D printer actually do?


  ![Fast print menu](/wp-content/uploads/2023/02/fast_print_menu.jpg)


  After looking through the released T3 source code, Fast Print appears to be an acceleration modifier that SUNLU had future development planned.
---

What does Fast print do?

![Fast print menu](/wp-content/uploads/2023/02/fast_print_menu.jpg)

The SUNLU T3 3D printer comes with a Fast Print mode that claims to speed up printing by 3x and deliver 250mm/s print speed. There is no explanation from the manufacturer what Fast Print actually changes to deliver faster print times. We can check in the released [SUNLU T3 source code](http://3dsunlu.com/Content/2169603.html). The T3 firmware is a variant of Marlin firmware which is licensed under GPL and SUNLU's release of their changes to Marlin complies with GPL which is great!


![SUNLU T3 printer](/wp-content/uploads/2023/02/sunlu_t3_printer.jpg)

### Finding the code

By browsing the printer menu displayed on the LCD, we can read the Fast Print mode displayed as "Fast Print". Search the human readable string "fast print" inside the T3 `Marlin` source code folder to find the below definition of `MSG_PRINT_CONFIG` set to the localized English string `"Fast Print"` in `language_en.h`.

```cpp
PROGMEM Language_Str MSG_PRINT_CONFIG = _UxGT("Fast Print");
```
It's surprising that SUNLU used the variable name `MSG_PRINT_CONFIG` instead of something more descriptive like `MSG_FAST_PRINT`. We find that `MSG_PRINT_CONFIG` is referenced within `menu_main()` loop in the file `menu_main.cpp` in the below code block .


```cpp
void menu_main() {
  ...
  #if ENABLED(LCD_INFO_MENU)
      SUBMENU(MSG_INFO_MENU, menu_info);
  #ifndef Internal_Version   
      EDIT_ITEM(bool, MSG_PRINT_CONFIG, &fast_print_enable);
  #endif
      if(fast_print_enable){
      if(fast_print_enable^fast_print_enable_pre)
      {
          planner.settings.acceleration=800;
          planner.settings.max_acceleration_mm_per_s2[X_AXIS]=planner.settings.max_acceleration_mm_per_s2[Y_AXIS]=planner.settings.max_acceleration_mm_per_s2[Z_AXIS]=1500;
          planner.settings.max_acceleration_mm_per_s2[E_AXIS] = 2000;
          planner.settings.retract_acceleration = 1000;
          planner.settings.travel_acceleration =  1000;
        fast_print_enable_change=true;
      //do{ Serial.print("mmmcurrent_position.e:"); Serial.println(current_position.e); }while(0);
      }//
      
      //	
      }
      else{
      if(fast_print_enable^fast_print_enable_pre)
      {
        planner.settings.acceleration=acceleration_Back;
        fast_print_enable_change=true;
      //do{ Serial.print("mmm1current_position.e:"); Serial.println(current_position.e); }while(0);
      }
    //	  
      }
    fast_print_enable_pre=fast_print_enable;
  #endif
  ...
}
```

We can clean the code up to be more readable below

```cpp
void menu_main() {
  ...
  #if ENABLED(LCD_INFO_MENU)
    SUBMENU(MSG_INFO_MENU, menu_info);
    #ifndef Internal_Version   
      EDIT_ITEM(bool, MSG_PRINT_CONFIG, &fast_print_enable);
    #endif
    if (fast_print_enable) {
      if (!fast_print_enable_pre) {
        planner.settings.acceleration=800;
        planner.settings.max_acceleration_mm_per_s2[X_AXIS]=planner.settings.max_acceleration_mm_per_s2[Y_AXIS]=planner.settings.max_acceleration_mm_per_s2[Z_AXIS]=1500;
        planner.settings.max_acceleration_mm_per_s2[E_AXIS] = 2000;
        planner.settings.retract_acceleration = 1000;
        planner.settings.travel_acceleration =  1000;
        fast_print_enable_change=true;
      }
    } else {
      if (fast_print_enable_pre) {
        planner.settings.acceleration=acceleration_Back;
        fast_print_enable_change=true;
      } 
    }
    fast_print_enable_pre=fast_print_enable;
  #endif
  ...
}
```

The current state of Fast Print is stored in a global variable named `fast_print_enable` that is declared below in `planner.h`.

```cpp
bool fast_print_enable=false;
```

The Fast Print state variable type, string, and pointer are passed to the `EDIT_ITEM()` macro in `menu_main()`.

The code displays an "Edit Item" under the main menu which displays the localized string for Fast Print mode. The value of `fast_print_enable` is printed on the right side of this menu item.

When the Fast Print Edit Item is clicked by the user, `fast_print_enable` is toggled as part of the Edit Item's `action()` in `menu_item.h` in the snippet below where `ptr` is the pointer to `fast_print_enable`.

```cpp
*ptr ^= true;
```

The XOR operation between `*ptr` and `true` toggles the boolean value at `ptr` address to have the same effect on `fast_print_enable` as below:

```cpp
fast_print_enable = !fast_print_enable;
```

The previous enabled status of Fast Print mode is kept track of to avoid redundant execution of code to enable/disable Fast Print when the menu is redrawn but Fast Print mode status has not changed. When `fast_print_enable` == `fast_print_enable_pre` nothing no additinal operations are executed.

This previous value is stored in `fast_print_enable_pre` at the end of the `main_menu()` loop.

```cpp
//Enable Fast Print mode
planner.settings.acceleration=800;
planner.settings.max_acceleration_mm_per_s2[X_AXIS]=planner.settings.max_acceleration_mm_per_s2[Y_AXIS]=planner.settings.max_acceleration_mm_per_s2[Z_AXIS]=1500;
planner.settings.max_acceleration_mm_per_s2[E_AXIS] = 2000;
planner.settings.retract_acceleration = 1000;
planner.settings.travel_acceleration =  1000;
fast_print_enable_change=true;
```

When Fast Print mode is initially enabled, printer acceleration values are set to high values.

`fast_print_enable_change` set to true seems to serve a similar purpose as `fast_print_enable_pre` as a marker that Fast Print mode has changed but for Fast Print code scattered elsewhere in the code base. 


```cpp
// planner.settings.axis_steps_per_mm[E_AXIS]= pgm_read_float(&_DASU[ALIM(E_AXIS, _DASU)]) * FAST_FEED; // 1.1;
position.e=current_position.e*settings.axis_steps_per_mm[E_AXIS];
//	do{ Serial.print("ffffposition.e:"); Serial.println(position.e); }while(0);
//	do{ Serial.print("ffffcurrent_position.e:"); Serial.println(current_position.e); }while(0);
```

The above is code from an added debug/testing function `Planner::change_e_stepper_mm()` that overwrites an existing `position.e` variable to `current_position.e*settings.axis_steps_per_mm[E_AXIS]` to store the current extruder position in step count. After the calculation are some `Serial.print` statements that should let the developers verify the extruder position in steps. `Planner::change_e_stepper_mm()` is called near the end of `Planner::_populate_block()`. 

`current_position` appears to be used for actual movement positioning and `position` is modified elsewhere for calculations so modifying `position` in `Planner::change_e_stepper_mm()` may not affect the actual printing since this modification is near the end of `Planner::_populate_block()`? I haven't dug into the planner logic so I'm unsure.

```cpp
void PrintJobRecovery::resume() {
  ...
  planner.resume_e_stepper_mm(info.current_position.e);
  do { 
    Serial.print("mmmcurrent_position.e:"); 
    Serial.println(current_position.e); 
  } while(0);
  do{ 
    Serial.print("info.current_position.e.e:"); 
    Serial.println(info.current_position.e); 
  } while(0);
  //sprintf_P(cmd, PSTR("G92.9E%s"), dtostrf(info.current_position.e, 1, 3, str_1));
  //gcode.process_subcommands_now(cmd);
  ...
}
```

There is an equivalent new function `Planner::resume_e_stepper_mm()` that is called by the above code in `PrintJobRecovery::resume()` from `powerloss.cpp` to restore a position. The default Marlin implementation code that restores a position with `G92` G-code command is commented out so the `Planner::resume_e_stepper_mm()` appears to set the software position of extruder like `G92`. I'm not sure why the default Marlin implementation wasn't usedinstead but the `Serial.print()` lines suggest that this change was made for debug logging purposes.


```cpp
//Disable Fast Print mode
planner.settings.acceleration=acceleration_Back;
fast_print_enable_change=true;
```

When Fast Print mode is disabled, only the printing acceleration value is reset. The axis maximum, retract, and travel accelerations do not seem to be reset.

fast_print_enable_change


```cpp
extern bool fast_print_enable;
static float dis_count = 0.0;
static float dis_count_x = 0.0;
static float dis_count_y = 0.0;
static float dis_count_e = 0.0;
float acceleration_Back = 0.0;
static float free_speed_back = 35.0;

void Adjust_Print_Speed() {
  #if 1
  if (!fast_print_enable) return;

  static bool readly_into_wallout = true;

  if (destination[Z_AXIS] < 0.5) {
    acceleration_Back = planner.settings.acceleration = 800; //1000;//800;
    free_speed_back = feedrate_mm_s = 30; //60;//70;//35;

    planner.settings.max_acceleration_mm_per_s2[X_AXIS] = planner.settings.max_acceleration_mm_per_s2[Y_AXIS] = planner.settings.max_acceleration_mm_per_s2[Z_AXIS] = 1500;
    planner.settings.max_acceleration_mm_per_s2[E_AXIS] = 2000;
    planner.settings.retract_acceleration = 1000;
    planner.settings.travel_acceleration = 1000;
  }

  if (readly_into_wallout && fast_print_enable && strchr(GCodeParser::command_ptr, 'W')) {
    if (destination[Z_AXIS] > 0.5) {
      readly_into_wallout = false;
      dis_count_x = abs(max_point[X_AXIS] - min_point[X_AXIS]);
      dis_count_y = abs(max_point[Y_AXIS] - min_point[Y_AXIS]);
      dis_count = dis_count_x > dis_count_y ? dis_count_x : dis_count_y;

      if (dis_count < 11) {
        acceleration_Back = planner.settings.acceleration = 1000; //800;
        free_speed_back = feedrate_mm_s = 15 + 10; //20;//10;
      } else if (dis_count < 16) {
        acceleration_Back = planner.settings.acceleration = 1000; //800;
        free_speed_back = feedrate_mm_s = 20 + 10; //24;//12;
      } else if (dis_count < 21) {
        acceleration_Back = planner.settings.acceleration = 1000; //800;
        free_speed_back = feedrate_mm_s = 28 + 10; //32;//16;
      } else if (dis_count < 50) {
        acceleration_Back = planner.settings.acceleration = 1000; //800;
        free_speed_back = feedrate_mm_s = 70 + 10; //86;//43;
      } else {
        acceleration_Back = planner.settings.acceleration = 1400; //1200;
        free_speed_back = feedrate_mm_s = 70 + 10; //90;//45;
      }
      max_point[Y_AXIS] = max_point[X_AXIS] = -999.0;
      min_point[Y_AXIS] = min_point[X_AXIS] = 999.0;
    }
  } else if (!readly_into_wallout && fast_print_enable && strchr(GCodeParser::command_ptr, 'Q')) {
    if (destination[Z_AXIS] > 0.5) {
      readly_into_wallout = true;
      acceleration_Back = planner.settings.acceleration = 1000; //800;
      free_speed_back = feedrate_mm_s = 180 + 10; //230;//115;
    }
  }

  if (!readly_into_wallout) {
    max_point[Y_AXIS] = max_point[Y_AXIS] > destination[Y_AXIS] ? max_point[Y_AXIS] : destination[Y_AXIS];
    max_point[X_AXIS] = max_point[X_AXIS] > destination[X_AXIS] ? max_point[X_AXIS] : destination[X_AXIS];
    min_point[Y_AXIS] = min_point[Y_AXIS] < destination[Y_AXIS] ? min_point[Y_AXIS] : destination[Y_AXIS];
    min_point[X_AXIS] = min_point[X_AXIS] < destination[X_AXIS] ? min_point[X_AXIS] : destination[X_AXIS];
  }
  
  #endif
}
```

When running printing Gcode movements like G0/G1, a new function `Adjust_Print_Speed()` has some disabled code that increases acceleration and feedrate based on the Z height. The code seemed to be disabled because it is only run when the Gcode command is a `W` or `Q` letter command - none of which are generated by any FDM slicer that I know of. SUNLU distributes a copy of Cura with their printer profiles built in but it does not generate Gcode with W and Q commands. The disabled code and macros like `Internal_Version` and `HEAT_PIPES_60_W` scattered around suggest that SUNLU was developing an adaptive Fast Print mode and experimenting with a higher powered heater.

I didn't see any setting of velocity to 250mm/s despite the mention of 250mm/s print speeds in SUNLU's Fast Print marketing image.

![Fast print menu](/wp-content/uploads/2023/02/t3_fast_print_promo.jpg)

Fast Print mode's acceleration values look similar to the high end of user reported accleration values in fast Ender 3 V2 printer settings found [online](https://3dprinterly.com/how-to-get-the-perfect-jerk-acceleration-setting/). Which makes sense - the T3 is an Ender 3 V2 clone after all. 

Without spending more time analyzing every custom code that SUNLU has added to the T3 version of Marlin firmware, Fast Print mode is a straight forward accleration increase feature that 3D printer users can replicate on their own without using SUNLU's variant of Marlin.

In future when I have access to the actual T3 printer currently stored in another location, I'll create a Marlin configuration for it based on the current Marlin code branch. This will allow the printer to take advantage of newer features like Linear Advance, S curve, and Input Shaping as well as fixing some bugs in the T3 firmware (ex: not properly stopping an SD print over the serial connection).