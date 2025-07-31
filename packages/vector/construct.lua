---Creates a new [`Vector4`](lua://Vector4) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector4 vctr The resultant vector of style `<n, n, n, n>`.
function vector4(n)
    return vector.New(n, n, n, n)
end

---Creates a new [`Vector3`](lua://Vector4) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector3 vctr The resultant vector of style `<n, n, n>`.
function vector3(n)
    return vector.New(n, n, n)
end

---Creates a new [`Vector2`](lua://Vector2) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector2 vctr The resultant vector of style `<n, n>`.
function vector2(n)
    return vector.New(n, n)
end

function unit2(theta)
    return vector.New(math.cos(theta), math.sin(theta))
end
