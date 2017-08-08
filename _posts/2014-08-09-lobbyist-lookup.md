---
title: Unified Lobbyist Lookup
author: Anson L
layout: post
permalink: /2014/08/lobbyist-lookup
dsq_thread_id:
  - 2914020762
categories:
  - Development
  - Thoughts
tags:
  - code for nova
  - github
  - go
  - lobbyist lookup
  - national day of civic hacking
  - national science foundation
---
<img class="alignleft wp-image-3055 size-full" src="https://ansonliu.com/wp-content/uploads/2014/08/touch-icon-iphone-retina.png" alt="Lobbyist Lookup" width="120" height="120" />[Lobbyist Lookup][1] is a Go program that downloads, parses, and allows users to search over 310,000 US Congressional Lobbyist Disclosure filings.

Over the summer this year, I participated in the [National Day of Civic Hacking (NDOCH)][2] organized by the [Northern Virginia Code for America  Brigade][3] and sponsored by the [National Science Foundation (NSF)][4]. At NDOCH, I teamed up with [Leandra Tejedor][5] and Sherry Wang to create Lobbyist Lookup to solve the NSF&#8217;s Ethics Challenge.

<p id="ethics">
  <strong>What is the NSF Ethics Challenge?</strong>
</p>

*   Per <a style="color: #428bca;" href="http://www.oge.gov/Laws-and-Regulations/OGE-Regulations/5-C-F-R--Part-2635---Standards-of-ethical-conduct-for-employees-of-the-executive-branch/">5 C.F.R. Part 2635</a>, executive branch employees may not accept gifts from lobbyists. Other branches of government have their separate rules regarding gift receiving. The Office of Government Ethics is proposing extending the lobbyist gift ban to cover all federal employees.
*   A [Presidential memorandum][6] dated June 18, 2010 directed Executive agencies, not to appoint or re-appoint Federally registered lobbyists to advisory committees, review panels, or other similar groups.
*   Currently looking up lobbying status involves searching [House.gov ][7]and [Senate.gov][8] lobbyist disclosure databases which are completely separate, have dissimilar interfaces, and different formats. There is no feedback when typing a search term so a misspelling of *Dylan* vs *Dillon* could have legal consequences.
*   Federal employees need a way to lookup the lobbying status of an individual or organization to quickly and accurately determine gift giving eligibility.

<p style="text-align: center;">
  <!--more-->
</p>

NDOCH had many other programming challenges and activities to do. Many of these challenges had APIs and sponsor governmental organizations readily providing data. Our two houses of Congress, the House and Senate, had web interfaces which citizens use to search through filings with and bulk filing download pages.

*Sections:*

*   [The NSF Ethics Challenge][9]
*   [Getting House data][10]
*   [Getting Senate data][11]
*   [Data unification][12]
*   [JS web lookup goodness][13]
*   [Performance Issues and Approaches][14]
*   [Miscellaneous][15]

### House

<div id="attachment_3010" style="width: 310px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/downloadbulkbuttonhouse.png"><img class="size-medium wp-image-3010" src="https://ansonliu.com/wp-content/uploads/2014/08/downloadbulkbuttonhouse-300x71.png" alt="House.gov download button" width="300" height="71" /></a><p class="wp-caption-text">
    House.gov download button
  </p>
</div>

Our team&#8217;s first objective was somehow parse the filing data so that we could search it. For the House data, we manually downloaded and unarchived the filings. Each filing had its own XML file with a structure similar to

*   Filing
*   Organization
*   Client
*   Lobbyists
*   John Doe
*   Steve Ha

I choose to use [Go][16] as the language to parse and search the filings. Why not? (Actually there are a lot of reasons why not, but we can go over that later)

I defined a HouseFiling and HouseLobbyist structure  

{% gist ansonl/d5ecef2bb395f8001a2d %}

The `xml:` portion after each property of the struct indicates the source element in the XML file to get data from. We have an array for the Lobbyist property because the XML file provides multiple Lobbyist elements each with presumably different lobbyists. Use `encoding/xml` in Go to unmarshal the XML into the HouseFiling struct.

