function matrix.multiply(m1, m2)
    local p1 = type(m1[1]) == 'table' and #m1 or 1
    local p2 = type(m1[1]) == 'table' and #m1[1] or #m1
    local q1 = type(m2[1]) == 'table' and #m1 or 1
    local q2 = type(m2[1]) == 'table' and #m2[1] or #m2
    if (p2 ~= q1) then error('Incompatible matrices were told to be multiplied', 69) end
    local result = {}
    local rowCount = p1
    local columnCount = q2
    for i = 1, rowCount do
        local row = {}
        for j = 1, columnCount do
            local sum = 0
            for k = 1, #m2 do
                local m1Factor = p2 == 1 and m1[k] or m1[i][k]
                local m2Factor = q2 == 1 and m2[j] or m1[k][j]
                sum = sum + m1[i][k] * m2[k][j]
            end
            table.insert(row, sum)
        end
        table.insert(result, row)
    end

    return result
end
