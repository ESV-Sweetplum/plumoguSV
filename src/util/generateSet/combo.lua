-- Returns a set of combo values [Table]
-- Parameters
--    values1          : first set for the combo [Table]
--    values2          : second set for the combo [Table]
--    comboPhase       : amount to phase the second set of values into the first set [Int]
--    comboType        : type of combo for overlapping/phased values [String]
--    comboMultiplier1 : multiplying value for the first set in "Add" type combos [Int/Float]
--    comboMultiplier2 : multiplying value for the second set in "Add" type combos [Int/Float]
--    dontNormalize    : whether or not to normalize values to the avg value [Boolean]
--    avgValue         : average value of the set [Int/Float]
--    verticalShift    : constant to add to each value in the set at very the end [Int/Float]
function generateComboSet(values1, values2, comboPhase, comboType, comboMultiplier1,
                          comboMultiplier2, dontNormalize, avgValue, verticalShift)
    local comboValues = {}
    if comboType == "SV Type 1 Only" then
        comboValues = table.duplicate(values1)
    elseif comboType == "SV Type 2 Only" then
        comboValues = table.duplicate(values2)
    else
        local lastValue1 = table.remove(values1)
        local lastValue2 = table.remove(values2)

        local endIndex1 = #values1 - comboPhase
        local startIndex1 = comboPhase + 1
        local endIndex2 = comboPhase - #values1
        local startIndex2 = #values1 + #values2 + 1 - comboPhase

        for i = 1, endIndex1 do
            table.insert(comboValues, values1[i])
        end
        for i = 1, endIndex2 do
            table.insert(comboValues, values2[i])
        end

        if comboType ~= "Remove" then
            local comboValues1StartIndex = endIndex1 + 1
            local comboValues1EndIndex = startIndex2 - 1
            local comboValues2StartIndex = endIndex2 + 1
            local comboValues2EndIndex = startIndex1 - 1

            local comboValues1 = {}
            for i = comboValues1StartIndex, comboValues1EndIndex do
                table.insert(comboValues1, values1[i])
            end
            local comboValues2 = {}
            for i = comboValues2StartIndex, comboValues2EndIndex do
                table.insert(comboValues2, values2[i])
            end
            for i = 1, #comboValues1 do
                local comboValue1 = comboValues1[i]
                local comboValue2 = comboValues2[i]
                local finalValue
                if comboType == "Add" then
                    finalValue = comboMultiplier1 * comboValue1 + comboMultiplier2 * comboValue2
                elseif comboType == "Cross Multiply" then
                    finalValue = comboValue1 * comboValue2
                elseif comboType == "Min" then
                    finalValue = math.min(comboValue1, comboValue2)
                elseif comboType == "Max" then
                    finalValue = math.max(comboValue1, comboValue2)
                end
                table.insert(comboValues, finalValue)
            end
        end

        for i = startIndex1, #values2 do
            table.insert(comboValues, values2[i])
        end
        for i = startIndex2, #values1 do
            table.insert(comboValues, values1[i])
        end

        if not isTruthy(comboValues) then table.insert(comboValues, 1) end
        if (comboPhase - #values2 >= 0) then
            table.insert(comboValues, lastValue1)
        else
            table.insert(comboValues, lastValue2)
        end
    end
    avgValue = avgValue - verticalShift
    if not dontNormalize then
        comboValues = table.normalize(comboValues, avgValue, false)
    end
    for i = 1, #comboValues do
        comboValues[i] = comboValues[i] + verticalShift
    end

    return comboValues
end
