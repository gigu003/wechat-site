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
  -- Descriptions are a shared reading component. Theme JSON supplies the
  -- accent/soft/muted tokens above; the card itself stays readable in both
  -- modes instead of inheriting each theme's light-only hard-coded colours.
  rule(scope .. ' .article-description',
    'max-width:76ch;box-sizing:border-box;margin:0 0 1.75rem;padding:1rem 1.25rem;' ..
    'border:1px solid color-mix(in srgb,var(--article-accent) 18%,transparent);' ..
    'border-inline-start:0.3rem solid var(--article-accent);border-radius:0 0.75rem 0.75rem 0;' ..
    'background:var(--article-soft);' ..
    'background:linear-gradient(135deg,color-mix(in srgb,var(--article-soft) 88%,var(--puai-paper, #fcfdfb)),var(--puai-paper, #fcfdfb));' ..
    'color:var(--article-muted);font-size:0.98rem;line-height:1.8;overflow-wrap:anywhere;')
  rule(scope .. ' .article-description p',
    'max-width:none;margin:0;color:inherit!important;font-size:inherit;line-height:inherit;' ..
    'text-align:left;text-indent:0;letter-spacing:inherit;overflow-wrap:anywhere;')
  table.insert(css,
    'body.quarto-dark ' .. scope .. ' .article-description{' ..
    'border-color:color-mix(in srgb,var(--article-accent) 38%,rgba(187,220,203,.18))!important;' ..
    'border-inline-start-color:var(--article-accent)!important;' ..
    'background:linear-gradient(135deg,color-mix(in srgb,var(--article-accent) 13%,#172823),#172823)!important;' ..
    'color:#dbe9e2!important;box-shadow:0 0.5rem 1.25rem rgba(0,0,0,.16);}' ..
    'body.quarto-dark ' .. scope .. ' .article-description p{color:#dbe9e2!important;}')
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
  local wechat_link = meta_text('wechat-link')
  if wechat_link and not wechat_link:match('^https?://') then
    error('Invalid wechat-link: expected an http(s) URL')
  end
  local reading_units, reading_minutes = reading_stats(doc.blocks)

  local pre = pandoc.Blocks({})
  local author_block
  if author or author_focus or date or date_modified then
    local inner = {}
    table.insert(inner,
      '<img class="article-author-avatar" src="/site_libs/quarto-contrib/quarto-project/wechat/assets/brand/author-avatar-small.png"' ..
      ' srcset="/site_libs/quarto-contrib/quarto-project/wechat/assets/brand/author-avatar-small.png 96w,' ..
      ' /site_libs/quarto-contrib/quarto-project/wechat/assets/brand/author-avatar-medium.png 192w,' ..
      ' /site_libs/quarto-contrib/quarto-project/wechat/assets/brand/author-avatar-large.png 384w"' ..
      ' sizes="(max-width: 767px) 48px, 58px" width="192" height="192"' ..
      ' alt="' .. escape_html(author or '作者头像') .. '" decoding="async">')
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
  end
  -- A real WeChat article URL is opt-in per article. Keep the bridge visually
  -- quiet and scoped to the article body so the website can link back without
  -- changing the shared footer or the WeChat export.
  rule(scope .. ' .wechat-article-link',
    'position:relative;display:flex;align-items:center;justify-content:space-between;gap:1rem;' ..
    'margin:0 0 1.6rem;padding:0.9rem 1rem 0.9rem 1.15rem;border:1px solid color-mix(in srgb,var(--article-accent) 24%,transparent);' ..
    'border-radius:0.75rem;background:linear-gradient(135deg,color-mix(in srgb,var(--article-soft) 84%,transparent),color-mix(in srgb,var(--article-rule) 24%,transparent));' ..
    'color:var(--article-accent);text-decoration:none;box-shadow:0 0.45rem 1.1rem color-mix(in srgb,var(--article-accent) 8%,transparent);' ..
    'overflow:hidden;transition:transform 180ms ease,box-shadow 180ms ease,border-color 180ms ease;')
  rule(scope .. ' .wechat-article-link::before',
    'position:absolute;inset:0 auto 0 0;width:0.25rem;background:var(--article-accent);content:"";')
  rule(scope .. ' .wechat-article-link:hover, ' .. scope .. ' .wechat-article-link:focus-visible',
    'transform:translateY(-1px);border-color:var(--article-accent);box-shadow:0 0.5rem 1.25rem color-mix(in srgb,var(--article-accent) 12%,transparent);')
  rule(scope .. ' .wechat-article-link:focus-visible', 'outline:2px solid currentColor;outline-offset:3px;')
  rule(scope .. ' .wechat-article-link-copy', 'position:relative;z-index:1;display:flex;flex-direction:column;gap:0.18rem;min-width:0;')
  rule(scope .. ' .wechat-article-link-kicker', 'font-size:0.68rem;letter-spacing:0.1em;font-weight:700;opacity:0.72;')
  rule(scope .. ' .wechat-article-link-label', 'font-size:0.92rem;font-weight:650;line-height:1.45;')
  rule(scope .. ' .wechat-article-link-action', 'position:relative;z-index:1;flex:0 0 auto;font-size:0.78rem;font-weight:700;white-space:nowrap;')
  table.insert(css, '@media (max-width: 480px){' ..
    scope .. ' .wechat-article-link{align-items:flex-start;}' ..
    scope .. ' .wechat-article-link-action{padding-top:0.2rem;}' ..
    '}')

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
  local wechat_link_block
  if wechat_link then
    wechat_link_block = pandoc.RawBlock('html',
      '<a class="wechat-article-link" href="' .. escape_html(wechat_link) ..
      '" target="_blank" rel="noopener noreferrer" aria-label="在微信公众号中阅读本文">' ..
      '<span class="wechat-article-link-copy">' ..
      '<span class="wechat-article-link-kicker">微信公众号原文</span>' ..
      '<span class="wechat-article-link-label">在微信中阅读本文</span>' ..
      '</span><span class="wechat-article-link-action">打开原文 ↗</span></a>')
  end
  local description_inserted = false
  local wechat_link_inserted = false
  local function insert_wechat_link(blocks)
    if wechat_link_block and not wechat_link_inserted then
      blocks:insert(wechat_link_block)
      wechat_link_inserted = true
    end
  end
  -- When the body opens with a heading, the description must still appear
  -- *before* that heading. Prepend it as its own .article-body so it keeps the
  -- article-theme scope and stays ahead of the first section.
  if description_block and #doc.blocks > 0 and doc.blocks[1].t == 'Header' then
    local intro = pandoc.Blocks({description_block})
    insert_wechat_link(intro)
    out:insert(pandoc.Div(
      intro,
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
        insert_wechat_link(body)
      end
      body:insert(blk)
    end
  end
  -- Articles without a description still get the bridge, after their final
  -- body section. Articles with a description have already inserted it above.
  if wechat_link_block and not wechat_link_inserted then
    body:insert(wechat_link_block)
  end
  if #body > 0 then
    out:insert(pandoc.Div(body, pandoc.Attr('', {'article-body'}, {['data-article-theme']=name})))
  end
  if author_block then pre:insert(author_block) end
  for _, blk in ipairs(out) do pre:insert(blk) end
  doc.blocks = pre
  return doc
end
