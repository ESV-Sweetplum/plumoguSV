require("packages.table.slice")

---Navigates a tree with dot notation and returns the corresponding value. For example, if you had a table { foo = { bar = 1}}, then this returns 1 if the given value is "foo.bar".
---@param tree { [string] : any}
---@param value string[]
---@return any
function table.nestedValue(tree, value)
    if (#value > 1) then
        return table.nestedValue(tree[value[1]], table.slice(value, 2))
    end

    return tree[value[1]]
end
