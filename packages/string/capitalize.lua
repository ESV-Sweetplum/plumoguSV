require("packages.string.charAt")

---Capitalizes the first letter of the given string.
---@param str string
---@return string
function string.capitalize(str)
    return str:charAt(1):upper() .. str:sub(2)
end
