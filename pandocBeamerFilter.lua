--[[
    This filter simplifies the creation of beamer slides from markdown. See
    README.md for documentation.
]]


function latex(text)
    return pandoc.RawInline("latex", text)
end


function findOverlaySpec(block)
    local firstInline = block.content[1]
    if firstInline.tag == 'Str' then
        local first, last = string.find(firstInline.text, '^[*+]?<[^\\s]+>')
        if first then
            table.remove(block.content, 1)
            if FORMAT == 'beamer' then
                local overlaySpec = string.sub(firstInline.text, first, last)
                local inline = latex('\\onslide' .. overlaySpec)
                table.insert(block.content, 1, inline)
            end
        end
    end
    return block
end


function handlePlain(plain)
    return findOverlaySpec(plain)
end


function handlePara(para)
    return findOverlaySpec(para)
end


function handleInline(inline)
    if FORMAT == 'beamer' and inline.attr.attributes.slides then
        local replacement = inline.content
        table.insert(replacement, 1, latex('\\onslide' .. inline.attr.attributes.slides .. '{'))
        table.insert(replacement, latex('}'))
        return replacement
    else
        return inline.content
    end
end


local BEAMER_FILTER = {
    {Span = handleInline},
    {Para = handlePara},
    {Plain = handlePlain}
}


return BEAMER_FILTER
