-- Returns a new duplicate list [Table]
-- Parameters
--    list : list of values [Table]
function makeDuplicateList(list)
    local duplicateList = {}
    for _, value in ipairs(list) do
        table.insert(duplicateList, value)
    end
    return duplicateList
end
