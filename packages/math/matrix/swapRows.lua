function matrix.swapRows(mtrx, rowIdx1, rowIdx2)
    mtrx[rowIdx1], mtrx[rowIdx2] = table.duplicate(mtrx[rowIdx2]), table.duplicate(mtrx[rowIdx1])
end
