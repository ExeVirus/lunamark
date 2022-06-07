-- (c) 2022 Dallas DeBruin. Released under MIT license.
-- See the file LICENSE in the source for details.

--- Formspec Hypetext writer for Minetest
-- It extends [lunamark.writer.generic]

local M = {}
local inspect = require("../markdown2formspec/inspect")

local generic = require("../lunamark.writer.generic")
local util = require("../lunamark.util")

--- Returns a new Hypertext writer.
-- For a list of fields, see [lunamark.writer.generic].
function M.new(options, settings)
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
    return {"<mono><style color=",settings.mono_color,">",escape(s),"</style></mono>"}
  end

  function Hyper.fenced_code(s)
    return {"<mono><style color=",settings.code_block_mono_color," size=",settings.code_block_mono_size,">",escape(s),"</style></mono>"}
  end
  
  function Hyper.start_document()
    return "<global background="..settings.background_color.." color="..settings.font_color..">"..Hyper.linebreak
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
    return {"<style size=", settings["heading_"..level.."_size"] .. " color=" .. settings["heading_"..level.."_color"] .. ">", s, "</style>"}
  end

  function Hyper.blockquote(s)
    return {"<img name=md2f_line.png width="..(38*settings.width).." height=5>",Hyper.linebreak,
            "<style color=", settings.block_quote_color,">", s, "</style>",Hyper.linebreak,"<img name=md2f_line.png width="..(38*settings.width).." height=5>"}
  end

  function Hyper.bulletlist(items,tight)
    for i,str in ipairs(items) do
      table.insert(str, 1, "  •  ")
    end
    return util.intersperse(items,Hyper.linebreak)
  end

  function Hyper.orderedlist(items,tight)
    for i,str in ipairs(items) do
      table.insert(str, 1, " "..i..".  ")
    end
    return util.intersperse(items,Hyper.linebreak)
  end

  function Hyper.link(label, uri, title)
    return {"<u>",label,"</u>", " (<style color=",settings.link_color,">" , uri, "</style>) "}
  end

  function Hyper.image(label, src, title)
    --parse the minetest data from the filename:
    local _,_,w,h,float = label[1]:find("(%d*),?(%d*),?([lr]*)")
    local _,_,filename = src:find("([%w%p]*)")
    local image = "<img name="..filename
    if filename:find("item:///.*") then
        image = "<item name="..string.sub(filename,9,-1)
    end
    if float == "l" then
      image = image .. " float=left"
    elseif float == "r" then
      image = image .. " float=right"
    end
    if w ~= "" and h ~= "" then
      image = image.." width="..w.." height="..h..">"
    else
      image = image..">"
    end
    return {"<global halign=center>",Hyper.linebreak,image,"<global halign=left>",Hyper.linebreak}
  end

  Hyper.hrule = "<img name=md2f_line.png width="..(45*settings.width).." height=4>"

  return Hyper
end

return M
