require("packages.string.charAt")

---Removes spaces and turns a string into lowerCamelCase. Also removes special characters.
---@param str string
---@return string
function string.identify(str)
    newStr = str:gsub("[%s%(%)#&]+", "")
    newStr = newStr:charAt(1):lower() .. newStr:sub(2)

    return newStr
end
