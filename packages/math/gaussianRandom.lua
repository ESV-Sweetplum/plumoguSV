---Picks a random number with a Gaussian distribution; implemented with the polar Box-Muller transform.
---@param mean number The mean of the Gaussian distribution.
---@param stdDev number The standard deviation of the Gaussian distribution.
---@param withinStdDevCount number If the resulting random number is over this number of standard deviations from the mean, rerolls until it is no longer so.
---@return number z1 A random number.
---@return number x2 Another random number.
function math.gaussianRandom(mean, stdDev, withinStdDevCount)
    local output = nil
    while (not output or math.abs(output - mean) / stdDev > withinStdDevCount) do
        local randomRadius = math.random()
        while (randomRadius == 0) do randomRadius = math.random() end -- Avoids math.random outputting exactly 0
        local R = math.sqrt(-2 * math.log(randomRadius))
        local theta = 2 * math.pi * math.random()
        output, output2 = R * math.cos(theta) * stdDev + mean, R * math.sin(theta) * stdDev + mean
    end

    return output, output2
end
