function BasicInputFloat(label, var, decimalPlaces, suffix, step)

end

function ComputableInputFloat(label, var, decimalPlaces, suffix)
    local previousValue = var

    local fmt = "%." .. decimalPlaces .. "f"
    if (suffix) then fmt = fmt .. suffix end

    _, var = imgui.InputText(label,
        string.format(fmt,
            math.toNumber(tostring(var):match("%d*[%-]?%d+[%.]?%d+") or tostring(var):match("%d*[%-]?%d+")) or 0),
        4096,
        imgui_input_text_flags.AutoSelectAll)
    if (imgui.IsItemDeactivatedAfterEdit()) then
        local desiredComp = tostring(var):gsub(" ", "")
        var = expr(desiredComp)
    end

    return math.toNumber(tostring(var):match("%d*[%-]?%d+[%.]?%d+") or tostring(var):match("%d*[%-]?%d+")),
        previousValue ~= var
end

function NegatableComputableInputFloat(label, var, decimalPlaces, suffix)
    local oldValue = var
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("Neg.", SECONDARY_BUTTON_SIZE)
    ToolTip("Negate SV value")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local newValue = ComputableInputFloat(label, var, decimalPlaces, suffix)
    imgui.PopItemWidth()
    if ((negateButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[4])) and newValue ~= 0) then
        newValue = -newValue
    end
    imgui.PopStyleVar(2)
    return newValue, oldValue ~= newValue
end

function SwappableNegatableInputFloat2(varsTable, lowerName, higherName, label, suffix, digits, widthFactor)
    digits = digits or 2
    suffix = suffix or "x"
    widthFactor = widthFactor or 0.7
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(7, 4))
    local swapButtonPressed = imgui.Button("S##" .. lowerName, TERTIARY_BUTTON_SIZE)
    ToolTip("Swap start/end values")
    local oldValues = vector.New(varsTable[lowerName], varsTable[higherName])
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("N##" .. higherName, TERTIARY_BUTTON_SIZE)
    ToolTip("Negate start/end values")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * widthFactor - SAMELINE_SPACING)
    local _, newValues = imgui.InputFloat2(label, oldValues, "%." .. digits .. "f" .. suffix)
    imgui.PopItemWidth()
    varsTable[lowerName] = newValues.x
    varsTable[higherName] = newValues.y
    if (swapButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[3])) then
        varsTable[lowerName] = oldValues.y
        varsTable[higherName] = oldValues.x
    end
    if (negateButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[4])) then
        varsTable[lowerName] = -oldValues.x
        varsTable[higherName] = -oldValues.y
    end
    imgui.PopStyleVar(3)
    return swapButtonPressed or negateButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[3]) or
        kbm.pressedKeyCombo(globalVars.hotkeyList[4]) or
        oldValues ~= newValues
end
