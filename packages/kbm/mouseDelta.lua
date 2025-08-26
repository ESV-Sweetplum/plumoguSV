---Gets the amount of distance the mouse moved THIS FRAME.
---@param button? ImGuiMouseButton
---@return Vector2 delta
function kbm.mouseDelta(button)
    local delta = imgui.GetMouseDragDelta(button or 0)
    imgui.ResetMouseDragDelta(button or 0)
    return delta
end
