---Interpolates quadraticBezier parameters of the form y=ax^2+bx+c with three, non-colinear points.
---@param p1 Vector2
---@param p2 Vector2
---@param p3 Vector2
function math.interpolateQuadratic(p1, p2, p3)
    local mtrx = {
        (p2.x) ^ 2 - (p2.x) ^ 2, (p2 - p1).x,
        (p3.x) ^ 2 - (p1.x) ^ 2, (p3 - p1).x,
    }

    local vctr = {
        (p2 - p1).y,
        (p3 - p1).y
    }

    a, b = matrix.solve(mtrx, vctr)
    c = p1.y - p1.x * b - (p1.x) ^ 2 * a

    return table.unpack({ a, b, c })
end
