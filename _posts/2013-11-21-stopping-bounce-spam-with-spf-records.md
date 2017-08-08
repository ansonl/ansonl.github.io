---
title: Stopping bounce spam with SPF records
author: Anson L
layout: post
permalink: /2013/11/stopping-bounce-spam-with-spf-records
dsq_thread_id:
  - 1984687984
categories:
  - Development
  - Thoughts
tags:
  - DNS
  - smtp
  - spam
  - spf records
---
For about a year, I have been receiving bounce messages from email servers. These bounce messages were sent as a result of a spammer sending messages with my domain, *apparentetch.com*, in the *From* field of the messages.

<div id="attachment_2792" style="width: 482px" class="wp-caption aligncenter">
  <img class="size-full wp-image-2792" alt="spam bounce" src="https://ansonliu.com/wp-content/uploads/2013/11/spam-bounce.png" width="472" height="124" /><p class="wp-caption-text">
    Example of a spam bounce.
  </p>
</div>

I received about upwards of 100 bounce messages daily. Not all servers are nice enough to send bounce messages nor did all of the emails go to nonexistent addresses so the number of forged emails sent in my name was probably much higher.

Sender Policy Framework (SPF) is an experimental protocol for validating email messages. The official spec, can be found <a href="http://tools.ietf.org/html/rfc4408" target="_blank">here</a>.

Through analysis for another project, the relevancy of SPF for stopping bounce spam became readily apparent. Even though it is still a specification, the SPF spec is widely implemented. As in my case, a domain with poorly configured or nonexistent SPF records is passing up effective spam prevention.

In Apparent Etch&#8217;s setup, inbound mail is routed to Google Apps and outgoing mail is sent from both Google Apps and the domain server.

No changes affect inbound mail as MX records have a separate purpose from SPF records.

SPF records currently exist as TXT records in DNS.  
To mark Google Apps and the domain server as allowed mail senders, I added two records whose syntax is explained farther down:  
`v=spf1 a:apparentetch.com`  
`v=spf1 include:_spf.google.com ~all`

How SPF records work:

[<img alt="SPF diagramed" src="https://ansonliu.com/wp-content/uploads/2013/11/spf-diagram-1024x682.png" width="625" height="416" />][1]

*   Domain owner of *example.co*m adds allowed entry of IP addresses to domains&#8217; SPF records.  
    `v=spf1 a:example.com` 
    *   This TXT record denotes that IP address of* example.com* is allowed to send messages for *example.com*.
    *   `v=spf1` specifies protocol of SPFv1.
    *   `a:` requests A record look up of `example.com:` domain.

*   **SMTP Server 1** receives MAIL FROM and HELO from** SMTP Server 2**.
*   **SMTP Server 1** performs a DNS lookup on TXT records for example.com. 
    *   **DNS server** returns `v=spf1 a:example.com` as a TXT record for example.com to** SMTP Server 1** 
        *   `v=spf1 a:example.com` means that allowed IP addresses for this record can be found in the A records of *example.com*.
*   **SMTP Server 1** performs DNS lookup on A records for example.com. 
    *   **DNS server** returns `example.com. IN A 1.1.1.1` as an A record for example.com to** SMTP Server 1** 
        *   `example.com. IN A 1.1.1.1` means that* 1.1.1.1* is a valid IP address for *example.com*. Additional SPF record syntax info can be found <a href="http://www.openspf.org/SPF_Record_Syntax" target="_blank">here</a>.
        *   **SMTP Server 1** now knows that *1.1.1.1* is allowed to send mail for *example.com*
*   **SMTP Server 1** checks to if **SMTP Server 2**&#8216;s IP address matches *1.1.1.1*. 
    *   If **SMTP Server 2**&#8216;s IP address matches *1.1.1.1*: 
        *   **SMTP Server 2** is allowed to send messages for *example.com*.
        *   **SMTP Server 1 **processes the message.
    *   If **SMTP Server 2**&#8216;s IP address does **not** match *1.1.1.1*: 
        *   **SMTP Server 2** is **not** allowed to send messages for *example.com*.
        *   **SMTP Server 1** replies with a bounce message to the *Return-Path* address of the rejected message. The *From* address is used if no *Return-Path* is provided. **SMTP Server 1** does not send the message.

According to the SPF spec, `v=spf1 a ~all` should also be added as the last TXT record to operate as a catch-all to designate all hosts not caught by previous SPF records as &#8220;NOT being allowed to send&#8221; on behalf of the domain. Through additional testing and <a title="Lookup apparentetch.com SPF records" href="http://mxtoolbox.com/SuperTool.aspx?action=mx%3aapparentetch.com&run=toolpage" target="_blank">lookups</a>, it appears that `v=spf1 a ~all` is assumed to be the last record if no catch-all record is found as the last record. I&#8217;m not sure if this is due to my management of DNS records through Rackspace, but hopefully someone can confirm.

Almost immediately after I added SPF records under my domain&#8217;s SPF records, the bounce emails ceased.

<div id="attachment_2778" style="width: 421px" class="wp-caption aligncenter">
  <img class="size-full wp-image-2778" alt="Hooray, no spam here!" src="https://ansonliu.com/wp-content/uploads/2013/11/no-spam.png" width="411" height="215" /><p class="wp-caption-text">
    Hooray, no spam here!
  </p>
</div>

Still, servers somewhere from Romania to Peru are sending emails pretending to come from *@apparentetch.com*.  
SPF records won&#8217;t stop these servers from sending out messages, but they will prevent these messages from reaching the inboxes of random users whom I&#8217;d rather not hear [spam] complaints from.

 [1]: https://ansonliu.com/wp-content/uploads/2013/11/spf-diagram.png