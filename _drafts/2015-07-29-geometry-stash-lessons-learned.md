---
title: Geometry Stash 2 - Lessons Learned
author: Anson L
layout: post
categories:
  - Development
tags:
  - geometry stash
  - lessons learned
---

<img src="{{ site.baseurl }}/wp-content/uploads/2015/08/geometry-stash-1-logo.png" width="64" align="left" style="padding:15px">Geometry Stash 1.0 was released on July 30th, 2009 during the summer after my high school freshman year. The app has operated the same way these last 6 years. Besides updating the app for the iPad in 2010, the app stayed largely the same through my years in high school. 

<img src="{{ site.baseurl }}/wp-content/uploads/2015/08/geometry-stash-1-xcode-screenshot.png" width="200" align="left" style="padding:15px">

All the geometry descriptions and diagrams were image files that were loaded by filename from the table view. 

In between summer training for the [academy](javascript:alert('United States Naval Academy')) and my last year at the academy, I have been working on Geometry Stash 2. This last summer break is one of the final times that I will be able to work full-time on Geometry Stash before commissioning from the academy in the May 2016. 

There's no way I was going to leave Geometry Stash loading images like it's 2009 and so Geometry Stash 2 came about. I actually first started working on version 2 during the summer of 2013 after my plebe (freshman) year at the academy. 
At that time, I hadn't had any formal computer education - from high school until my youngster (sophomore) year at the academy I was self taught from books. 
<div><img src="{{ site.baseurl }}/wp-content/uploads/2015/08/apress-book.png" width="72" align="left" style="padding:0">I still remember reading <a href="http://www.apress.com/9781430216261?gtmf=c">Beginning iPhone Development</a> by Jeff and David. </div>

My first computer science course was during my sophomore year. I finished my junior year this past semester. I hadn't touched the Geometry Stash 2 that I worked on during freshman summer due to many of the inaccuracies in the code. 

I started over on version 2 this summer and have encountered issues and learned a lot programming the second version of the prodigal geometry reference. 

So...what's new?
------

<img src="{{ site.baseurl }}/wp-content/uploads/2015/08/geometry-stash-2-logo.png" width="256" style="padding:5px;display:block;margin-left:auto;margin-right:auto;">

Descriptions and diagrams in Geometry Stash 2 are contained in files called slides. A slide is a JSON format file containing drawing commands. You can now create and distribute your own slides for Geometry Stash 2. 
The app has other new features such as Guided Access, iCloud Drive, and AirDrop.

iCloud Drive
------

I initially developed Geometry Stash 2 with the mindset that all slides would be stored in the application's local Documents directory. This was simple and worked great and I was actually going to release the app like that. Users could transfer files with [iTunes File Sharing](https://support.apple.com/en-us/HT201301) - remember that feature? 

