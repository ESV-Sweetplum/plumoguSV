require('packages.table.duplicate')
require('packages.math.matrix.findZeroRow')
require('packages.math.matrix.rowLinComb')
require('packages.math.matrix.scaleRow')
---Given a square matrix A and equally-sized vector B, returns a vector x such that Ax=B.
---@param mtrx number[][]
---@param vctr number[]
---@return number[]? sln The solution vector, given that it exists. Will return `nil` if no such vector exists.
---@return number? errType If no such vector exists, returns positive infinity if the system has infinite solutions, zero if the system has zero solutions, and negative infinity if the matrix and vector are not compatible.
function matrix.solve(mtrx, vctr)
    if (#vctr ~= #mtrx) then return nil, -1 / 0 end
    local augMtrx = table.duplicate(mtrx)
    for i, n in pairs(vctr) do
        table.insert(augMtrx[i], n)
    end

    for i = 1, #mtrx do
        matrix.scaleRow(augMtrx, i, 1 / augMtrx[i][i])
        for j = i + 1, #mtrx do
            matrix.rowLinComb(augMtrx, j, i, -augMtrx[j][i]) -- Triangular Downward Sweep
            local zeroRowIdx = matrix.findZeroRow(augMtrx)
            if zeroRowIdx then
                return nil, augMtrx[zeroRowIdx][#mtrx + 1] == 0 and 1 / 0 or 0
                -- infinity for singular full zero row, zero for singular 0 = x
            end
        end
    end

    for i = #mtrx, 2, -1 do
        for j = i - 1, 1, -1 do
            matrix.rowLinComb(augMtrx, j, i, -augMtrx[j][i]) -- Triangular Upward Sweep
        end
    end

    return table.property(augMtrx, #mtrx + 1) -- Last Column
end
