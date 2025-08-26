function matrix.findZeroRow(mtrx)
    for idx, row in pairs(mtrx) do
        local zeroRow = true
        for _, num in ipairs(row) do
            if (num ~= 0) then
                zeroRow = false
                break
            end
        end
        if (zeroRow) then return idx end
    end
    return -1
end
