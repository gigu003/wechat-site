-- 统计各栏目文章数，并把 <!--COUNT:<key>--> 占位符替换为对应数量。
-- 在 _quarto.yml 中全局注册，占位符仅出现在栏目列表页；
-- 首页自定义 listing 的数字由 EJS 模板在构建时直接统计。
-- 文章数 = main/<栏目>/ 目录下所有 index.qmd 的数量，与栏目 listing 的
-- `../main/<栏目>/**/index.qmd` 范围一致，新增文章后无需手工维护。

local SECTIONS = {
  ['cancer-registry'] = 'main/cancer-registry',
  ['daily-r'] = 'main/daily-r',
  ['medical-popular-science'] = 'main/medical-popular-science',
}

local function count_articles(rel_dir)
  -- resolve_path 相对于扩展的 filters/ 目录解析，因此用 ../../../ 回到项目根。
  local abs = quarto.utils.resolve_path('../../../' .. rel_dir)
  local safe = abs:gsub("'", "'\\''")
  local cmd = "find '" .. safe .. "' -name index.qmd -type f 2>/dev/null | wc -l"
  local pipe = io.popen(cmd)
  if not pipe then
    return 0
  end
  local out = pipe:read('*a')
  pipe:close()
  return tonumber(out:match('%d+')) or 0
end

local function replace(s, counts)
  return (s:gsub('<!%-%-COUNT:([%w%-]+)%-%->', function(key)
    return tostring(counts[key] or 0)
  end))
end

function Pandoc(doc)
  if not FORMAT:match('html') then
    return doc
  end

  local counts = {}
  for key, rel in pairs(SECTIONS) do
    counts[key] = count_articles(rel)
  end

  local filter = {
    Str = function(el)
      local t = replace(el.text, counts)
      if t == el.text then return nil end
      return pandoc.Str(t)
    end,
    RawInline = function(el)
      local t = replace(el.text, counts)
      if t == el.text then return nil end
      return pandoc.RawInline(el.format, t)
    end,
    RawBlock = function(el)
      local t = replace(el.text, counts)
      if t == el.text then return nil end
      return pandoc.RawBlock(el.format, t)
    end,
  }

  local out = pandoc.Blocks({})
  for _, blk in ipairs(doc.blocks) do
    out:insert(pandoc.walk_block(blk, filter))
  end
  doc.blocks = out
  return doc
end
