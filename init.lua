--                    _       _                     ____    ___                                         ____ 
--   /\/\   __ _ _ __| | ____| | _____      ___ __ |___ \  / __\__  _ __ _ __ ___  ___ _ __   ___  ___ |___ \
--  /    \ / _` | '__| |/ / _` |/ _ \ \ /\ / / '_ \  __) |/ _\/ _ \| '__| '_ ` _ \/ __| '_ \ / _ \/ __|  __) |
-- / /\/\ \ (_| | |  |   < (_| | (_) \ V  V /| | | |/ __// / | (_) | |  | | | | | \__ \ |_) |  __/ (__ |/ __/
-- \/    \/\__,_|_|  |_|\_\__,_|\___/ \_/\_/ |_| |_|_____\/   \___/|_|  |_| |_| |_|___/ .__/ \___|\___||_____\
--                                                                                    |_|              
--
-- Markdown2Formspec2 (md2f)
-- MIT License
-- Copyright ExeVirus 2022
--

-----------------------------------------------------------------------
----------------------------global namespace---------------------------
md2f = {}

local parse = require("markdown2formspec/parse")

-- md2f()
--
-- x: position of hypertext[] element
-- y: position of hypertext[] element
-- w: width of hypertext element. roughly 60 pixels per 1 unit
-- h: height of hypertext element. Scrollbar appears when it overflows
-- text: markdown text to convert
-- name: optional name for hypertext element
-- settings: color and sizing config table of settings
md2f.md2f = function(x,y,w,h,text,name,settings)
    if text == nil then
        minetest.log("markdown2formspec: No text provided")
        return ""
    end
    name = name or "markdown"
    settings = settings or {}
    settings.width = w
    settings.height = h
    return "hypertext["..x..","..y..";"..w..","..h..";"..name..";"..parse(text,settings).."]"
end

-- md2ff()
--
-- x: position of hypertext[] element
-- y: position of hypertext[] element
-- w: width of hypertext element. roughly 60 pixels per 1 unit
-- h: height of hypertext element. Scrollbar appears when it overflows
-- file: exact name and location of the markdown file to convert
-- name: optional name for hypertext element
-- settings: color and sizing config table of settings
md2f.md2ff = function(x,y,w,h,filename,name,settings)
    local text = loadFile(filename)
    return md2f.md2f(x,y,w,h,text,name,settings)
end

-- header()
--
-- Default formspec header for the lazy
md2f.header = function()
	return "formspec_version[4]size[20,20]position[0.5,0.5]bgcolor[#111E]\n"
end