`oneFiling := HouseFiling{}<br />
xml.Unmarshal(XMLDATA, &amp;oneFiling)`

Now that all the filings were parsed into an array of HouseFiling structs, we started a [server in a Goroutine][17] to receive queries and had it loop the array to find matching filings. It acted as an API that clients could interact with. Leandra and Sherry worked on a [Python parser][18] for the Senate data and created basic web interface for queries. That was all we got done with in about 6 hours and we got 1st for the hackathon. Prize was dinner with Dr. Cora B. Marrett, Deputy Director, NSF.

Anyways, we had gotten the House and Senate data parsed but only the House data was searchable. We had also taken the easy route by manually downloading the data and providing a source directory for our Go and Python programs. We kept working on the program to make it usable.

Hm, so we sort of want to automate the download of data from the House. That should be easy, right?

<div id="attachment_3007" style="width: 310px" class="wp-caption alignleft">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/housesearch.png"><img class="wp-image-3007 size-medium" src="https://ansonliu.com/wp-content/uploads/2014/08/housesearch-300x212.png" alt="House.gov Lobbyist Disclosure Filing Search" width="300" height="212" /></a><p class="wp-caption-text">
    House.gov Lobbyist Disclosure Filing Search
  </p>
</div>

First we look at the lower left button. It says matter of fact Download and lets us choose a format! Wow, XML and CSV are nice options I think. Maybe we can create a custom form that interacts with the server and then we download the results in XML?

<div id="attachment_3009" style="width: 310px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/downloadlimithouse.png"><img class="size-medium wp-image-3009" src="https://ansonliu.com/wp-content/uploads/2014/08/downloadlimithouse-300x63.png" alt="Result of trying to download a search with many matches" width="300" height="63" /></a><p class="wp-caption-text">
    Result of trying to download a search with many matches
  </p>
</div>

Ha ha, nice one. Guess the House doesn&#8217;t want to show too many results, but they DO let us download all filings in a ZIP archive. Each archive definitely contains more than 2000 records... So...yeah. The button to do so is circled in the previous screenshot.

<div id="attachment_3011" style="width: 289px" class="wp-caption alignright">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/housedownloadform.png"><img class="size-full wp-image-3011" src="https://ansonliu.com/wp-content/uploads/2014/08/housedownloadform.png" alt="House.gov download form" width="279" height="66" /></a><p class="wp-caption-text">
    House.gov download form
  </p>
</div>

When following the link, we get to a page that consist of an HTML form with a drop down selection of quarterly archives and a download button. This page&#8217;s URL is ***http://disclosures.house.gov/ld/LDDownload.aspx?KeepThis=true&***. Keeping it in mind, it will come handy later.

I thought that it would a  simple matter to deduce the format of the file URLs and getting the filings by iterating though */201X_1stQuarter.zip* to */201X_4thQuarter.zip*. When receiving the archives from the server, there should be an originating path that the file is coming from.

<div id="attachment_3017" style="width: 310px" class="wp-caption alignright">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/houseurlorigin.png"><img class="wp-image-3017 size-medium" src="https://ansonliu.com/wp-content/uploads/2014/08/houseurlorigin-300x27.png" alt="Chrome download URL" width="300" height="27" /></a><p class="wp-caption-text">
    Download URL in Chrome
  </p>
</div>

Wait, what the?! It&#8217;s coming from the exact same url as the form page with no file in the path! Looking at the form code for details shows us this snippet:  

{% gist c5800d5c1a24876c9516 %}

Hm&#8230; this form uses POST to send the form contents to itself.  
No problem right? We can predict the file names from the drop down, submit a POST request, and read the reply to get the file.

[<img class="alignleft wp-image-3018 size-thumbnail" src="https://ansonliu.com/wp-content/uploads/2014/08/houseerrorpage-150x150.png" alt="House error page" width="150" height="150" />][19]

