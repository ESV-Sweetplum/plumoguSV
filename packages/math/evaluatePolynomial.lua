function math.evaluatePolynomial(ceff, x)
    local sum = 0
    local degree = #ceff - 1
    for i, c in ipairs(ceff) do
        sum = sum + c * x ^ (degree - i + 1)
    end
    return sum
end
