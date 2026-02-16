require('packages.string.charAt')

---Lots of imgui functions have ## in them as identifiers. This will remove everything after the ##.
---@param str string
---@return string
function removeTrailingTag(str)
    local newStr = {}
    for i = 1, str:len() do
        if (str:charAt(i) == '#' and str:charAt(i + 1) == '#') then break end
        table.insert(newStr, str:charAt(i))
    end

    return table.concat(newStr)
end
