---Returns the center of the window (in pixels).
---@return Vector2 center
function game.window.getCenter()
    local windowDim = state.WindowSize
    return vector.New(state.WindowSize[1] / 2, state.WindowSize[2] / 2)
end
