---Interpolates quadratic parameters of the form y=ax^2+bx+c with three, non-colinear points.
---@param p1 Vector2
---@param p2 Vector2
---@param p3 Vector2
---@return number, number?, number?
function math.interpolateQuadratic(p1, p2, p3)
    local mtrx = { -- from subtracting two quadratics formed from input points
        (p2.x) ^ 2 - (p1.x) ^ 2, (p2 - p1).x,
        (p3.x) ^ 2 - (p1.x) ^ 2, (p3 - p1).x,
    }

    local vctr = {
        (p2 - p1).y,
        (p3 - p1).y
    }

    local coeffs = matrix.solve(mtrx, vctr)
    if (type(coeffs) == "number") then return 1 / 0 end
    c = p1.y - p1.x * coeffs[2] - (p1.x) ^ 2 * coeffs[1]

    ---@type number, number, number
    return coeffs[1], coeffs[2], c
end