Oh no! That didn&#8217;t work like I thought it would.  
Our browser is not sending something that the server needs. What could it be?

The form on the page includes hidden elements `__VIEWSTATE` and `__EVENTVALIDATION`.  
[What are these][20]? They are used by ASP to prevent Cross-Site Request Forgery (CSRF). Can we still get at the public data? 

The hidden input items work by ensuring that the user browser has actually visited the ASP page and sent an authentic request originating from the user. It assigns each visitor a unique `__VIEWSTATE` and `__EVENTVALIDATION` and verifying them upon receipt of sent request. We have not been sending the correct `__VIEWSTATE` or `__EVENTVALIDATION` — or any data besides our filenames in the POST requests so the server believes a CSRF is being attempted.

We could grab `__VIEWSTATE` and `__EVENTVALIDATION` elements from the form and then submit those along with our POST request for the files. There is also a [StackOverflow post][21] on this issue.  
I used the `code.google.com/p/go.net/html` Go library to assist with parsing the HTML page into elements and extracting the `__VIEWSTATE` and `__EVENTVALIDATION` input element values. Code for this can be found in `<a href="https://github.com/ansonl/lobbyist-lookup/blob/master/houseRetrieve.go">houseRetrieve.go</a>` in the `scrape()` function.

The filename parameter includes the updated timestamp so `code.google.com/p/go.net/html` assisted in scraping those values. I put all the filenames in a slice and requested the files referenced in the last 6 elements of the slice in order to get filings from the past six quarters. After some more testing and failures I found `selFilesXML` and `btnDownloadXML` POST parameters are required as well. I have included a table of parameters and explanations in the [`README`][22].

Whew, that was quite a bit. Take a break, check out the [code][23].  
Let&#8217;s take a gander at the Senate data.

### Senate

<p id="senate">
  Unlike the House the Senate actually has a <a href="http://www.senate.gov/legislative/Public_Disclosure/database_download.htm">download page</a> with a link for each filing.
</p>

<div id="attachment_3024" style="width: 310px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/senatedownload.png"><img class="size-medium wp-image-3024" src="https://ansonliu.com/wp-content/uploads/2014/08/senatedownload-300x237.png" alt="Senate download page" width="300" height="237" /></a><p class="wp-caption-text">
    Senate download page
  </p>
</div>

*http://soprweb.senate.gov/downloads/2014_1.zip*  
* http://soprweb.senate.gov/downloads/2014_2.zip*  
* http://soprweb.senate.gov/downloads/2014_3.zip*  
*&#8230;*

Each quarterly archive has a static URL. This may be our lucky break! Simply iterate through a list of filename and read the responses to our GET requests. Pass the data to xml.Unmarshal and &#8230;

> xml: Invalid character on line 1 expected

Line 1 of each downloaded XML file is`<!--?xml version='1.0' encoding='UTF-16'?-->`

It looks and is like valid XML. It also kills many breeds of XML readers due to its 3 MB size. It is also in UTF-16 when Go expects UTF-8.

Trying to convert UTF-16 to UTF-8 from scratch went badly so instead I found the `code.google.com/p/go-charset/charset` Go library which allowed me to convert formats in a few lines of code.  

{% gist 65e895808585437a7167 %}

Now with a UTF-8 byte slice we can unmarshal the data into our defined structs without any issues.

{% gist c10a412e16eda175f8d6 %}

### Data unification

<p id="unify">
  I now have two arrays of filings from each house of Congress in different types of structures. To unify them I created a common structure and looped through both arrays, assigning the common structure&#8217;s properties the relevant data from the respective house-specific structure.
</p>

For some parts of the data such as the lobbyist name, you may notice that the Senate XML files only provide names in a string in format of

> DOE, JOHN A

To separate the names, we use Go `strings` like so  
`firstName = senateLobbyist.LobbyistName[strings.Index(senateLobbyist.LobbyistName, ",")+1:]<br />
lastName = senateLobbyist.LobbyistName[:strings.Index(senateLobbyist.LobbyistName, ",")]`  
Find position of first comma in the string. Get portions of string (byte slice) from both sides.

