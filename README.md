# Code . Run . Eat . Sleep ↺

---

### Features you can rip out for your own site.

- [Animated title bar](https://github.com/ansonl/ansonl.github.io/blob/master/_includes/page-intro.html) using [mattboldt/typed.js](https://github.com/mattboldt/typed.js/).
- Menu sidebar toggle label color change based on background brightness for visibility using [kennethcachia/background-check](https://github.com/kennethcachia/background-check).
- [`lazysizes`](https://github.com/aFarkas/lazysizes) integration.
  - Markdown to `img` element for lazysizes regex substitution example below. 
  - Liquid include for `img` element at [lazysizes.html](https://github.com/ansonl/ansonl.github.io/blob/master/_includes/lazysizes.html). Usage example in below sections.
- [Post Archive](https://github.com/ansonl/ansonl.github.io/blob/master/archive.md) page with posts by year.
- [Post Tags](https://github.com/ansonl/ansonl.github.io/blob/master/tags.md) page with list of all tags *and* list of tags with related posts. 
  - Tag display in Liquid with matching CSS styling. Clicking tags in post page goes to tab list page. 
- Collection Items `entry.html` with redirects and customizable action link.
- Post `post.html` with ability to hide title.

### How to get updated theme from [Basically Basic Jekyll Theme](https://github.com/mmistakes/jekyll-theme-basically-basic) when using GitHub Pages

If you are using GitHub Pages, jekyll-theme-basically-basic gem is not supported so you can either fork the original [mmistakes/jekyll-theme-basically-basic](https://github.com/mmistakes/jekyll-theme-basically-basic) or clone it and add the original repository as a remote repository in Git.

```bash
git remote add upstream git@github.com:mmistakes/jekyll-theme-basically-basic.git
git pull upstream master
git mergetool #If needed
```

### Usage of [`lazysizes` Liquid include](https://github.com/ansonl/ansonl.github.io/blob/master/_includes/lazysizes.html) in a post
```liquid
{% capture src %}
  {{ '/wp-content/uploads/2017/07/ford_escape_audio_chassis.jpg' | prepend:site.baseurl }}
{% endcapture %}
{% include lazysizes.html alt='test alt' data-src=src caption='a caption [test link](http://example.com)' %}
```

### Convert Markdown images to be `lazysizes` compatible for posts with lots of images.

Assuming your Markdown images are in format
```
![titlee]({{ '/wp-content/uploads/2017/07/xxx.jpg' | prepend:site.baseurl }})
```

Regex
```
s/!\[(.*)\]\(({{.*}})\)/<img alt="\1" src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" data-src="\2" class="lazyload" />
```

### Contributing & Bugs

Bug reports and pull requests are welcome. 

### Credits

[Basically Basic Jekyll Theme](https://github.com/mmistakes/jekyll-theme-basically-basic) by mmistakes.

[Typed.js](https://github.com/mattboldt/typed.js/) by [Matt Boldt](http://www.mattboldt.com/).

[Background Check](https://github.com/kennethcachia/background-check) by [Kenneth Cachia](http://www.kennethcachia.com/).

[zenscroll](https://github.com/zengabor/zenscroll) by zengabor.

[lazysizes](https://github.com/aFarkas/lazysizes) by aFarkas.

Icons made by <a href="https://www.flaticon.com/authors/madebyoliver" title="Madebyoliver">Madebyoliver</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a>

### License

All original content is © 2022 Anson Liu. Permission is required if republishing any post content without attribution.