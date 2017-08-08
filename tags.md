---
layout: page
title: Post Tags
permalink: /tags/
---

<section id="tags">

  <h2>All tags</h2>
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
    {% for post in posts %}
      {% if post.tags contains t %}
      <li>
        <a href="{{ post.url }}">{{ post.title }}</a>
        <span class="date">{{ post.date | date: "%B %-d, %Y"  }}</span>
      </li>
      {% endif %}
    {% endfor %}
    </ul>
  {% endfor %}

</section>