While preparing the application binary for upload to iTunes, I decided that supporting iCloud would be a good idea for future usability. I personally don't know anyone who connects their device to iTunes and does File Sharing that that. After reading Apple's [iCloud Design Guide](https://developer.apple.com/library/ios/documentation/General/Conceptual/iCloudDesignGuide/Chapters/Introduction.html) I decided that iCloud Document Storage made that most sense for Geometry Stash 2. Each slide is a separate file that the user can manipulate. 

<figure><a href="https://developer.apple.com/library/ios/documentation/General/Conceptual/iCloudDesignGuide/Chapters/DesigningForDocumentsIniCloud.html#//apple_ref/doc/uid/TP40012094-CH2-SW1"><img src="{{ site.baseurl }}/wp-content/uploads/2015/08/file_transfer_v2_2x.png" width="512" style="padding:5px;display:block;margin-left:auto;margin-right:auto;"></a><figcaption>A diagram from iCloud documentation.</figcaption></figure>

Apple introduced the [UIDocument](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIDocument_Class/index.html#//apple_ref/occ/cl/UIDocument) class in iOS 5. UIDocument conforms to NSFilePresenter and employs NSFileCoordinator to make managing iCloud file easier. [NSFileCoordinator](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSFileCoordinator_class/index.html#//apple_ref/occ/cl/NSFileCoordinator) coordinates read and write of files by multiple processes which suites iCloud because a user may have two devices editting the same file. 

Originally I could access local files quickly with the NSFileManager methods. Now I needed to perform filesystem operations through NSFileCoordinator. I wrapped my NSFileManager methods within NSFileCoordinator blocks so that filesystem changes would be correctly coordinated. Geometry Stash 2 slides can specify a custom title for themselves in the main slide list. Everytime the list, a table view, needed to be refreshed the app would read and parse every slide in the Documents directory. Apple's documention recommends reading files into UIDocument instances and then getting data from the UIDocument instance so that NSFileCoordinator can handle the problems of simultaneous access. 
As I found out by creating a UIDocument to read from every slide, UIDocument comes with considerable overhead when dealing with more than 50 files. A table view refresh which took less than 1 second on the local Documents directory using a NSData initialization from file took over 2 seconds with UIDocuments. 

<img src="{{ site.baseurl }}/wp-content/uploads/2015/08/initializing-icloud-alert.png" width="256" align="left" style="padding:10px;">


iCloud methods such as `URLForUbiquityContainerIdentifier` to get the URL to an iCloud container are slow compared to `NSSearchPathForDirectoriesInDomains` method to retreive the local Documents URL path. Apple's [Grand Central Dispatch](https://developer.apple.com/library/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/) came in handy for performing iCloud operations asyncronously. Due to Geometry Stash's design, I used [NSNotification](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSNotification_Class/)s to signal the end of asyncronous operations between classes rather than pass the sender instance to the method being called. 

For example, the first time Geometry Stash 2 needs iCloud each run, I display a UIAlertView/Controller to the user with no buttons indicating that the device is waiting for iCloud to return a list of files in the container from a [NSMetadataQuery](https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSMetadataQuery_Class/index.html). 
```
[NSPredicate predicateWithFormat:@"%K like %@", NSMetadataItemFSNameKey, @"*"]
```
When the query is updated or finishes gathering data, an NSNotification is sent and the app view controllers observe and act accordingly; updating the table and dismissing the alert. 

There is also the issue of data persistence. What if the user decides to turn off iCloud one day or iCloud is somehow unavailable? Should we keep a copy of user's remote documents available for local use? Geometry Stash comes with preloaded geometry slides so I also needed to figure out what to do with those. The solution I decided on was to always import a local copy of the default slides while optionally copying a second set of the default slides to iCloud depending on availability. 

Auto Layout Fun
======

The app has two layouts for portrait and landscape orientations that require two unique sets of NSLayoutConstraints to — well — layout. 
<img src="{{ site.baseurl }}/wp-content/uploads/2015/08/portrait.png" align="left" style="padding:10px;">
<img src="{{ site.baseurl }}/wp-content/uploads/2015/08/landscape.png" align="right" style="padding:10px;">

Initially I swapped constraint sets in `updateViewConstraints` and they were updated. The problem was that `updateViewConstraints` is called after the device's returned interface orientation is changed so the layout engine had problems using the portrait constraints for the landscape screen size and vice versa. 

I could not find a good answer for this so I filed an Apple Bug Report and a TSI incident for it. I guess most developers have either moved onto Size Classes (iOS 7) for orientation specific layout or do not use Auto Layout at all for different orientations. 

The solution for this is to use a method *called before the device's returned orientation changes*. That method depends on your project's deployment target (minimum iOS version supported).

**iOS < 8** [`willRotateToInterfaceOrientation:`][1]

    - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
    {
        [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
        
        [self.view setNeedsUpdateConstraints];
    }

**iOS 8+** [`viewWillTransitionToSize:`][2]
and some checks to determine which orientation we are in. 

    - (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
    {
        if (size.width < size.height && self.view.bounds.size.width > self.view.bounds.size.height) {
            [NSLayoutConstraint deactivateConstraints:landscapeConstraints];
        } else if (size.width > size.height && self.view.bounds.size.width < self.view.bounds.size.height) {
            [NSLayoutConstraint deactivateConstraints:portraitConstraints];
        }
        [self.view setNeedsUpdateConstraints];
    }

  [1]: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIViewController_Class/index.html#//apple_ref/occ/instm/UIViewController/willRotateToInterfaceOrientation:duration:
  [2]: https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIContentContainer_Ref/index.html#//apple_ref/occ/intfm/UIContentContainer/viewWillTransitionToSize:withTransitionCoordinator:

My [Stack Overflow post](http://stackoverflow.com/a/31822721/761902) on this.

<img src="{{ site.baseurl }}/wp-content/uploads/2015/08/status-history.png" align="left" style="padding:15px">