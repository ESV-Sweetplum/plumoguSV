---Creates an `imgui.inputInt` element.
---@param varsTable { [string]: any } The table that is meant to be modified.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param bounds? [number, number] A tuple representing the minimum and maximum bounds this input should have.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean changed Whether or not the checkbox has changed this frame.
function BasicInputInt(varsTable, parameterName, label, bounds, tooltipText)
    local oldValue = varsTable[parameterName]
    _, varsTable[parameterName] = imgui.InputInt(label:obfuscate(), oldValue, 1, 1)
    if tooltipText then HelpMarker(tooltipText) end
    if (bounds and bounds[1] and bounds[2]) then
        varsTable[parameterName] = math.clamp(varsTable[parameterName], bounds[1], bounds[2])
    end
    return oldValue ~= varsTable[parameterName]
end

function ExponentialInputInt(varsTable, parameterName, label, bounds, tooltipText)
    local oldValue = varsTable[parameterName]
    local multButtonPressed = imgui.Button(("x2##" .. label):obfuscate(), LARGER_TERTIARY_BUTTON_SIZE)
    HoverToolTip("Double this value.")
    KeepSameLine()
    local divButtonPressed = imgui.Button(("/2##" .. label):obfuscate(), LARGER_TERTIARY_BUTTON_SIZE)
    HoverToolTip("Half this value.")
    KeepSameLine()
    imgui.PushItemWidth(91.5)
    _, varsTable[parameterName] = imgui.InputInt(label:obfuscate(), oldValue, 0, 0)
    imgui.PopItemWidth()
    if tooltipText then HelpMarker(tooltipText) end
    if (multButtonPressed) then
        oldValue = oldValue * 2
    end
    if (divButtonPressed) then
        oldValue = oldValue / 2
    end
    if (bounds and bounds[1] and bounds[2]) then
        varsTable[parameterName] = math.clamp(varsTable[parameterName], bounds[1], bounds[2])
    end
    return oldValue ~= varsTable[parameterName]
end
