<% /* Article grid listing. Renders `date` and `date-modified` in a compact
    editorial timeline at the card footer. Custom listing templates do not
    receive Quarto's `listing` object, so the grid column count is supplied via
    template-params. The `date-modified` label matches the `field-display-names`
    value in the listing YAML. */ %><%
const cols = templateParams.columns || 2;
%>
::: {.list .grid .quarto-listing-cols-<%= cols %>}

<% for (const item of items) {
const showField = (field) => item[field] !== undefined && item[field] !== '';
%>

::: {.g-col-1 <%= metadataAttrs(item) %> }

```{=html}
<a href="<%- item.path %>" class="quarto-grid-link">
<div class="quarto-grid-item card h-100 card-left">
```

<% if (item.image) { %>
```{=html}
<p class="card-img-top">
<img loading="lazy" src="<%- item.image %>" class="thumbnail-image card-img" alt="">
</p>
```
<% } %>

::: {.card-body .post-contents}

<% if (showField('title')) { %>
<h5 class="no-anchor card-title listing-title"><%= item.title %></h5>
<% } %>

<% if (item.categories) { %>
```{=html}
<div class="listing-categories">
<% for (const category of item.categories) { %>
<div class="listing-category" onclick="window.quartoListingCategory('<%= utils.b64encode(category) %>'); return false;"><%= category %></div>
<% } %>
</div>
```
<% } %>

<% if (showField('description')) { %>
```{=html}
<div class="card-text listing-description delink">
```
<%= item.description %>
```{=html}
</div>
```
<% } %>

<% if (showField('date') || showField('date-modified')) { %>
```{=html}
<div class="card-attribution card-text-small end" aria-label="文章时间">
<% if (showField('date')) { %><div class="listing-date listing-date-published"><span class="listing-date-label">发布于</span><time class="listing-date-value"><%= item.date %></time></div><% } %><% if (showField('date-modified')) { %><span class="listing-date-separator" aria-hidden="true">→</span><div class="listing-date listing-date-modified"><span class="listing-date-label">更新于</span><time class="listing-date-value"><%= item['date-modified'] %></time></div><% } %>
</div>
```
<% } %>

:::

```{=html}
</div></a>
```

:::
<% } %>

:::
