---#### (NOTE: This function is impure and has no return value. This should be changed eventually.)
---Gets a list of variables.
---@param listName string An identifier to avoid state collisions.
---@param variables { [string]: any } The key-value table to get data for.
function getVariables(listName, variables)
    for key, _ in pairs(variables) do
        if (state.GetValue(listName .. key) ~= nil) then
            variables[key] = state.GetValue(listName .. key)
        end
    end
end

---Saves a table in state, independently.
---@param listName string An identifier to avoid state collisions.
---@param variables { [string]: any } A key-value table to save.
function saveVariables(listName, variables)
    for key, value in pairs(variables) do
        state.SetValue(listName .. key, value)
    end
end
