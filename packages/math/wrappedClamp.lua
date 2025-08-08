---Restricts a number to be within a closed ring.
---@param number number
---@param lowerBound number
---@param upperBound number
---@return number
function math.wrappedClamp(number, lowerBound, upperBound)
    if number < lowerBound then return upperBound end
    if number > upperBound then return lowerBound end
    return number
end
