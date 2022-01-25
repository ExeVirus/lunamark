local lunamark = require("lunamark")
local writer = lunamark.writer.html.new()
local parse = lunamark.reader.markdown.new(writer, { smart = true })
local result, metadata = parse([[
# Hello World
## I'm lua markdown
hopefully we can get this working eventually.

Seems to be working somewhat okay?
---

1. This 
2. IS
3. a list
4. .
5. !

]])
print(result)