require("packages.string.removeVowels")

function string.shorten(str)
    local consonants = str:removeVowels()

    return table.concat({ consonants:charAt(1), consonants:charAt(2), consonants:charAt(-1) })
end
