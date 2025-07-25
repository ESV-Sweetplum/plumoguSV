---In an array of numbers, searches for the closest number to `item`.
---@param tbl number[] The array of numbers to search in.
---@param item number The number to search for.
---@return number num, integer index The number that is the closest to the given item, and the index of that number in the given table.
function table.searchClosest(tbl, item)
    local leftIdx = 1
    local rightIdx = #tbl

    while rightIdx - leftIdx > 1 do
        local middleIdx = math.floor((leftIdx + rightIdx) * 0.5)
        if (item >= tbl[middleIdx]) then
            leftIdx = middleIdx
        else
            rightIdx = middleIdx
        end
    end

    local leftDifference = item - tbl[leftIdx]
    local rightDifference = tbl[rightIdx] - item

    if (leftDifference < rightDifference) then
        return tbl[leftIdx], leftIdx
    else
        return tbl[rightIdx], rightIdx
    end
end
