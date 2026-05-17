---Creates a checkbox that directly saves to globalVars and the universal `.yaml` file.
---@param varsTable { [string]: any } The table that is meant to be modified.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean changed Whether or not the checkbox has changed this frame.
function BasicCheckbox(varsTable, parameterName, label, tooltipText)
    local oldValue = varsTable[parameterName]
    _, varsTable[parameterName] = imgui.Checkbox(label, oldValue)
    if tooltipText then HelpMarker(tooltipText) end
    return oldValue ~= varsTable[parameterName]
end

---Creates a checkbox that directly saves to globalVars and the universal `.yaml` file.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
function GlobalCheckbox(parameterName, label, tooltipText)
    local oldValue = globalVars[parameterName] ---@cast oldValue boolean
    _, globalVars[parameterName] = imgui.Checkbox(label, oldValue)
    if tooltipText then HoverToolTip(tooltipText) end
    if (oldValue ~= globalVars[parameterName]) then
        write(globalVars)
    end
end
