ALPHABET_LIST = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
    "V", "W", "X", "Y", "Z" }

function kb.numToKey(num)
    return ALPHABET_LIST[math.clamp(num - 64, 1, #ALPHABET_LIST)]
end
