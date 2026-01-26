function BasicInputFloat(label, value, decimalPlaces, suffix, step)

end

function ComputableInputFloat(label, value, decimalPlaces, suffix)
    local previousvalue = value
    local output = value

    local fmt = "%." .. decimalPlaces .. "f"
    if suffix then fmt = fmt .. suffix end

    _, value = imgui.InputText(label,
        string.format(fmt, value), 4096,
        imgui_input_text_flags.AutoSelectAll)
    if (imgui.IsItemEdited()) then
        local desiredComp = tostring(value):gsub("[^%d%+%-%*%/%.]", ""):gsub(suffix, "")
        output = expr(desiredComp)
        if (output == nil) then output = value end
    end

    return tn(tostring(output):match("[%-]?%d+[%.]?%d+") or tostring(output):match("[%-]?%d+")),
        previousvalue ~= output -- Need both matches due to modifiers not working on whole groups
end

function NegatableComputableInputFloat(label, value, decimalPlaces, suffix)
    local oldValue = value
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("Neg.", SECONDARY_BUTTON_SIZE)
    HoverToolTip("Negate this value.")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(107)
    local newValue = ComputableInputFloat(label, value, decimalPlaces, suffix)
    imgui.PopItemWidth()
    if ((negateButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.negate_primary])) and newValue ~= 0) then
        newValue = -newValue
    end
    imgui.PopStyleVar(2)
    return newValue, oldValue ~= newValue
end

function ResettableNegatableComputableInputFloat(label, value, defaultValue, decimalPlaces, suffix)
    local oldValue = value

    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(7, 4))
    local resetButtonPressed = imgui.Button("R", TERTIARY_BUTTON_SIZE)
    if (resetButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.reset_secondary])) then
        value = defaultValue
    end
    HoverToolTip("Reset to the initial value.")
    KeepSameLine()

    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("N", TERTIARY_BUTTON_SIZE)

    if negateButtonPressed and value ~= 0 then
        value = -value
    end
    HoverToolTip("Negate this value.")

    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))

    imgui.PushItemWidth(107)
    local newValue = ComputableInputFloat(label, value, decimalPlaces, suffix)
    imgui.PopItemWidth()

    imgui.PopStyleVar(3)
    return newValue, oldValue ~= newValue
end

function SwappableNegatableInputFloat2(varsTable, lowerName, higherName, label, suffix, digits, widthFactor)
    digits = digits or 2
    suffix = suffix or "x"
    widthFactor = widthFactor or 0.7
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(7, 4))
    local swapButtonPressed = imgui.Button("S##" .. lowerName, TERTIARY_BUTTON_SIZE)
    HoverToolTip("Swap start/end values")
    local oldValues = vector.New(varsTable[lowerName], varsTable[higherName])
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("N##" .. higherName, TERTIARY_BUTTON_SIZE)
    HoverToolTip("Negate start/end values")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * widthFactor - SAMELINE_SPACING)
    local _, newValues = imgui.InputFloat2(label, oldValues, "%." .. digits .. "f" .. suffix)
    imgui.PopItemWidth()
    varsTable[lowerName] = newValues.x
    varsTable[higherName] = newValues.y
    if (swapButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.swap_primary])) then
        varsTable[lowerName] = oldValues.y
        varsTable[higherName] = oldValues.x
    end
    if (negateButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.negate_primary])) then
        varsTable[lowerName] = -oldValues.x
        varsTable[higherName] = -oldValues.y
    end
    imgui.PopStyleVar(3)
    return swapButtonPressed or negateButtonPressed or
        kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.swap_primary]) or
        kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.negate_primary]) or
        oldValues ~= newValues
end
