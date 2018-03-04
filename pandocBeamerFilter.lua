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
            local overlaySpec = string.sub(firstInline.text, first, last)
            print(overlaySpec)
            local inline = latex('\\onslide' .. overlaySpec)
            table.insert(block.content, 1, inline)
        end
    end
    return block
end


function handlePlain(plain)
    if FORMAT == 'beamer' then
        return findOverlaySpec(plain)
    end
end


function handlePara(para)
    if FORMAT == 'beamer' then
        return findOverlaySpec(para)
    end
end


local BEAMER_FILTER = {
    {Para = handlePara},
    {Plain = handlePlain}
}


return BEAMER_FILTER
