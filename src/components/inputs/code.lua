---Creates an input designed specifically for code.
---@param varsTable { [string]: any } The table that is meant to be modified.
---@param parameterName string The key of the table that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean active Whether or not the code input is currently in edit mode.
function CodeInput(varsTable, parameterName, label, tooltipText)
    local oldCode = varsTable[parameterName]
    _, varsTable[parameterName] = imgui.InputTextMultiline(label, oldCode, 16384,
        vector.New(240, 120))
    if tooltipText then HoverToolTip(tooltipText) end
    return imgui.IsItemActive()
end
