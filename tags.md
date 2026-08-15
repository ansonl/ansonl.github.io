---
layout: page
title: Post Tags
permalink: /tags/
---

<section id="tags">

  <h2>All Tags</h2>
  <ul class="tags">
  {% for tag in site.tags %}
    {% assign t = tag | first %}
    {% assign posts = tag | last %}
    <li><a href="#{{ t | upcase }}">{{t | upcase | replace:" ","-" }}</a> has {{ posts | size }} posts</li>
  {% endfor %}
  </ul>

  {% for tag in site.tags %}
    {% assign t = tag | first %}
    {% assign posts = tag | last %}

    <h3 id="{{ t | upcase }}">{{ t | upcase }}</h3>
    <ul>
    {% comment %}
      No `if post.tags contains t` filter here: site.tags[t] already contains
      only the posts carrying tag t, so the test was a redundant array scan per
      post per tag.
    {% endcomment %}
    {% for post in posts %}
      <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
        <span class="date">{{ post.date | date: "%B %-d, %Y"  }}</span>
      </li>
    {% endfor %}
    </ul>
  {% endfor %}

</section>
