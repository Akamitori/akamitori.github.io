---
layout: default
title: Home
---

<!-- Search bar at the top -->
<input type="text" id="search-input" class="search-bar" placeholder="Search posts...">
<ul id="results-container" class="search-results"></ul>

<!-- Post list below the search bar -->
<ul class="post-list">
  {% for post in site.posts %}
    <li class="post-item">
      <h2 class="post-title"><a href="{{ post.url }}">{{ post.title }}</a></h2>
      <small class="post-date">{{ post.date | date: "%B %d, %Y" }}</small>
      <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 160 }}</p>
    </li>
  {% endfor %}
</ul>

<script src="https://cdnjs.cloudflare.com/ajax/libs/simple-jekyll-search/1.7.2/simple-jekyll-search.min.js"></script>

<script>
  SimpleJekyllSearch({
    searchInput: document.getElementById('search-input'),
    resultsContainer: document.getElementById('results-container'),
    json: '{{ '/search.json' | relative_url }}',
    searchResultTemplate: '<li><a href="{url}">{title}</a><br><small>{date}</small><p>{excerpt}</p></li>',
    noResultsText: 'No results found',
  });
</script>
