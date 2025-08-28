---Creates a set of radio buttons.
---@generic T
---@param label string The label for all radio buttons.
---@param value T The current value of the input.
---@param options string[] The list of options that the input should have. Each option has its own radio button.
---@param optionValues T[] What each option should set the value, in code.
---@param tooltipText? string An optional tooltip to be shown on hover.
---@return T idx The value of the currently selected radio button.
function RadioButtons(label, value, options, optionValues, tooltipText)
    imgui.AlignTextToFramePadding()
    imgui.Text(label)
    if (tooltipText) then HoverToolTip(tooltipText) end
    for idx, option in pairs(options) do
        imgui.SameLine(0, RADIO_BUTTON_SPACING)
        if imgui.RadioButton(option, value == optionValues[idx]) then
            value = optionValues[idx]
        end
    end
    return value
end
