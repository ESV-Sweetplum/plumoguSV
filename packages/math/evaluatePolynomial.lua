---Evaluates a polynomial (specified by the coefficient array) at a value `x`.
---@param ceff number[] The coefficients of the polynomial in descending order; for example, the polynomial x^3+3x^2-3x+4 is represented as `{1, 3, -3, 4}`.
---@param x number
---@return number y
function math.evaluatePolynomial(ceff, x)
    local sum = 0
    local degree = #ceff - 1
    for i, c in ipairs(ceff) do
        sum = sum + c * x ^ (degree - i + 1)
    end
    return sum
end
