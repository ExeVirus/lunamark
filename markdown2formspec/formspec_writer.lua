-- (c) 2022 Dallas DeBruin. Released under MIT license.
-- See the file LICENSE in the source for details.

--- Formspec Hypetext writer for Minetest
-- It extends [lunamark.writer.generic]

local M = {}

local generic = require("../lunamark.writer.generic")
local util = require("../lunamark.util")

--- Returns a new Hypertext writer.
-- For a list of fields, see [lunamark.writer.generic].
function M.new(options, settings)
  options = options or {}
  local Hyper = generic.new(options)

  local escape = util.escaper {
    ["<"] = "\\<",
    [";"] = "\\\\;",
    ["]"] = "\\\\]",
  }

  Hyper.string = escape

  Hyper.citation = escape

  Hyper.code = escape

  Hyper.hrule = "<img name=md2f_line.png width="..(60*settings.width).." height=4>"

  return Hyper
end

return M
