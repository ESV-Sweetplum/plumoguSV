HEXADECIMAL = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" }

NONDUA = { "!", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7",
    "8", "9", ":", ";", "<", "=", ">", "?", "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
    "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "]", "^", "_", "`", "a", "b", "c", "d", "e", "f",
    "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}",
    "~" }

---Converts rgba to an unsigned integer (0-4294967295).
---@param r integer
---@param g integer
---@param b integer
---@param a integer
---@return integer
function color.rgbaToUint(r, g, b, a)
    local flr = math.floor
    return flr(a) * 16 ^ 6 + flr(b) * 16 ^ 4 + flr(g) * 16 ^ 2 + flr(r)
end

---Converts rgba (in vector form) to an unsigned integer (0-4294967295).
---@param col Vector4
---@return integer
function color.vrgbaToUint(col)
    local flr = math.floor
    return color.rgbaToUint(flr(col.x * 255), flr(col.y * 255), flr(col.z * 255), flr(col.w * 255))
end

---Converts an unsigned integer to a Vector4 of color values (0-1 for each element).
---@param n integer
---@return Vector4
function color.uintToRgba(n)
    local tbl = {}
    for i = 0, 3 do
        table.insert(tbl, math.floor(n / 256 ^ i) % 256)
    end

    return table.vectorize4(tbl)
end

---Converts rgba to a hexa string.
---@param r integer
---@param g integer
---@param b integer
---@param a integer
---@return string
function color.rgbaToHexa(r, g, b, a)
    local flr = math.floor
    local hexaStr = ""
    for _, col in ipairs({ r, g, b, a }) do
        hexaStr = hexaStr .. HEXADECIMAL[flr(col / 16) + 1] .. HEXADECIMAL[flr(col) % 16 + 1]
    end
    return hexaStr
end

---Converts a hexa string to an rgba Vector4 (0-1 for each element).
---@param hexa string
---@return Vector4
function color.hexaToRgba(hexa)
    local rgbaTable = {}
    for i = 1, 8, 2 do
        table.insert(rgbaTable,
            table.indexOf(HEXADECIMAL, hexa:charAt(i)) * 16 + table.indexOf(HEXADECIMAL, hexa:charAt(i + 1)) - 17)
    end
    return table.vectorize4(rgbaTable)
end

---Converts rgba to an ndua string (base 92).
---@param r integer
---@param g integer
---@param b integer
---@param a integer
---@return string
function color.rgbaToNdua(r, g, b, a)
    local uint = color.rgbaToUint(r, g, b, a)
    local str = ""

    for i = 0, 4 do
        str = str .. NONDUA[math.floor(uint / (92 ^ i)) % 92 + 1]
    end

    return str:reverse()
end

---Converts an ndua string (base 92) to an rgba Vector4 (0-1 for each element).
---@param ndua string
---@return Vector4
function color.nduaToRgba(ndua)
    local num = 0
    for i = 1, 5 do
        local idx = table.indexOf(NONDUA, ndua:charAt(i))
        if (idx == -1) then goto nextIndex end
        num = num + (idx - 1) * 92 ^ (5 - i)
        ::nextIndex::
    end

    return color.uintToRgba(num)
end

---Converts a color to a Quaver-compatible string.
---@param vctr Vector4
---@return string
function color.rgbaToStr(vctr)
    return table.concat({ vctr.x, vctr.y, vctr.z }, ",")
end
