---Wraps a number to an interval; that is, if the number is greater than the lower bound, continuously adds the difference until it reaches the upper bound, and vice versa.
---@param n number
---@param lowerBound number
---@param upperBound number
---@param discrete? boolean Whether or not to wrap discretely - that is, in a range of 1 to n, if given 0, will return n instead of n - 1. Check [OBOE or fencepost error](https://en.wikipedia.org/wiki/Off-by-one_error).
---@return number
function math.wrap(n, lowerBound, upperBound, discrete)
    if upperBound <= lowerBound then return n end
    if (n >= lowerBound and n <= upperBound) then return n end
    local additionFactor = math.toNumber(discrete)
    local diff = upperBound - lowerBound
    while (n < lowerBound) do
        n = n + diff + additionFactor
    end
    while (n > upperBound) do
        n = n - diff - additionFactor
    end
    return n
end
