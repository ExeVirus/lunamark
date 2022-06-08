-- (c) 2022 Dallas DeBruin. Released under MIT license.
-- See the file LICENSE in the source for details.

--- Formspec Hypetext writer for Minetest
-- It extends [lunamark.writer.generic]

local M = {}

local generic = require("../lunamark.writer.generic")
local util = require("../lunamark.util")

--- Returns a new Hypertext writer.
-- For a list of fields, see [lunamark.writer.generic].
function M.new(options)
  local md2f = md2f
  options = options or {}
  local Hyper = generic.new(options)

  local escape = util.escaper {
    ["<"] = "\\<",
    [";"] = "\\;",
    ["]"] = "\\]",
  }

  Hyper.interblocksep = "\n"

  Hyper.string = escape
  Hyper.citation = escape
  function Hyper.code(s)
    return {"<mono><style color=",md2f.settings.mono_color,">",escape(s),"</style></mono>"}
  end

  function Hyper.fenced_code(s)
    return {"<mono><style color=",md2f.settings.code_block_mono_color," size=",md2f.settings.code_block_mono_size,">",escape(s),"</style></mono>"}
  end
  
  function Hyper.start_document()
    return {"<global background=",md2f.settings.background_color," color=",md2f.settings.font_color,">",Hyper.linebreak}
  end

  function Hyper.emphasis(s)
    return {"<i>",s,"</i>"}
  end

  function Hyper.strong(s)
    return  {"<b>",s,"</b>"}
  end

  function Hyper.strong_emphasis(s)
    return {"<b><i>",s,"</b></i>"}
  end

  function Hyper.header(s,level)
    return {"<style size=",md2f.settings[table.concat({"heading_",level,"_size"})]," color=",md2f.settings[table.concat({"heading_",level,"_color"})],">",s,"</style>"}
  end

  function Hyper.blockquote(s)
    return {"<img name=md2f_line.png width=",38*md2f.settings.width," height=5>",Hyper.linebreak,
            "<style color=",md2f.settings.block_quote_color,">", s, "</style>",Hyper.linebreak,"<img name=md2f_line.png width=",38*md2f.settings.width," height=5>"}
  end

  function Hyper.bulletlist(items,tight)
    for i,str in ipairs(items) do
      table.insert(str, 1, "  •  ")
    end
    return util.intersperse(items,Hyper.linebreak)
  end

  function Hyper.orderedlist(items,tight)
    for i,str in ipairs(items) do
      table.insert(str, 1, table.concat({" ",i,".  "}))
    end
    return util.intersperse(items,Hyper.linebreak)
  end

  function Hyper.link(label, uri, title)
    return {"<u>",label,"</u>", " (<style color=",md2f.settings.link_color,">" , uri, "</style>) "}
  end

  function Hyper.image(label, src, title)
    --parse the minetest data from the filename:
    local _,_,w,h,float = label[1]:find("(%d*),?(%d*),?([lr]*)")
    local _,_,filename = src:find("([%w%p]*)")
    local image = table.concat({"<img name=",filename})
    if filename:find("item:///.*") then
        image = table.concat({"<item name=",string.sub(filename,9,-1)})
    end
    if float == "l" then
      image = table.concat({image," float=left"})
    elseif float == "r" then
      image = table.concat({image," float=right"})
    end
    if w ~= "" and h ~= "" then
      image = table.concat({image," width=",w," height=",h,">"})
    else
      image = table.concat({image,">"})
    end
    return {"<global halign=center>",Hyper.linebreak,image,"<global halign=left>",Hyper.linebreak}
  end

  Hyper.hrule = function() return table.concat({"<img name=md2f_line.png width=",45*md2f.settings.width," height=4>"}) end

  return Hyper
end

return M
