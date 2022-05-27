# Lunamark (For Minetest)

This version of lunamark is a pure-lua 5.1 compatible lunamark, and has an example lua file provided called test.lua

(make sure to `git clone --recurive` for the utf8 dep)

Just execute lua test.lua to see proper html writing output. 

I have made some KNOWN changes to the lunamark markdown parser. For some reason (bugs), certain lulpeg combinations result in errors. Just read through to see the changes

## Bottom line

The next step would be to add a new writer to support formspec writing from the parser. Once that is done, I think this library is ready for prime time (i.e. fail miserablly in the real world)
