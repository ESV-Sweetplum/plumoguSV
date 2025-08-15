---@diagnostic disable: return-type-mismatch
---The above is made because we want the functions to be identity functions when passing in vectors instead of tables.

---Converts a table of length 4 into a [`Vector4`](lua://Vector4).
---@param tbl number[] | { x: number, y: number, z: number, w: number } The table to convert.
---@return Vector4 vctr The output vector.
function table.vectorize4(tbl)
    if (not tbl) then return vctr4(0) end
    if (type(tbl) == "userdata") then return tbl end
    if (tbl[1] and tbl[2] and tbl[3] and tbl[4]) then return vector.New(tbl[1], tbl[2], tbl[3], tbl[4]) end
    return vector.New(tbl.x, tbl.y, tbl.z, tbl.w)
end

---Converts a table of length 3 into a [`Vector3`](lua://Vector3).
---@param tbl number[] | { x: number, y: number, z: number } The table to convert.
---@return Vector3 vctr The output vector.
function table.vectorize3(tbl)
    if (not tbl) then return vctr3(0) end
    if (type(tbl) == "userdata") then return tbl end
    if (tbl[1] and tbl[2] and tbl[3]) then return vector.New(tbl[1], tbl[2], tbl[3]) end
    return vector.New(tbl.x, tbl.y, tbl.z)
end

---Converts a table of length 2 into a [`Vector2`](lua://Vector2).
---@param tbl number[] | { x: number, y: number } The table to convert.
---@return Vector2 vctr The output vector.
function table.vectorize2(tbl)
    if (not tbl) then return vctr2(0) end
    if (type(tbl) == "userdata") then return tbl end
    if (tbl[1] and tbl[2]) then return vector.New(tbl[1], tbl[2]) end
    return vector.New(tbl.x, tbl.y)
end
