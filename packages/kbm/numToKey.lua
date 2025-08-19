local ALPHABET_LIST = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S",
    "T", "U", "V", "W", "X", "Y", "Z" }

---Converts a key enum to a specific character.
---@param num integer
---@return string
function kbm.numToKey(num)
    return ALPHABET_LIST[math.clamp(num - 64, 1, #ALPHABET_LIST)]
end
