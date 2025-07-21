---Creates an `imgui.inputInt` element.
---@param varsTable { [string]: any }The table that is meant to be modified.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param bounds? [number, number] A tuple representing the minimum and maximum bounds this input should have.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean changed Whether or not the checkbox has changed this frame.
function BasicInputInt(varsTable, parameterName, label, bounds, tooltipText)
    local oldValue = varsTable[parameterName]
    _, varsTable[parameterName] = imgui.InputInt(label, oldValue, 1, 1)
    if (tooltipText) then HelpMarker(tooltipText) end
    if (bounds and bounds[1] and bounds[2]) then
        varsTable[parameterName] = math.clamp(varsTable[parameterName], bounds[1], bounds[2])
    end
    return oldValue ~= varsTable[parameterName]
end
