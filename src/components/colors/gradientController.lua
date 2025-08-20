---Similar to [`imgui.PushStyleColor`](lua://imgui.PushStyleColor), but pushes a changing color instead.
---@param color1 Vector4 The first color.
---@param color2 Vector4 The second color.
---@param property ImGuiCol The property to change.
---@param oscillationPeriod? integer The amount of time to switch from color 1 -> 2 -> 1, in milliseconds.
function PushGradientStyle(color1, color2, property, oscillationPeriod)
    local x = math.sin(6.28318531 * state.UnixTime / (oscillationPeriod or 1000)) / 2 + 0.5
    local currentColor = color1 * x + color2 * (1 - x)

    imgui.PushStyleColor(property, currentColor)
end
