---Wraps a number to an interval; that is, if the number is greater than the lower bound, continuously adds the difference until it reaches the upper bound, and vice versa.
---@param n number
---@param lowerBound number
---@param upperBound number
function math.wrap(n, lowerBound, upperBound)
    if (upperBound <= lowerBound) then return n end
    if (n >= lowerBound and n <= upperBound) then return n end
    local diff = upperBound - lowerBound
    while (n < lowerBound) do
        n = n + diff
    end
    while (n > upperBound) do
        n = n - diff
    end
    return n
end
