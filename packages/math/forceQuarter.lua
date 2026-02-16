require('packages.math.round')
---Forces a number to have a quarterly decimal part.
---@param number number
---@return number
function math.quarter(number)
    return math.round(number * 4) * 0.25
end
