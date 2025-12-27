require("packages.table.contains")
require("packages.string.charAt")
CONSONANTS = { "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z" }

---Very rudimentary function that returns a string depending on whether or not it should be plural.
---@param str string The inital string, which should be a noun (e.g. `bookmark`)
---@param val number The value, or count, of the noun, which will determine if it should be plural.
---@param pos? integer Where the pluralization letter(s) should be inserted.
---@return string pluralizedStr A new string that is pluralized if `val ~= 1`.
function pluralize(str, val, pos)
    local strEnding = ""
    if pos then
        strEnding = str:sub(pos + 1, -1)
        str = str:sub(1, pos)
    end
    local finalStrTbl = { str, "s" }
    if val == 1 then return str .. (strEnding or "") end
    local lastLetter = str:sub(-1):upper()
    local secondToLastLetter = str:charAt(-2):upper()
    if (lastLetter == "Y" and table.contains(CONSONANTS, secondToLastLetter)) then
        finalStrTbl[1] = finalStrTbl[1]:sub(1, -2)
        finalStrTbl[2] = "ies"
    end
    if (str:sub(-3):lower() == "quy") then
        finalStrTbl[1] = finalStrTbl[1]:sub(1, -2)
        finalStrTbl[2] = "ies"
    end
    if (table.contains({ "J", "S", "X", "Z" }, lastLetter) or table.contains({ "SH", "CH" }, str:sub(-2))) then
        finalStrTbl[2] = "es"
    end

    return table.concat(finalStrTbl) .. (strEnding or "")
end
