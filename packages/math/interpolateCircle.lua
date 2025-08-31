---Interpolates circular parameters of the form (x-h)^2+(y-k)^2=r^2 with three, non-colinear points.
---@param p1 Vector2
---@param p2 Vector2
---@param p3 Vector2
---@return number, number?, number?
function math.interpolateCircle(p1, p2, p3)
    local mtrx = {
        vector.Table(2 * (p2 - p1)),
        vector.Table(2 * (p3 - p1))
    }

    local vctr = {
        vector.Length(p2) ^ 2 - vector.Length(p1) ^ 2,
        vector.Length(p3) ^ 2 - vector.Length(p1) ^ 2
    }

    vtx = matrix.solve(mtrx, vctr)
    if (type(vtx) == "number") then return -1 / 0 end

    r = math.sqrt((p1.x) ^ 2 + (p1.y) ^ 2 + vtx[1] ^ 2 + vtx[2] ^ 2 - 2 * vtx[1] * p1.x - 2 * vtx[2] * p1.y)

    return vtx[1], vtx[2], r
end
