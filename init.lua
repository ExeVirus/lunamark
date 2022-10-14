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
Introduction
------------

Content and functionality can be added to Minetest using Lua scripting
in run-time loaded mods.

A mod is a self-contained bunch of scripts, textures and other related
things, which is loaded by and interfaces with Minetest.

Mods are contained and ran solely on the server side. Definitions and media
files are automatically transferred to the client.

If you see a deficiency in the API, feel free to attempt to add the
functionality in the engine and API, and to document it here.

Programming in Lua
------------------

**If** you have any difficulty in understanding this, please read
[Programming in Lua](http://www.lua.org/pil/).

Startup
-------

Mods are loaded during server startup from the mod load paths by running
the `init.lua` scripts in a shared environment.

Paths
-----

Minetest keeps and looks for files mostly in two paths. `path_share` or `path_user`.

`path_share` contains possibly read-only content for the engine (incl. games and mods).
`path_user` contains mods or games installed by the user but also the users
worlds or settings.

With a local build (`RUN_IN_PLACE=1`) `path_share` and `path_user` both point to
the build directory. For system-wide builds on Linux the share path is usually at
`/usr/share/minetest` while the user path resides in `.minetest` in the home directory.
Paths on other operating systems will differ.

Games
=====

Games are looked up from:

* `$path_share/games/<gameid>/`
* `$path_user/games/<gameid>/`

Where `<gameid>` is unique to each game.

The game directory can contain the following files:

* `game.conf`, with the following keys:
    * `title`: Required, a human-readable title to address the game, e.g. `title = Minetest Game`.
    * `name`: (Deprecated) same as title.
    * `description`: Short description to be shown in the content tab
    * `allowed_mapgens = <comma-separated mapgens>`
      e.g. `allowed_mapgens = v5,v6,flat`
      Mapgens not in this list are removed from the list of mapgens for the
      game.
      If not specified, all mapgens are allowed.
    * `disallowed_mapgens = <comma-separated mapgens>`
      e.g. `disallowed_mapgens = v5,v6,flat`
      These mapgens are removed from the list of mapgens for the game.
      When both `allowed_mapgens` and `disallowed_mapgens` are
      specified, `allowed_mapgens` is applied before
      `disallowed_mapgens`.
    * `disallowed_mapgen_settings= <comma-separated mapgen settings>`
      e.g. `disallowed_mapgen_settings = mgv5_spflags`
      These mapgen settings are hidden for this game in the world creation
      dialog and game start menu. Add `seed` to hide the seed input field.
    * `disabled_settings = <comma-separated settings>`
      e.g. `disabled_settings = enable_damage, creative_mode`
      These settings are hidden for this game in the "Start game" tab
      and will be initialized as `false` when the game is started.
      Prepend a setting name with an exclamation mark to initialize it to `true`
      (this does not work for `enable_server`).
      Only these settings are supported:
          `enable_damage`, `creative_mode`, `enable_server`.
    * `author`: The author of the game. It only appears when downloaded from
                ContentDB.
    * `release`: Ignore this: Should only ever be set by ContentDB, as it is
                 an internal ID used to track versions.
* `minetest.conf`:
  Used to set default settings when running this game.
* `settingtypes.txt`:
  In the same format as the one in builtin.
  This settingtypes.txt will be parsed by the menu and the settings will be
  displayed in the "Games" category in the advanced settings tab.
* If the game contains a folder called `textures` the server will load it as a
  texturepack, overriding mod textures.
  Any server texturepack will override mod textures and the game texturepack.
]=]

-- Opens a file in append mode
file = io.open(md2f.mp .. "/example.spec", "w+")

-- appends a word test to the last line of the file
file:write(md2f.header()..md2f.md2f(1,1,18,18,to_parse,nil))

-- closes the open file
io.close(file)