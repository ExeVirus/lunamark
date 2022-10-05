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

md2f.mp = "C:/Users/ddsal/Desktop/Minetest/minetest-5.6.1-win64/mods/markdown2formspec2"

local parse = dofile(md2f.mp .. "/markdown2formspec/parse.lua")

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
    return table.concat({"hypertext[",x,",",y,";",w,",",h,";",name,";",parse(text,settings),"]"})
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

to_parse = [=[
# Level 1
## Level 2
### Level 3
#### Level 4
##### Level 5
###### Level 6

Paragraph 1 is a test paragaph, hopefully this is long enough to justify going to the next few lines.

This is another paragraph, should have worked.

```
int a = 5;
std::cout << a << std::endl;
```

**Bold Text**

*Italics Text*

***Bold and Italics***

> Block quote attempt

> Multiline, and multi paragraph
>
> Block Quote

1. Numbers will
3. Be Somewhat difficult
2. To support

- Unordered
- Lists
- Should be a breeze, hopefully
* Personally, 
* I think this should start a new 
* list set


`test`
`test`

![24,24](text)
![36,36](text2)
![48,48](text3)

Nested `code text` should be monospaced

These

--- 

Should

*** 

All be lines

_______

<htts://www.google.com>

----------
----------

]=]

-- Opens a file in append mode
file = io.open(md2f.mp .. "/example.spec", "w+")

-- appends a word test to the last line of the file
file:write(md2f.header()..md2f.md2f(1,1,18,18,to_parse,nil))

-- closes the open file
io.close(file)