The code for this may be found in `<a href="https://github.com/ansonl/lobbyist-lookup/blob/master/combine.go">combine.go</a>`. When the program receives a client request, it simply loops through the massive array of 310,000 records looking for matches. All code for this project can be viewed on [GitHub][24].

### JS Web lookup

<p id="jsweblookup">
  Leandra and I created a Lobbyist Lookup website that may be used <a href="http://ansonl.github.io/lobbyist-lookup/">here</a>.<br /> <a href="http://ansonl.github.io/lobbyist-lookup/"><img class="alignleft wp-image-3045 size-medium" src="https://ansonliu.com/wp-content/uploads/2014/08/weblookupscreenshot-300x137.png" alt="" width="300" height="137" /></a><br /> The code for the web lookup is available in the <a href="https://github.com/ansonl/lobbyist-lookup/tree/gh-pages"><code>gh-pages</code></a> branch on GitHub.
</p>

Most of the logic for the page is written from scratch in Javascript. I&#8217;ve attempted to separate them into files aptly named `form`, `filing`, and `table`.  
`form` includes the JQuery submit handler and element animations. It calls functions in `filing` and `table`.  
`filing` defines Filing objects for sorting purposes and attempts to clean up received filings by removing blank data and aggressively eliminating lobbyist and filings duplicates.  
`table` creates an HTML table which displays the cleaned up data.  
The web lookup page uses JQuery UI&#8217;s [autocomplete widget][25] which queries the Go app for potential matches and displays possible matches to the user. JQuery made autocomplete an easy drop in.

Implementing autocomplete led to some interesting insights on record fragmentation.

<div id="attachment_3072" style="width: 510px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/spelling-diffs.png"><img class="wp-image-3072" src="https://ansonliu.com/wp-content/uploads/2014/08/spelling-diffs.png" alt="Pepsico autocompleted" width="500" height="150" /></a><p class="wp-caption-text">
    Pepsico autocompleted
  </p>
</div>

As seen above, Pepsico has many possible spellings.

<div id="attachment_3074" style="width: 510px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/surnamedata.png"><img class="wp-image-3074" src="https://ansonliu.com/wp-content/uploads/2014/08/surnamedata.png" alt="Surname metadata" width="500" height="185" /></a><p class="wp-caption-text">
    Surname metadata
  </p>
</div>

Surnames can also contain some interesting data such as effective date, occupation, and termination status.

### Performance Issues and Approaches

<div id="attachment_3080" style="width: 110px" class="wp-caption alignleft">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/heroku600mbwarning.jpg"><img class="wp-image-3080" src="https://ansonliu.com/wp-content/uploads/2014/08/heroku600mbwarning-150x150.jpg" alt="Heroku memory warnings" width="100" height="94" /></a><p class="wp-caption-text">
    Heroku memory warnings
  </p>
</div>

<p id="performance">
  After adding in the Senate data, we began encountering performance issues. Our Heroku instance began sputtering to a halt at >600 MB memory usage due to throttling on Heroku&#8217;s side. AWS free tier instances wouldn&#8217;t even make it past parsing all the data, an instance would simply run out of memory.
</p>

&nbsp;

The Go program would parse filings from each house of Congress into an array of structures unique to that house. When parsing was done we would then pass the two different structures to another function that converted the unique structures into a generic structure that the web server could search through.

<div id="attachment_3066" style="width: 510px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/combine.png"><img class="wp-image-3066" src="https://ansonliu.com/wp-content/uploads/2014/08/combine.png" alt="Combine" width="500" height="375" /></a><p class="wp-caption-text">
    Combine
  </p>
</div>

