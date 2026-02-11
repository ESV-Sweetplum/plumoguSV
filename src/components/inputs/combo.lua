---Creates a combo element.
---@param label string The label for the combo.
---@param list string[] The list of elements the combo should use.
---@param listIndex integer The currently selected combo index.
---@param colorList? string[] An optional list containing an array of colors to use for each item.
---@param hiddenGroups? string[] An optional list, where if any items in list show up here, they will not be shown on the dropdown.
---@param tooltipList? string[] An optional list, showing tooltips that should appear when an element is hovered over.
---@return number newListIndex The new combo index.
function Combo(label, list, listIndex, colorList, hiddenGroups, tooltipList)
    local newListIndex = math.clamp(listIndex, 1, #list)
    local currentComboItem = list[listIndex]
    local comboFlag = imgui_combo_flags.HeightLarge
    local rgb = {}
    hiddenGroups = hiddenGroups or {}

    if (colorList and isTruthy(colorList)) then
        colorList[newListIndex]:gsub("(%d+)", function(c)
            table.insert(rgb, c)
        end)
        local alpha = math.floor(imgui.GetColorU32(imgui_col.Text) / 16777216) / 255 or 1
        imgui.PushStyleColor(imgui_col.Text,
            vector.New(rgb[1] / 255, rgb[2] / 255, rgb[3] / 255, alpha))
    end

    if not imgui.BeginCombo(label, currentComboItem:obfuscate(), comboFlag) then
        if (colorList and isTruthy(colorList)) then imgui.PopStyleColor() end
        return newListIndex
    end
    if (colorList and isTruthy(colorList)) then imgui.PopStyleColor() end

    for i = 1, #list do
        rgb = {}
        if (colorList and isTruthy(colorList)) then
            colorList[i]:gsub("(%d+)", function(c)
                table.insert(rgb, c)
            end)
            imgui.PushStyleColor(imgui_col.Text, vector.New(rgb[1] / 255, rgb[2] / 255, rgb[3] / 255, 1))
        end
        local listItem = list[i]
        if (table.contains(hiddenGroups, listItem)) then goto skipRender end
        if imgui.Selectable(listItem:obfuscate()) then
            newListIndex = i
        end
        if (tooltipList and isTruthy(tooltipList)) then
            HoverToolTip(tooltipList[i])
        end
        ::skipRender::
        if (colorList and isTruthy(colorList)) then imgui.PopStyleColor() end
    end
    imgui.EndCombo()
    return newListIndex
end
