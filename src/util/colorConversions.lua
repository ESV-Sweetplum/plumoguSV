HEXADECIMAL = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" }

function rgbaToUint(r, g, b, a) return a * 16 ^ 6 + b * 16 ^ 4 + g * 16 ^ 2 + r end

function rgbaToHexa(r, g, b, a)
    local hexaStr = ""
    for _, col in ipairs({ r, g, b, a }) do
        hexaStr = hexaStr .. HEXADECIMAL[math.floor(col / 16) + 1] .. HEXADECIMAL[col % 16 + 1]
    end
    return hexaStr
end

function hexaToRgba(hexa)
    local rgbaTable = {}
    for i = 1, 8, 2 do
        table.insert(rgbaTable,
            table.indexOf(HEXADECIMAL, hexa:charAt(i)) * 16 + table.indexOf(HEXADECIMAL, hexa:charAt(i + 1)) - 17)
    end
    return table.vectorize4(rgbaTable)
end
