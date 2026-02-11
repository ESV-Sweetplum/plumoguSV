-- Creates a tooltip box when the last (most recently created) GUI item is hovered over
-- Parameters
--    text : text to appear in the tooltip box [String]
function HoverToolTip(text)
    if not imgui.IsItemHovered() then return end
    imgui.BeginTooltip()
    imgui.PushTextWrapPos(imgui.GetFontSize() * 20)
    imgui.Text(text:obfuscate())
    imgui.PopTextWrapPos()
    imgui.EndTooltip()
end

-- Creates an inline, grayed-out '(?)' symbol that shows a tooltip box when hovered over
-- Parameters
--    text : text to show in the tooltip box [String]
function HelpMarker(text)
    KeepSameLine()
    imgui.TextDisabled("(?)")
    HoverToolTip(text)
end
