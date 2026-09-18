-- Adapt the shared WeChat theme definitions to Quarto Website HTML without
-- allowing mobile-editor body styles to leak into the site shell.
function Pandoc(doc)
  if not FORMAT:match('html') then return doc end
  -- The custom format is also used by the home and category pages. Only
  -- documents that opt in with `article-theme` receive the article frame;
  -- otherwise the extension leaves Quarto's native site shell untouched.
  if doc.meta['article-theme'] == nil then return doc end
  local name = pandoc.utils.stringify(doc.meta['article-theme'])
  assert(name:match('^[a-z][a-z%-]+$'), 'Invalid article-theme')
  local path = quarto.utils.resolve_path('../themes/' .. name .. '.json')
  local file = assert(io.open(path), 'Unknown article-theme: ' .. name)
  local theme = quarto.json.decode(file:read('*a')); file:close()
  local shell_path = quarto.utils.resolve_path('article-theme-shells.json')
  local shell_file = assert(io.open(shell_path), 'Missing article-theme shell definitions')
  local shells = quarto.json.decode(shell_file:read('*a')); shell_file:close()
  local shell = assert(shells[name], 'Missing website shell for article-theme: ' .. name)
  local theme_attr = '[data-article-theme="' .. name .. '"]'
  -- Keep actual Header blocks at Quarto's document level. The right-hand TOC
  -- is assembled from those top-level headers; a wrapper Div hides them from
  -- Quarto's collection phase.
  local frame_scope = 'main.content:has(.article-body' .. theme_attr .. ')'
  local scope = 'main.content .article-body' .. theme_attr
  local heading_scope = 'main.content '
  local css = {}
  local function rule(selector, style)
    if style then table.insert(css, selector .. '{' .. style .. '}') end
  end
  local function without_properties(style, properties)
    local result = ';' .. (style or '')
    for _, property in ipairs(properties) do
      local escaped = property:gsub('%-', '%%-')
      result = result:gsub(';%s*' .. escaped .. '%s*:[^;]*;', ';')
    end
    return result:gsub('^;%s*', '')
  end
  local function css_string(value)
    return '"' .. tostring(value or '')
      :gsub('\\', '\\\\')
      :gsub('"', '\\"') .. '"'
  end
  -- Quarto links the project stylesheet after header-includes. Theme-shell
  -- rules therefore need a narrowly-scoped priority lift, otherwise the
  -- generic site title / TOC style wins despite a correctly rendered filter.
  local function important(style)
    return (style or ''):gsub('([^;]+);', function(declaration)
      return declaration .. '!important;'
    end)
  end
  local mapped = {code_inline=' :not(pre) > code', code_block=' pre',
    caption=' figcaption', section_divider=' .section-divider',
    description=' .article-description'}
  local headings = {h1=true, h2=true, h3=true, h4=true, h5=true, h6=true}
  for key, style in pairs(theme.styles) do
    if key ~= 'li_bullet_char' and key ~= 'li_bullet' and key ~= 'li_number' then
      if key == 'body' then
        -- A WeChat theme's full-page background becomes a conspicuous colour
        -- band when transplanted into Quarto's centred reading column. Keep
        -- the theme's typography and spacing, but let the website's paper
        -- surface run continuously behind the whole article.
        local website_body = without_properties(style, {'background', 'padding'})
        rule(frame_scope, website_body ..
          'background:transparent;min-width:0;max-width:100%;box-sizing:border-box;' ..
          '--article-accent:' .. shell.accent .. ';--article-muted:' .. shell.muted ..
          ';--article-soft:' .. shell.soft .. ';--article-rule:' .. shell.rule .. ';')
      elseif headings[key] then
        rule(heading_scope .. key .. '.article-heading' .. theme_attr,
          style .. 'max-width:100%;box-sizing:border-box;text-wrap:balance;')
      else
        rule(scope .. (mapped[key] or (' ' .. key)), style)
      end
    end
  end
  -- Shared reading safeguards sit beneath each theme's visual language. They
  -- keep long URLs, data labels, code, and tables usable on narrow screens
  -- without flattening the sixteen distinct palettes and type systems.
  rule(scope, 'min-width:0;')
  rule(scope .. ' p, ' .. scope .. ' li, ' .. scope .. ' td, ' .. scope .. ' th, ' .. scope .. ' a',
    'overflow-wrap:anywhere;word-break:normal;')
  rule(scope .. ' pre, ' .. scope .. ' table, ' .. scope .. ' img', 'max-width:100%;')
  rule(scope .. ' a:focus-visible', 'outline:2px solid currentColor;outline-offset:3px;border-radius:2px;')
  table.insert(css, '@media (max-width: 767px){' ..
    scope .. ' pre{margin-inline:0;padding:14px;font-size:12px;}' ..
    scope .. ' table{font-size:13px;}' ..
    scope .. ' th,' .. scope .. ' td{padding:9px 7px;}' ..
    '}')
  -- Native HTML list markers preserve numbering, nested lists, and accessibility.
  rule(scope .. ' ul', 'list-style:disc;padding-left:1.6em;')
  rule(scope .. ' ol', 'list-style:decimal;padding-left:1.6em;')
  rule(scope .. ' li::marker', theme.styles.li_number)
  rule(scope .. ' pre code', 'background:transparent;color:inherit;border:0;padding:0;')
  rule(scope .. ' .sourceCode', 'background:transparent;')
  rule(scope .. ' th, ' .. scope .. ' td', 'background-color:inherit;')
  rule(scope .. ' th', theme.styles.th)
  for key, style in pairs(theme.highlights or {}) do rule(scope .. ' .' .. key, style) end
  for key, style in pairs(theme.code_colors or {}) do rule(scope .. ' code .' .. key, style) end
  -- The website shell gives each source theme an intentional page-level
  -- identity without moving its WeChat canvas background into the reading
  -- column. The source JSON remains the authority for article-body typography.
  rule(frame_scope .. ' .article-author-block', 'border-bottom-color:var(--article-rule);')
  rule(frame_scope .. ' .article-author-name', 'color:var(--article-accent);')
  rule(frame_scope .. ' .article-author-focus', 'color:var(--article-accent);')
  rule(frame_scope .. ' .article-author-date, ' .. frame_scope .. ' .article-author-reading', 'color:var(--article-muted);')
  rule(frame_scope .. ' .article-author-avatar', 'background-color:var(--article-accent);box-shadow:0 0 0 3px #fff,0 4px 14px color-mix(in srgb,var(--article-accent) 20%,transparent);')
  -- The old continuous frame also supplied an inset. Apply it to each themed
  -- section, rather than nesting headings under a non-TOC wrapper.
  rule(scope, 'padding-inline:clamp(0.75rem,2vw,1.375rem);box-sizing:border-box;')
  rule(heading_scope .. '.article-heading' .. theme_attr, 'margin-inline:clamp(0.75rem,2vw,1.375rem);')
  rule(scope .. ' .article-description', shell.description)
  rule(scope .. ' figcaption', 'color:var(--article-muted);')
  rule(scope .. ' img', shell.image)
  -- Quarto owns the link-level active border that indicates reading progress.
  -- Do not add a second full-height theme border beside it.
  rule('#TOC .nav-link', 'color:var(--article-muted)!important;')
  rule('#TOC .nav-link.active, #TOC .nav-link:hover', 'color:var(--article-accent)!important;')
  -- Page titles belong to the Quarto site shell, not the WeChat canvas. Theme
  -- fonts use different `ch` metrics and some h1 styles carry alignment,
  -- padding, borders, or fills; inheriting those layout properties made title
  -- blocks appear at inconsistent widths. Retain typographic character only.
  local website_title = without_properties(theme.styles.h1, {
    'font-size', 'margin', 'padding', 'text-align', 'display', 'width',
    'min-width', 'max-width', 'background', 'border', 'border-top',
    'border-right', 'border-bottom', 'border-left', 'border-radius',
  })
  rule('main.content > header#title-block-header .quarto-title .title',
    website_title .. 'display:block;width:100%;max-width:none;box-sizing:border-box;' ..
    'text-align:left;background:transparent;border:0;border-radius:0;' ..
    'font-size:clamp(2rem, 4.5vw, 3.35rem);margin:0 0 0.75rem;padding:0;text-wrap:balance;' ..
    important(shell.title))
  rule('main.content > header#title-block-header', important(shell.header))
  rule('main.content > header#title-block-header::before',
    'content:' .. css_string(shell.kicker) .. '!important;' .. important(shell.kicker_style))
  if doc.meta['show-title-block'] == false then
    rule('main.content > header#title-block-header', 'display:none;')
  end

  -- Unified author block + description block. Injected as siblings *outside*
  -- .article-body so they keep one consistent look regardless of article-theme.
  local function meta_text(key)
    local value = doc.meta[key]
    if value == nil then return nil end
    local text = pandoc.utils.stringify(value)
    if text == '' then return nil end
    return text
  end
  local function escape_html(value)
    return tostring(value)
      :gsub('&', '&amp;')
      :gsub('<', '&lt;')
      :gsub('>', '&gt;')
      :gsub('"', '&quot;')
  end
  local function format_date(value)
    if not value then return nil end
    local y, m, d = value:match('^(%d%d%d%d)%-(%d%d?)%-(%d%d?)$')
    if y then
      return y .. '年' .. tonumber(m) .. '月' .. tonumber(d) .. '日'
    end
    return value
  end
  -- Count CJK ideographs as characters and Latin/numeric runs as words. The
  -- reader-facing total intentionally excludes standalone code blocks.
  local function reading_stats(blocks)
    local readable = pandoc.Blocks({})
    for _, block in ipairs(blocks) do
      if block.t ~= 'CodeBlock' and block.t ~= 'RawBlock' then
        readable:insert(block)
      end
    end
    local text = pandoc.utils.stringify(readable)
    local cjk, non_cjk = 0, {}
    for _, codepoint in utf8.codes(text) do
      if (codepoint >= 0x3400 and codepoint <= 0x4DBF) or
          (codepoint >= 0x4E00 and codepoint <= 0x9FFF) or
          (codepoint >= 0xF900 and codepoint <= 0xFAFF) then
        cjk = cjk + 1
      else
        table.insert(non_cjk, utf8.char(codepoint))
      end
    end
    local terms = 0
    for _ in table.concat(non_cjk):gmatch('[%a%d]+') do terms = terms + 1 end
    local units = cjk + terms
    if units == 0 then return nil, nil end
    return units, math.max(1, math.ceil(units / 400))
  end
  local function format_number(value)
    return tostring(value):reverse():gsub('(%d%d%d)', '%1,'):reverse():gsub('^,', '')
  end

  local author = meta_text('author')
  local author_focus = meta_text('author-focus')
  local date = format_date(meta_text('date'))
  -- `date-modified` is Quarto's listing-aware field. Retain the older spelling
  -- as a read-only fallback so historical articles do not lose their update label.
  local date_modified = format_date(meta_text('date-modified') or meta_text('last-modified'))
  local description = meta_text('description') or meta_text('abstract')
  local reading_units, reading_minutes = reading_stats(doc.blocks)

  local pre = pandoc.Blocks({})
  local author_block
  if author or author_focus or date or date_modified then
    local inner = {}
    table.insert(inner, '<span class="article-author-avatar" role="img" aria-label="' .. escape_html(author or '') .. '"></span>')
    table.insert(inner, '<div class="article-author-meta">')
    if author then
      table.insert(inner, '<span class="article-author-name">' .. escape_html(author) .. '</span>')
    end
    if author_focus then
      table.insert(inner, '<span class="article-author-focus">' .. escape_html(author_focus) .. '</span>')
    end
    local dates = {}
    if date then table.insert(dates, '发布于 ' .. date) end
    if date_modified then table.insert(dates, '更新于 ' .. date_modified) end
    if #dates > 0 then
      table.insert(inner, '<span class="article-author-date">' .. escape_html(table.concat(dates, ' · ')) .. '</span>')
    end
    if reading_units then
      table.insert(inner, '<span class="article-author-reading">约 ' .. format_number(reading_units) .. ' 字 · 预计 ' .. reading_minutes .. ' 分钟阅读</span>')
    end
    table.insert(inner, '</div>')
    author_block = pandoc.RawBlock('html', '<div class="article-author-block" data-article-theme="' .. name .. '">' .. table.concat(inner, '') .. '</div>')
    rule('main.content > header .quarto-title-meta', 'display:none !important;')
  end
  if description then
    rule('main.content > header .description', 'display:none !important;')
    -- The inner <p> must not inherit the theme's text-indent / justify; it
    -- takes its typography from the .article-description container instead.
    rule(scope .. ' .article-description p', 'margin:0;text-indent:0;text-align:inherit;color:inherit;font-size:inherit;line-height:inherit;letter-spacing:inherit;')
  end

  local includes = doc.meta['header-includes'] or pandoc.MetaList({})
  includes:insert(pandoc.MetaBlocks({pandoc.RawBlock('html', '<style>\n' .. table.concat(css, '\n') .. '\n</style>')}))
  doc.meta['header-includes'] = includes

  -- Keep real Header nodes at document level for Quarto's TOC collector. Body
  -- regions are still split for scoped article-theme rules.
  local body, out = pandoc.Blocks({}), pandoc.Blocks({})
  local description_block
  if description then
    description_block = pandoc.RawBlock('html', '<div class="article-description"><p>' .. escape_html(description) .. '</p></div>')
  end
  local description_inserted = false
  -- When the body opens with a heading, the description must still appear
  -- *before* that heading. Prepend it as its own .article-body so it keeps the
  -- article-theme scope and stays ahead of the first section.
  if description_block and #doc.blocks > 0 and doc.blocks[1].t == 'Header' then
    out:insert(pandoc.Div(
      pandoc.Blocks({description_block}),
      pandoc.Attr('', {'article-body'}, {['data-article-theme'] = name})
    ))
    description_inserted = true
  end
  for _, blk in ipairs(doc.blocks) do
    if blk.t == 'Header' then
      if #body > 0 then
        out:insert(pandoc.Div(body, pandoc.Attr('', {'article-body'}, {['data-article-theme']=name})))
        body = pandoc.Blocks({})
      end
      blk.classes:insert('article-heading')
      blk.attributes['data-article-theme'] = name
      out:insert(blk)
    else
      if description_block and not description_inserted then
        body:insert(description_block)
        description_inserted = true
      end
      body:insert(blk)
    end
  end
  if #body > 0 then
    out:insert(pandoc.Div(body, pandoc.Attr('', {'article-body'}, {['data-article-theme']=name})))
  end
  if author_block then pre:insert(author_block) end
  for _, blk in ipairs(out) do pre:insert(blk) end
  doc.blocks = pre
  return doc
end
