# Code . Run . Eat . Sleep ↺

---

### Features you can rip out for your own site.

- [Animated title bar](https://github.com/ansonl/ansonl.github.io/blob/master/_includes/page-intro.html) using [mattboldt/typed.js](https://github.com/mattboldt/typed.js/).
- Menu sidebar toggle label color change based on background brightness for visibility using [kennethcachia/background-check](https://github.com/kennethcachia/background-check).
- Native lazy loading for offscreen images and embeds without a JavaScript dependency.
- [Post Archive](https://github.com/ansonl/ansonl.github.io/blob/master/archive.md) page with posts by year.
- [Post Tags](https://github.com/ansonl/ansonl.github.io/blob/master/tags.md) page with list of all tags *and* list of tags with related posts. 
  - Tag display in Liquid with matching CSS styling. Clicking tags in post page goes to tab list page. 
- Collection Items `entry.html` with `thumbnail` image, `redirect` redirects and `more-link-text` customizable action link.

### How to get updated theme from [Basically Basic Jekyll Theme](https://github.com/mmistakes/jekyll-theme-basically-basic) when using GitHub Pages

If you are using GitHub Pages, jekyll-theme-basically-basic gem is not supported so you can either fork the original [mmistakes/jekyll-theme-basically-basic](https://github.com/mmistakes/jekyll-theme-basically-basic) or clone it and add the original repository as a remote repository in Git.

```bash
git remote add upstream git@github.com:mmistakes/jekyll-theme-basically-basic.git
git pull upstream master
git mergetool #If needed
```

### Images in posts

Write ordinary images with Markdown. During the build, the first image on a
page remains eager and later Markdown images receive native `loading="lazy"`:

```markdown
![Description](/path/to/image.webp)
```

Use the `lazy-image.html` include when a caption or custom figure style is needed:

```liquid
{% capture src %}
  {{ '/wp-content/uploads/2017/07/ford_escape_audio_chassis.jpg' | prepend:site.baseurl }}
{% endcapture %}
{% include lazy-image.html alt='test alt' src=src caption='a caption [test link](http://example.com)' %}
```

The build does not change raw HTML images. Keep the real URL in `src` so they
work without JavaScript, and choose their loading behavior explicitly. Do not
lazy-load a hero or other likely LCP image.

```html
<img src="/path/to/image.jpg" alt="Description" loading="lazy" decoding="async">
```

### Contributing & Bugs

Bug reports and pull requests are welcome. 

### Credits

[Basically Basic Jekyll Theme](https://github.com/mmistakes/jekyll-theme-basically-basic) by mmistakes.

[Typed.js](https://github.com/mattboldt/typed.js/) by [Matt Boldt](http://www.mattboldt.com/).

[Background Check](https://github.com/kennethcachia/background-check) by [Kenneth Cachia](http://www.kennethcachia.com/).

[zenscroll](https://github.com/zengabor/zenscroll) by zengabor.

Icons made by <a href="https://www.flaticon.com/authors/madebyoliver" title="Madebyoliver">Madebyoliver</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a>

[Makerworld SVG](https://makerworld.com/en/models/1157679-svg-logos) by pocketrush3d

### License

All original content is © 2022 Anson Liu. Permission is required if republishing any post content without attribution.
