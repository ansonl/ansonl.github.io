---
title: 'Euler&#039;s not so Organics'
author: Anson Liu
layout: post
permalink: /2012/01/eulers-not-so-organics
dsq_thread_id:
  - 533399884
categories:
  - Thoughts
tags:
  - blogcritics
  - ecfr
  - euler
  - organic
  - usda
---
My first article on Blogcritics — on food. I assume you eat food, right?

Article first published as [Euler&#8217;s Not so Organics][1] on Blogcritics.

We all like organic food, but how organic would your &#8220;organic&#8221; food be?

The U.S. Department of Agriculture (USDA) allows the use of the term &#8220;organic&#8221; under <a href="http://ecfr.gpoaccess.gov/cgi/t/text/text-idx?c=ecfr&#038;sid=3f34f4c22f9aa8e6d9864cc2683cea02&#038;tpl=/ecfrbrowse/Title07/7cfr205_main_02.tpl" target="_blank">Part 205</a> &#8212; National Organic Program. To simply state the regulations, the term organic can be used differently depending on the composition of the product in <a href="http://ecfr.gpoaccess.gov/cgi/t/text/text-idx?c=ecfr&#038;sid=8fe7350d7512f34f83f47826793c6339&#038;rgn=div8&#038;view=text&#038;node=7:3.1.1.9.32.4.354.2&#038;idno=7" target="_blank">§ 205.301</a>.

**- 100% Organic**  
Composed of 100% organically produced ingredients by weight

**- Organic**  
Composed of ≥95% organically produced ingredients by weight

**- Made with Organic Ingredients**  
Composed of ≥70% organically produced ingredients by weight

**- Includes Organic Ingredients**  
Composed of ≤70% organically produced ingredients by weight  
Can only list specific ingredients as organic

The phrase to look at is &#8220;*organically produced* ingredients&#8221;. What defines an organically produced ingredient? <!--more-->What if the organically produced ingredient is determined to be organic through its composition by § 205.301, which has been simplified above?

[<img class="aligncenter size-full wp-image-1274" title="Detail" src="https://ansonliu.com/wp-content/uploads/2012/01/diagram.png" alt="" width="550" height="350" />][2]

<center>
  <small>This diagram should help you understand.</small>
</center>

  
So with every sub ingredient and level we go down,  
**the final % of organic material in the product decreases**.  
<small>*Note that organic is being defined by USDA regulations, not the scientific definition of organic.</small>

We can model the decrease in the function y = 100 × .95^x **or** y = 100 × ***e***^(-.05 × x).

[<img class="alignnone size-full wp-image-1275" title="y = 100 × .95^x" src="https://ansonliu.com/wp-content/uploads/2012/01/GRAPH-USING-POWER-OF-X.jpg" alt="y = 100 × .95^x" width="192" height="128" />][3] [<img class="alignnone size-full wp-image-1276" title="y = 100 × e^(-.05 × x)" src="https://ansonliu.com/wp-content/uploads/2012/01/GRAPH-WITH-E.jpg" alt="y = 100 × e^(-.05 × x)" width="192" height="128" />][4]

The equations&#8217; graphs are displayed respectively above. It is basically a negative interest model. Let&#8217;s call this the Euler&#8217;s Organics Model since we are using the natural number of ***e***, Euler&#8217;s Number to draw the second graph.

We will use the diagram further above to clarify. Going 1 level down, assuming that component A is only 95% organic due to X and Y components **not** being organic, only 90.25% of the final organic product would be organic. And so on. However, due to the nature of the functions above and reality, the final % of product that is truly organic will never reach 0% &#8212; just approach it.

*But wait, you say, wouldn&#8217;t the regulations, especially § 205.301 simplified above, prohibit this?*

The regulations refer to the &#8220;final product&#8221; being comprised of ≥X% of organically produced ingredients. This way, the measurement of weight would see component A as being the 95% organic part of the product. Component A as seen in the initial diagram may have its own subcomponents X, Y, Z.

**Back to the question of what defines organically produced?**

You can look at <a href="http://ecfr.gpoaccess.gov/cgi/t/text/text-idx?c=ecfr&#038;sid=8fe7350d7512f34f83f47826793c6339&#038;rgn=div8&#038;view=text&#038;node=7:3.1.1.9.32.3.354.1&#038;idno=7" target="_blank">Subpart C</a>. I have consulted the National Organic Program&#8217;s agents and they have confirmed that

> determination is also dependent on the percentage of the components of that ingredient.

*Oh no, so my food is being contaminated!*

Ye olde USDA hasn&#8217;t failed you yet. In the same regulation, non-organics cannot be present in **100% Organic** labeled and **Organic** labeled foods unless they are listed under [§205.606][5], a list of exceptions. When they are present, the label may say &#8220;**Made with**&#8220;.

Euler&#8217;s Organics Model only applies when ingredients of a product are made up of subcomponents. It usually only goes down about 1-2 levels because sooner or later, the subcomponents are raw materials such a tomato or pepper.

The tomato and pepper are 100% organic or nonorganic produce depending on where they are grown. Organic produce, raw materials, are grown according to <a href="http://ecfr.gpoaccess.gov/cgi/t/text/text-idx?c=ecfr&#038;sid=4c1fa926de0115da7071adf7f998c1ce&#038;rgn=div6&#038;view=text&#038;node=7:3.1.1.9.32.3&#038;idno=7" target="_blank">Subpart C</a>.

This said, you should continue feeling safe when buying organic foods since the Euler&#8217;s Organics Model only applies to certain organic labels.

If you want, you can read the entire <a href="http://ecfr.gpoaccess.gov/cgi/t/text/text-idx?c=ecfr&#038;sid=33fcbfcfd4b53c27330afa091d72c67a&#038;rgn=div5&#038;view=text&#038;node=7:3.1.1.9.32&#038;idno=7" target="_blank">Part 205 &#8212; National Organic Program</a> on the Electronic Code of Federal Regulations (e-CFR).

 [1]: http://blogcritics.org/tastes/article/eulers-not-so-organics/
 [2]: https://ansonliu.com/wp-content/uploads/2012/01/diagram.png
 [3]: https://ansonliu.com/wp-content/uploads/2012/01/GRAPH-USING-POWER-OF-X.jpg
 [4]: https://ansonliu.com/wp-content/uploads/2012/01/GRAPH-WITH-E.jpg
 [5]: http://ecfr.gpoaccess.gov/cgi/t/text/text-idx?c=ecfr&sid=0d4b6fb35586a02f64cf4a3e9527e8b9&rgn=div8&view=text&node=7:3.1.1.9.32.7.354.7&idno=7