With only the House data, the Go app took up 512 MB memory on Heroku and ran fine. What could be causing this extra memory usage and resulting performance deterioration besides an extra 200,000 records? The Go app would parse the two houses of congress in Goroutines, Go&#8217;s version of threads. That means that both houses could be parsed at the same time and the program would be maintaining separate arrays for each house. I had also passed the [arrays by value][26] to the combining function which would require two copies of each array in memory.

<div id="attachment_3067" style="width: 510px" class="wp-caption aligncenter">
  <a href="https://ansonliu.com/wp-content/uploads/2014/08/direct.png"><img class="wp-image-3067" src="https://ansonliu.com/wp-content/uploads/2014/08/direct.png" alt="Immediate Conversion" width="500" height="375" /></a><p class="wp-caption-text">
    Immediate Conversion
  </p>
</div>

I changed the program to convert each filing into the generic filing structure as soon as it had been parsed rather than wait for the complete parsing of *all* filings from a house. Since the array of generic filings was being modified from different Goroutines, I used [sync.Mutex][27] to avoid problems. The array of generic filings was also changed to be passed by reference so it would not be copied in the combining function.

Even though the end result of both approaches towards parsing and combining is a massive array of filings, the result of the second approach was a more lightweight Go program that used around 540MB memory. It was somewhat more responsive on a 1X Heroku dyno. AWS micro instance still couldn&#8217;t handle the heat. This is still a work in progress.

### Miscellaneous

<p id="misc">
  You can use Lobbyist Lookup to lookup lobbyists for legal reasons such as gift giving and appointments. It currently allows you to search filings by surname, organization, or client.
</p>

##### Organization vs Client

<table border="1">
  <tr>
    <td>
      Organization
    </td>
    
    <td>
      Registering entity. This may be a lobbying firm hired by a client.
    </td>
  </tr>
  
  <tr>
    <td>
      Client
    </td>
    
    <td>
      The entity actually behind the filing. This may be a company (← client) hiring the lobbying firm (← organization).
    </td>
  </tr>
</table>

You can also use Lobbyist Lookup to discover the lobbying activities of companies of interest for transparency. The API is free for all to modify and use. Download the [sample app for iOS][28] that lets you lookup lobbyists natively. The parsed filings contain other information such as income and contributions which you can easily modify to view.

 [1]: http://ansonl.github.io/lobbyist-lookup/
 [2]: http://hackforchange.org/events/northern-virginia-national-day-of-civic-hacking/
 [3]: http://www.codefornova.org
 [4]: http://www.nsf.gov/
 [5]: http://leandratejedor.com
 [6]: http://www.whitehouse.gov/the-press-office/presidential-memorandum-lobbyists-agency-boards-and-commissions
 [7]: http://disclosures.house.gov/ld/ldsearch.aspx
 [8]: http://www.senate.gov/legislative/Public_Disclosure/LDA_reports.htm
 [9]: #ethics
 [10]: #house
 [11]: #senate
 [12]: #unify
 [13]: #jsweblookup
 [14]: #performance
 [15]: #misc
 [16]: http://golang.org
 [17]: https://github.com/ansonl/lobbyist-lookup/blob/master/api.go
 [18]: https://github.com/ltejedor/lobbyist-gift-ban/blob/master/senate.py
 [19]: https://ansonliu.com/wp-content/uploads/2014/08/houseerrorpage.png
 [20]: https://www.owasp.org/index.php/Cross-Site_Request_Forgery_(CSRF)_Prevention_Cheat_Sheet#Viewstate_.28ASP.NET.29
 [21]: http://stackoverflow.com/questions/14746750/post-request-using-python-to-asp-net-page/14747275#14747275
 [22]: https://github.com/ansonl/lobbyist-lookup/blob/master/README.md
 [23]: https://github.com/ansonl/lobbyist-lookup
 [24]: https://github.com/ansonl/lobbyist-lookup/
 [25]: http://jqueryui.com/autocomplete/
 [26]: http://blog.golang.org/go-slices-usage-and-internals
 [27]: https://gobyexample.com/mutexes
 [28]: https://itunes.apple.com/us/app/lobbyist-lookup/id903578849?mt=8