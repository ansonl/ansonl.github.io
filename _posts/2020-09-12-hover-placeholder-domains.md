---
published: true
excerpt: >
  I transferred a domain away from Hover, but Hover continued to show domain on
  the account as well as send misleading renewal notices. Turns out Hover calls
  them *placeholder domains* that look exactly identical. 


  If you're not sure it really got transferred, check for yourself using the
  `whois` command. 


  ![Hover misleading 1 day renewal
  email](/wp-content/uploads/2020/09/hover_1_day_renewal_email.png)
author: Anson Liu
layout: post
image: /wp-content/uploads/2017/07/all_pcb_bench.jpg
categories:
  - Development
tags:
  - domain
  - whois
  - registrar
  - renewal
  - hover
  - cloudflare
---
## Beware of Hover Placeholder Domains After Transferring and whois command

I previously registered several domains through [Hover](https://hover.com) (actually [Tucows](https://Tucows.com) registrar) for the last 8 years and recently transferred the registrations to Cloudflare. However the Hover's dashboard continued to show my domains as registered through Hover with no indication that they had been transferred. 

![Hover 15 day renewal email]({{ '/wp-content/uploads/2020/09/hover_15_day_renewal_email.png' | prepend:site.baseurl }})

1. I initiated the transfer by unlocking the domains through the Hover dashboard to get an transfer code.

2. I entered the code into the Cloudflare domain transfer site.

3. The domains transferred from Hover to Cloudflare in a few hours with no issues. 

Afterwards, WHOIS and DNS records reflected Cloudflare records and I went on with my life. The transferred domains remained listed in the Hover dashboard so I set them to not autorenew. I assumed that Hover's database would take some time to catch up. 

A few months later, Hover began sending me emails warning me the domains were expiring/expired. Knowing that I had already transferred the domains and the records were updated, I took a look at Hover dashboard and my domains were listed as being in "redemption" period. Hover's website indicated that the domains were still with my Hover account and that I could renew them. 

I contacted Hover support and they replied that the domains were listed as "placeholder domains" and that they could remove them. When I inquired as to how I would've been able to check if the domains had successfully been transferred away from Hover I recieved the following guidance:

> Please use https://www.whois.com. If you see the registrar as Tucows, it is still with Hover. If you see something else then it is with a different registrar.

![Hover dashboard after purge]({{ '/wp-content/uploads/2020/09/hover_dashboard.png' | prepend:site.baseurl }})

_The Hover dashboard looked like the above after Hover support removed the "placeholder domains". Why there are now inoperative example domains is confusing but I got what I came for and didn't inquire furthur._

So there is essentially no way for a normal user using the Hover website to tell if their domain successfully transferred away from Hover. As a registrar that advertises excellent support, the timeliness of their response was good, however the lack of positive (or negative) confirmation on the Hover side as to whether the domain was still registered to Hover and guidance to do a WHOIS check on my own was concerning. 

I haven't had any issues with Hover as a registrar before this and in this case I was knowledgable enough to understand that the domain had transferred despite the Hover dashboard claiming the opposite. 

Hover's user dashboard should update to reflect a domain's actual status and not have "placeholder domains" that look identical to valid Hover registered domains. Furthermore, the renewal reminder emails for transferred away domains are misleading. 

![Hover 1 day renewal email]({{ '/wp-content/uploads/2020/09/hover_1_day_renewal_email.png' | prepend:site.baseurl }})

If I had been less knowledgable or left my domains on autorenew, I expect that I would've panic paid a renewal fee for nothing and more time and effort would be spent clawing it back. 

If you prefer not to use a web based site to check WHOIS records, you may use the `whois` command through the command line to check the current domain registrar. 

```
sudo apt-get install whois # If you do not have whois installed

whois example.com --verbose
```

> Domain Name: ANSONLIU.COM
> Registry Domain ID: 1725139480_DOMAIN_COM-VRSN
> Registrar WHOIS Server: whois.cloudflare.com
> Registrar URL: http://www.cloudflare.com
> Updated Date: XXXX
> Creation Date: XXXX
> Registry Expiry Date: XXXX
> Registrar: CloudFlare, Inc.

> Domain Name: HOVER.COM
> Registry Domain ID: 2164592_DOMAIN_COM-VRSN
> Registrar WHOIS Server: whois.tucows.com
> Registrar URL: http://tucowsdomains.com
> Updated Date: XXXX
> Creation Date: XXXX
> Registrar Registration Expiration Date: XXXX
> Registrar: TUCOWS, INC.

You can see the updated registrar information in the output versus a sample of the original registrar record. 

Adding `--verbose` option will output the registry server selected as source. The whois command manual specifies that *whois.networksolutions.com* is the default query server. Network Solutions was acquired by Verisign and is now part of Web.com group. Most whois clients will [start at Verisign's WHOIS server](https://github.com/rfc1036/whois/blob/b7cfb4ef37c4f53f29e8b52ce78fa11258d0ad97/tld_serv_list). The current agreed upon root `.com` registry is run by Verisign due to an [agreement](https://www.sec.gov/Archives/edgar/data/1014473/000119312507154202/dex1026.htm) between Verisign and ICANN. 

Why does Verisign get a monopoly on the `.com` top level domain and why it's unlikely to change has been widely discussed elsewhere and would be the topic an entirely separate post.
