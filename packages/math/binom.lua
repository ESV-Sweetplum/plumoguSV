require('packages.math.factorial')
---Returns n choose r, or nCr.
---@param n integer
---@param r integer
---@return integer
function math.binom(n, r)
    return math.factorial(n) / (math.factorial(r) * math.factorial(n - r))
end
