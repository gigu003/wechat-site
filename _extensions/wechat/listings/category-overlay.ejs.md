<%
const cols = templateParams.columns;
const countArticles = (sectionKey) => {
  let count = 0;
  const visit = (directory) => {
    for (const entry of Deno.readDirSync(directory)) {
      const path = `${directory}/${entry.name}`;
      if (entry.isDirectory) visit(path);
      if (entry.isFile && entry.name === 'index.qmd') count += 1;
    }
  };
  visit(`${Deno.cwd()}/main/${sectionKey}`);
  return count;
};
%>

::: {.list .grid .quarto-listing-cols-<%= cols %>}

<% for (const item of items) {
const itemDirectory = item.path.replace(/[^/]+$/, '');
const sectionKey = item.path.split('/').pop().replace(/\.(?:qmd|html)$/, '');
const articleCount = countArticles(sectionKey);
const subtitle = item.subtitle.replace(/href="([^"]+)"/g, (match, href) => {
  return /^(?:[a-z]+:|\/|#)/i.test(href) ? match : `href="${itemDirectory}${href}"`;
});
%>

::: {.g-col-1 <%= metadataAttrs(item) %>}

```{=html}
<article class="category-overlay-card">
  <div class="category-overlay-image" aria-hidden="true">
    <img loading="lazy" src="<%- item.image %>" class="thumbnail-image" alt="">
  </div>
  <span class="category-overlay-kicker"><%= item.kicker %></span>
  <span class="category-overlay-count">共 <span class="series-count"><%= articleCount %></span> 篇</span>
  <div class="category-overlay-content">
    <h3 class="listing-title"><a class="category-overlay-title-link" href="<%- item.path %>"><%= item.title %></a></h3>
    <div class="listing-subtitle category-overlay-subtitle"><%= subtitle %></div>
    <div class="listing-description category-overlay-description"><%= item.description %></div>
  </div>
</article>
```

:::
<% } %>

:::
