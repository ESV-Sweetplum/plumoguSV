-- Returns a set of sinusoidal values [Table]
-- Parameters
--    startAmplitude         : starting amplitude of the sinusoidal wave [Int/Float]
--    endAmplitude           : ending amplitude of the sinusoidal wave [Int/Float]
--    periods                : number of periods/cycles of the sinusoidal wave [Int/Float]
--    periodsShift           : number of periods/cycles to shift the sinusoidal wave [Int/Float]
--    valuesPerQuarterPeriod : number of values to calculate per quarter period/cycle [Int/Float]
--    verticalShift          : constant to add to each value in the set at very the end [Int/Float]
--    curveSharpness         : value determining the curviness of the sine curve [Int/Float]
function generateSinusoidalSet(
    startAmplitude,
    endAmplitude,
    periods,
    periodsShift,
    valuesPerQuarterPeriod,
    verticalShift,
    curveSharpness
)
    local sinusoidalSet = {}
    local quarterPeriods = 4 * periods
    local quarterPeriodsShift = 4 * periodsShift
    local totalValues = valuesPerQuarterPeriod * quarterPeriods
    local amplitudes = generateLinearSet(startAmplitude, endAmplitude, totalValues + 1)
    local normalizedSharpness
    if curveSharpness > 50 then
        normalizedSharpness = math.sqrt((curveSharpness - 50) * 2)
    else
        normalizedSharpness = (curveSharpness * 0.02) ^ 2
    end
    for i = 0, totalValues do
        local angle = (math.pi * 0.5) * ((i / valuesPerQuarterPeriod) + quarterPeriodsShift)
        local value = amplitudes[i + 1] * (math.abs(math.sin(angle)) ^ normalizedSharpness)
        value = value * math.sign(math.sin(angle)) + verticalShift
        table.insert(sinusoidalSet, value)
    end
    return sinusoidalSet
end
