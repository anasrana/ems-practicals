-- EMS practicals: book-specific HTML markup, run after Quarto's
-- cross-referencing (at: post-render), so exercise numbers are known.
--   1. Exercise titles: "exercise 1.1 (Replacement)" becomes a small-caps
--      label line and an italic title line (design decision 1A).
--   2. [[solution](page.qmd#id)]{.solution-link}: red arrow box that turns
--      into the tadpole on hover (option I).
--   3. [@exr-id]{.back-link} or [[text](page.qmd#id)]{.back-link}: grey
--      "back to exercise 1.1" box pointing left.
--   4. [[download data](data-sets.qmd#id)]{.data-link}: quiet text link.
--   6. Moves the page footer (colophon) to just below the prev/next links,
--      in the text column; without JavaScript it stays in Quarto's footer.
--   5. A small frog + "Anas A Rana" link to the homepage at the top of each
--      page, shown on phones only (ems.scss moves it above the title).
if not quarto.doc.is_format("html") then return {} end

local tadpole
local exr_index = {}

-- exercise id -> "3.2", written by _exercise-index.R before each render
local function read_index()
  local f = io.open(quarto.project.directory .. "/_exercise-index.tsv")
  if not f then return end
  for line in f:lines() do
    local id, _, num = line:match("^(%S+)\t(%S+)\t(%S+)$")
    if id then exr_index[id] = num end
  end
  f:close()
end

local function read_tadpole()
  local f = io.open(quarto.project.directory .. "/_extensions/anasrana/tufte-brand/logo/tadpole.svg")
  if not f then return "" end
  local svg = f:read("a"):gsub("%s+$", "")
  f:close()
  return (svg:gsub("<title>.-</title>", ""):gsub(' role="img"', ' aria-hidden="true" focusable="false"'))
end

local function read_frog()
  local f = io.open(quarto.project.directory .. "/_extensions/anasrana/tufte-brand/logo/logo.svg")
  if not f then return "" end
  local svg = f:read("a"):gsub("%s+$", "")
  f:close()
  return (svg:gsub("<title>.-</title>", ""):gsub(' role="img"', ' aria-hidden="true" focusable="false"'))
end

local function esc(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub('"', "&quot;"))
end

-- 1. Exercise titles ---------------------------------------------------------

local function exercise_title(div)
  if not div.classes:includes("exercise") then return nil end
  local first = div.content[1]
  if not first or first.t ~= "Para" then return nil end
  local head = first.content[1]
  if not (head and head.t == "Span" and head.classes:includes("theorem-title")) then return nil end
  local text = pandoc.utils.stringify(head.content)
  local label, title = text:match("^(.-)%s*%((.*)%)%s*$")
  label = label or text
  local header = { pandoc.Span(pandoc.Str(label), { class = "exr-label" }) }
  if div.classes:includes("challenge") then
    header[#header + 1] = pandoc.Span(pandoc.Str("challenge"), { class = "exr-challenge" })
  end
  local headdiv = pandoc.Div({ pandoc.Para(header) }, { class = "exr-head" })
  if title then
    headdiv.content:insert(pandoc.Para({ pandoc.Span(pandoc.Str(title), { class = "exr-title" }) }))
  end
  local rest = pandoc.List({})
  for i = 2, #first.content do rest:insert(first.content[i]) end
  while #rest > 0 and (rest[1].t == "Space" or rest[1].t == "SoftBreak") do rest:remove(1) end
  local out = pandoc.List({ headdiv })
  if #rest > 0 then out:insert(pandoc.Para(rest)) end
  for i = 2, #div.content do out:insert(div.content[i]) end
  div.content = out
  return div
end

-- 2-4. Links -------------------------------------------------------------------

local function first_link(span)
  local link
  span:walk({ Link = function(l) if not link then link = l end end })
  return link
end

local function link_span(span)
  local kind = (span.classes:includes("solution-link") and "solution")
    or (span.classes:includes("back-link") and "back")
    or (span.classes:includes("data-link") and "data")
  if not kind then return nil end
  local link = first_link(span)
  if not link then return nil end
  local target = link.target:gsub("%.qmd#", ".html#"):gsub("%.qmd$", ".html")
  local href = esc(target)
  if kind == "solution" then
    return pandoc.RawInline("html", '<span class="solink"><a href="' .. href .. '"><span>solution</span>'
      .. '<span class="swap"><span class="arr" aria-hidden="true">→</span>' .. tadpole .. "</span></a></span>")
  elseif kind == "back" then
    local text = pandoc.utils.stringify(link.content):gsub("^%u", string.lower)
    local id = target:match("#(exr%-[%w_-]+)$")
    if id then text = "exercise " .. (exr_index[id] or "") end
    return pandoc.RawInline("html", '<span class="backlink"><a href="' .. href .. '">'
      .. '<span class="swap"><span class="arr" aria-hidden="true">←</span>' .. tadpole .. "</span>"
      .. "<span>back to " .. esc(text) .. "</span></a></span>")
  else
    return pandoc.RawInline("html", '<span class="datalink"><a href="' .. href .. '">'
      .. esc(pandoc.utils.stringify(link.content)) .. " →</a></span>")
  end
end

function Pandoc(doc)
  tadpole = read_tadpole()
  read_index()
  doc.blocks = doc.blocks:walk({ Span = link_span })
  doc.blocks = doc.blocks:walk({ Div = exercise_title })
  doc.blocks:insert(1, pandoc.RawBlock("html",
    '<div class="mobile-home"><a href="https://anasrana.github.io/"><span class="home-frog">'
    .. read_frog() .. "</span>Anas A Rana</a></div>"))
  doc.blocks:insert(pandoc.RawBlock("html", [[<script>
document.addEventListener("DOMContentLoaded", function () {
  var left = document.querySelector("footer.footer .nav-footer-left");
  var nav = document.querySelector("nav.page-navigation");
  if (!left || !nav) return;
  var f = document.createElement("div");
  f.className = "ems-colophon";
  f.innerHTML = left.innerHTML;
  nav.after(f);
  document.querySelector("footer.footer").remove();
});
</script>]]))
  return doc
end
