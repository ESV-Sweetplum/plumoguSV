---Takes in two lists and converts them to a key-value table.
---@generic T
---@generic U
---@param keyArr T[]
---@param valArr U[]
---@return {[T]: U} tbl
function table.assign(keyArr, valArr)
    if (#valArr > #keyArr) then
        valArr = table.slice(valArr, 1, #keyArr)
    end
    local tbl = {}
    for i = 1, #keyArr do
        tbl[keyArr[i]] = valArr[i]
    end

    return tbl
end
