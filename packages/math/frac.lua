---Returns the fractional portion of a number (e.g. in 4.4, returns 0.4).
---@param n number
---@return number
function math.frac(n)
    return n - math.floor(n)
end
