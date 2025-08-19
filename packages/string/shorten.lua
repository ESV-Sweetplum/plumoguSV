require("packages.string.removeVowels")
require("packages.string.charAt")

---Shortens a string to three consonants; the first, the second, and the last.
---@param str string
---@return string
function string.shorten(str)
    local consonants = str:removeVowels()
    if (consonants:len() < 3) then return consonants end

    return table.concat({ consonants:charAt(1), consonants:charAt(2), consonants:charAt(-1) })
end
