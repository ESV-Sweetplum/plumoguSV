---Creates text that shifts between two colors.
---@param text string The text to render.
---@param color1 Vector4 The first color.
---@param color2 Vector4 The second color.
---@param oscillationPeriod? integer The amount of time to switch from color 1 -> 2 -> 1, in milliseconds.
function GradientText(color1, color2, text, oscillationPeriod)
    PushGradientStyle(color1, color2, imgui_col.Text, oscillationPeriod)
    imgui.Text(text)
    imgui.PopStyleColor()
end
