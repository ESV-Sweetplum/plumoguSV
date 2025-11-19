-- Returns a set of linear values [Table]
-- Parameters
--    startValue : starting value of the linear set [Int/Float]
--    endValue   : ending value of the linear set [Int/Float]
--    numValues  : total number of values in the linear set [Int]
function generateLinearSet(startValue, endValue, numValues, placingSV)
    local linearSet = { startValue }
    if numValues < 2 then return linearSet end

    if (globalVars.equalizeLinear and placingSV and numValues > 2) then
        endValue = endValue +
            (endValue - startValue) / (numValues - 2)
    end

    local increment = (endValue - startValue) / (numValues - 1)
    for i = 1, (numValues - 1) do
        table.insert(linearSet, startValue + i * increment)
    end
    return linearSet
end
