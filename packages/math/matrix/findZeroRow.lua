---Returns the index of a zero row, or `nil` if none are found.
---@param mtrx number[][]
---@return integer?
function matrix.findZeroRow(mtrx)
    for idx, row in pairs(mtrx) do
        local zeroRow = true
        for _, num in ipairs(row) do
            if num ~= 0 then
                zeroRow = false
                break
            end
        end
        if zeroRow then return idx end
    end
    return nil
end
