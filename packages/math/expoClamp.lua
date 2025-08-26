---Clamps a number between `lowerBound` and `upperBound` by repeatedly multiplying or dividing by the `multiplicativeFactor`.
---@param n number
---@param lowerBound number
---@param upperBound number
---@param multiplicativeFactor? number
---@return number
function math.expoClamp(n, lowerBound, upperBound, multiplicativeFactor)
    if (upperBound <= lowerBound) then return n end
    if (n <= upperBound and n >= lowerBound) then return n end
    local factor = multiplicativeFactor < 1 and 1 / multiplicativeFactor or multiplicativeFactor
    while (n < lowerBound) do
        n = n * factor
    end
    while (n > upperBound) do
        n = n / factor
    end
    return n
end
