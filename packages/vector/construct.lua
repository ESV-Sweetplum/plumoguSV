---Creates a new [`Vector4`](lua://Vector4) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector4 vctr The resultant vector of style `<n, n, n, n>`.
function vctr4(n)
    return vector.New(n, n, n, n)
end

---Creates a new [`Vector3`](lua://Vector4) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector3 vctr The resultant vector of style `<n, n, n>`.
function vctr3(n)
    return vector.New(n, n, n)
end

---Creates a new [`Vector2`](lua://Vector2) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector2 vctr The resultant vector of style `<n, n>`.
function vctr2(n)
    return vector.New(n, n)
end

---Creates a unit vector in the direction of `theta`.
---@param theta number The angle in radians.
---@return Vector2
function unit2(theta)
    return vector.New(math.cos(theta), math.sin(theta))
end
