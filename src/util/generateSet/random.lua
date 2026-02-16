-- Returns the average of two numbers [Int/Float]
-- Returns a modified set of random values [Table]
-- Parameters
--    values        : list of random values [Table]
--    avgValue      : average value of the set [Int/Float]
--    verticalShift : constant to add to each value in the set at very the end [Int/Float]
--    dontNormalize : whether or not to normalize values to the avg value [Boolean]
function getRandomSet(values, avgValue, verticalShift, dontNormalize)
    avgValue = avgValue - verticalShift
    local randomSet = {}
    for i = 1, #values do
        table.insert(randomSet, values[i])
    end
    if not dontNormalize then
        randomSet = table.normalize(randomSet, avgValue, false)
    end
    for i = 1, #randomSet do
        randomSet[i] = randomSet[i] + verticalShift
    end
    return randomSet
end

-- Returns a set of random values [Table]
-- Parameters
--    numValues   : total number of values in the exponential set [Int]
--    randomType  : type of random distribution to use [String]
--    randomScale : how much to scale random values [Int/Float]
function generateRandomSet(numValues, randomType, randomScale)
    local randomSet = {}
    for _ = 1, numValues do
        if randomType == 'Uniform' then
            local randomValue = randomScale * 2 * (0.5 - math.random())
            table.insert(randomSet, randomValue)
        elseif randomType == 'Normal' then
            -- Box-Muller transformation
            local u1 = math.random()
            local u2 = math.random()
            local randomIncrement = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
            local randomValue = randomScale * randomIncrement
            table.insert(randomSet, randomValue)
        end
    end
    return randomSet
end
