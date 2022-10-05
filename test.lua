--local lunamark = require("lunamark")
--local writer = lunamark.writer.html.new()
--local parse = lunamark.reader.markdown.new(writer, { smart = false })
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

dofile("init.lua")
-- print(md2f.header()..md2f.md2f(1,1,18,18,[[
-- # Level 1
-- ## Level 2
-- ### Level 3
-- #### Level 4
-- ##### Level 5
-- ###### Level 6




-- Paragraph 1 is a test paragaph, hopefully this is long enough to justify going to the next few lines.




-- This is another paragraph, should have worked.

--     Testing
--     This is a test


-- ```
-- int a = 5;
-- std::cout << a << std::endl;
-- ```

-- **Bold Text**

-- *Italics Text*

-- ***Bold and Italics***

-- ****Ultra Bold and Italics****

-- > Block quote attempt
-- > Multiline, and multi paragraph attemping to at least test test test test test test test test test
-- >
-- > Block Quote

-- 1. Numbers will
-- 3. Be Somewhat difficult
-- 2. To support

-- - Unordered
-- - Lists
-- - Should be a breeze, hopefully
-- * Personally, 
-- * I think this should start a new 
-- * list set


-- `test`
-- `test`

-- ![24,24,l](text)
-- ![36,36,r](text2)
-- ![48,48](item:///text3)

-- Nested `code text` should be monospaced

-- These

-- --- 

-- Should

-- *** 

-- All be lines

-- _______

-- <htts://www.google.com>

-- ----------

-- ----------

-- ]],nil))

-- For Stress Testing, ensuring nothing can error out the program
-- math.randomseed(1)
-- for i=1,20000,1 do
--     local str = {}
--     for j=1,5000,1 do
--         str[j] = string.char(math.random(1,255))
--         if j % 10 == 0 then
--             str[j] = "\n"
--         end
--     end
--     str = table.concat(str)
--     str = str:gsub(string.char(13),"")
--     md2f.md2f(1,1,18,18,str,nil)
-- end

print(md2f.header()..md2f.md2f(1,1,18,18,to_parse,nil))
