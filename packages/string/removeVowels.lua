function string.removeVowels(str)
    local VOWELS = { "a", "e", "i", "o", "u", "y" }
    local newStr = ""
    for i = 1, str:len() do
        local char = str:charAt(i)
        if (not table.contains(VOWELS, char)) then
            newStr = newStr .. char
        end
    end
    return newStr
end
