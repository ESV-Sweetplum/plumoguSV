-- Returns a set of circular values [Table]
-- Parameters
--    behavior      : description of how the set changes (speeds up or slows down) [String]
--    arcPercent    : arc percent of a semicircle to generate values from [Int]
--    avgValue      : average value of the set [Int/Float]
--    verticalShift : constant to add to each value in the set at very the end [Int/Float]
--    numValues     : total number of values in the circular set [Int]
--    dontNormalize : Whether or not to normalize values to the target average value [Boolean]
function generateCircularSet(behavior, arcPercent, avgValue, verticalShift, numValues,
                             dontNormalize)
    local increaseValues = (behavior == 'Speed up')
    avgValue = avgValue - verticalShift
    local startingAngle = math.pi * (arcPercent * 0.01)
    local angles = generateLinearSet(startingAngle, 0, numValues)
    local yCoords = {}
    for i = 1, #angles do
        local angle = math.round(angles[i], 8)
        local x = math.cos(angle)
        yCoords[i] = -avgValue * math.sqrt(1 - x ^ 2)
    end
    local circularSet = {}
    for i = 1, #yCoords - 1 do
        local startY = yCoords[i]
        local endY = yCoords[i + 1]
        circularSet[i] = (endY - startY) * (numValues - 1)
    end
    if not increaseValues then circularSet = table.reverse(circularSet) end
    if not dontNormalize then circularSet = table.normalize(circularSet, avgValue, true) end
    for i = 1, #circularSet do
        circularSet[i] = circularSet[i] + verticalShift
    end
    table.insert(circularSet, avgValue)
    return circularSet
end
