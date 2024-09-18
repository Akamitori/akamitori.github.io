---
layout: default
title: Home
---

<!-- Search bar at the top -->
<input type="text" id="search-input" class="search-bar" placeholder="Search posts...">
<ul id="results-container" class="search-results"></ul>

<!-- Post list below the search bar -->
<div id="post-list-container">
	<ul class="post-list">
	{% for post in site.posts %}
		<li class="post-item">
		<h2 class="post-title"><a href="{{ post.url }}">{{ post.title }}</a></h2>
		<small class="post-date">{{ post.date | date: "%B %d, %Y" }}</small>
		<p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 160 }}</p>
		</li>
	{% endfor %}
	</ul>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/simple-jekyll-search/1.7.2/simple-jekyll-search.min.js"></script>

<script>
  // Initialize the search functionality
  SimpleJekyllSearch({
    searchInput: document.getElementById('search-input'),
    resultsContainer: document.getElementById('results-container'),
    json: '{{ '/search.json' | relative_url }}',
    searchResultTemplate: '<li><a href="{url}">{title}</a><br><small>{date}</small><p>{excerpt}</p></li>',
    noResultsText: 'No results found',
  });

  // Grab the post list container element
  const postListContainer = document.getElementById('post-list-container');
  const searchInput = document.getElementById('search-input');
  const resultsContainer = document.getElementById('results-container');

  // Function to toggle the visibility of the post list based on search input and results
  function togglePostList() {
    const hasSearchInput = searchInput.value.trim().length > 0;
    const hasSearchResults = resultsContainer.innerHTML.trim().length > 0;

    // If there is no search input, show the post list and clear search results
    if (!hasSearchInput) {
      postListContainer.style.display = 'block';
      resultsContainer.innerHTML = ''; // Clear the search results immediately
      return;
    }

    // If there is search input and results, hide the post list
    if (hasSearchInput && hasSearchResults) {
      postListContainer.style.display = 'none';
    } else {
      // Show the post list if no results are found
      postListContainer.style.display = 'block';
    }
  }

  // Listen for input in the search bar
  searchInput.addEventListener('input', function() {
    togglePostList(); // Call the toggle function whenever the input changes
  });

  // Optionally, monitor the results container for changes
  const observer = new MutationObserver(function() {
    togglePostList(); // Call the toggle function whenever the search results are updated
  });

  // Start observing the results container for changes
  observer.observe(resultsContainer, { childList: true });
</script>


