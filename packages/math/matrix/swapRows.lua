function matrix.swapRows(mtrx, rowIdx1, rowIdx2)
    local temp = table.duplicate(mtrx[rowIdx1])
    mtrx[rowIdx1] = table.duplicate(mtrx[rowIdx2])
    mtrx[rowIdx2] = temp
end
