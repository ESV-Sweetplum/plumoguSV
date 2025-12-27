---Creates a color input.
---@param customStyle { [string]: any } The table that is meant to be modified.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean changed Whether or not the input has changed this frame.
function ColorInput(customStyle, parameterName, label, tooltipText)
    AddSeparator()
    local oldCode = customStyle[parameterName]
    _, customStyle[parameterName] = imgui.ColorPicker4(label, customStyle[parameterName] or DEFAULT_STYLE[parameterName])
    if tooltipText then HoverToolTip(tooltipText) end
    return oldCode ~= customStyle[parameterName]
end
