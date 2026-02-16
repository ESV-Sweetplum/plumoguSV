---Changes a string to fit a certain size, with a ... at the end.
---@param str string
---@param targetSize integer
---@return string dottedStr
function string.fixToSize(str, targetSize)
    local size = imgui.CalcTextSize(str).x
    if size <= targetSize then return str end
    while (str:len() > 3 and size > targetSize) do
        str = str:sub(1, -2)
        size = imgui.CalcTextSize(str .. '...').x
    end
    return str .. '...'
end
