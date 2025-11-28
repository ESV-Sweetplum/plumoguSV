require("packages.table.contains")
require("packages.string.charAt")
require("packages.math.toNumber")
---Converts a string (generated from [table.stringify](lua://table.stringify)) into a table.
---@param str string
---@return any
function table.parse(str)
    if (str == "FALSE" or str == "TRUE") then return str == "TRUE" end
    if (str:charAt(1) == '"') then return str:sub(2, -2) end
    if (str:match("^[%d%.]+$")) then return math.toNumber(str) end
    if (not table.contains({ "{", "[" }, str:charAt(1))) then return str end
    local tableType = str:charAt(1) == "[" and "arr" or "dict"
    local tbl = {}
    local terms = {}
    local MAX_ITERATIONS = 10000
    for i = 1, MAX_ITERATIONS do
        local nestedTableFactor = tn(table.contains({ "[", "{" }, str:charAt(2)))
        local depth = nestedTableFactor
        local searchIdx = 2 + nestedTableFactor
        local inQuotes = false
        while (searchIdx < str:len()) do
            if (str:charAt(searchIdx) == '"') then
                inQuotes = not inQuotes
            end
            if (table.contains({ "]", "}" }, str:charAt(searchIdx)) and not inQuotes) then
                depth = depth - 1
            end
            if (table.contains({ "[", "{" }, str:charAt(searchIdx)) and not inQuotes) then
                depth = depth + 1
            end
            if ((str:charAt(searchIdx) == "," or nestedTableFactor == 1) and not inQuotes and depth == 0) then break end
            searchIdx = searchIdx + 1
        end
        table.insert(terms, str:sub(2, searchIdx + nestedTableFactor - 1))
        str = str:sub(searchIdx + nestedTableFactor)
        if (str:len() <= 1) then break end
    end

    if (tableType == "arr") then
        for _, v in ipairs(terms) do
            table.insert(tbl, table.parse(v))
        end
    else
        for _, v in ipairs(terms) do
            local idx = v:find("=")
            tbl[v:sub(1, idx - 1)] = table.parse(v:sub(idx + 1))
        end
    end
    return tbl
end
