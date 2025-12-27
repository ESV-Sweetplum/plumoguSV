require("packages.string.charAt")

---Capitalizes the first letter of the given string. If `forceLowercase` is true, then all other letters will be forced into lowercase.
---@param str string
---@param forceLowercase? boolean
---@return string
function string.capitalize(str, forceLowercase)
    local secondPortion = str:sub(2)
    if forceLowercase then secondPortion = secondPortion:lower() end
    return str:charAt(1):upper() .. secondPortion
end
