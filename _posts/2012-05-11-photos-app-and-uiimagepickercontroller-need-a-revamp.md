---
title: Photos app and UIImagePickerController need a revamp
author: Anson L
layout: post
permalink: /2012/05/photos-app-and-uiimagepickercontroller-need-a-revamp
dsq_thread_id:
  - 686559020
categories:
  - Development
  - Thoughts
tags:
  - ios
  - Photos app
  - UIImagePickerController
---
Do you have a picture on your iPhone that you want to send to a friend? Is the latest media you took a video? Try firing up your messaging app to send the picture and looking at the Album thumbnail.

If you set `UIImagePickerController`&#8216;s source type to `UIImagePickerControllerSourceTypePhotoLibrary` but are only looking for photos, the album&#8217;s thumbnail will show the last media contained within that album.

[<img class="aligncenter size-medium wp-image-1645" title="Album List" src="https://ansonliu.com/wp-content/uploads/2012/05/picker-300x102.png" alt="Album List" width="300" height="102" />][1]

In this album I have a photo and video as the last media taken.

[<img class="aligncenter size-medium wp-image-1646" title="photo and video" src="https://ansonliu.com/wp-content/uploads/2012/05/photo-and-video-300x163.png" alt="photo and video" width="300" height="163" />][2]

Case in point, if the user is looking for photo media, the video thumbnail is shown; confusion entails.

Apple should include an option for `UIImagePickerController` to adjust the thumbnails and title of the picker view to reflect the relevant media that the user is looking for.

A call such as `source = photo` vs `source = video` when the user only browses one type of media would suffice.

That being said, the the title of the album picker list in the first screenshot should not be &#8220;Photos&#8221;, but rather &#8220;Media&#8221; when the user is browsing for both types of media.

Both photos and videos are being stored in the Photos app. The Photos app should be renamed to reflect the new types of media being stored in it. A few years ago, the iPhone only took still images so the Photos app was appropriately named at the time. Again, renaming to &#8220;Media&#8221; would be a good alternative.

&nbsp;

 [1]: https://ansonliu.com/wp-content/uploads/2012/05/picker.png
 [2]: https://ansonliu.com/wp-content/uploads/2012/05/photo-and-video.png