local lunamark = require("lunamark")

local function parse(text,settings)
    --Load the default settings for any missing settings
    settings = settings or {}
    settings.background_color = settings.background_color or "#bababa25"
    settings.font_color = settings.font_color or "#FFF"
    settings.heading_1_color = settings.heading_1_color or "#AFA"
    settings.heading_2_color = settings.heading_2_color or "#FAA"
    settings.heading_3_color = settings.heading_3_color or "#AAF"
    settings.heading_4_color = settings.heading_4_color or "#FFA"
    settings.heading_5_color = settings.heading_5_color or "#AFF"
    settings.heading_6_color = settings.heading_6_color or "#FAF"
    settings.heading_1_size = settings.heading_1_size or "26"
    settings.heading_2_size = settings.heading_2_size or "24"
    settings.heading_3_size = settings.heading_3_size or "22"
    settings.heading_4_size = settings.heading_4_size or "20"
    settings.heading_5_size = settings.heading_5_size or "18"
    settings.heading_6_size = settings.heading_6_size or "16"
    settings.code_block_mono_color = settings.code_block_mono_color or "#6F6"
    settings.code_block_font_size = settings.code_block_font_size or 14
    settings.mono_color = settings.mono_color or "#6F6"
    settings.block_quote_color = settings.block_quote_color or "#FFA"

    --Load markdown to hypertext read-writer
    local writer = require("../markdown2formspec/formspec_writer").new(nil, settings)
    local formspec_parse = lunamark.reader.markdown.new(writer, { smart = false })
    
    --execute read-write of provided text
    return formspec_parse(text, settings)
end

return parse