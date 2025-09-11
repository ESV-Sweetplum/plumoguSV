---Alias for [`utils.CreateScrollVelocity`](lua://utils.CreateScrollVelocity).
---@param startTime number
---@param multiplier number
---@return ScrollVelocity
function createSV(startTime, multiplier)
    return utils.CreateScrollVelocity(startTime, multiplier)
end

---Alias for [`utils.CreateScrollSpeedFactor`](lua://utils.CreateScrollSpeedFactor).
---@param startTime number
---@param multiplier number
---@return ScrollSpeedFactor
function createSSF(startTime, multiplier)
    return utils.CreateScrollSpeedFactor(startTime, multiplier)
end

---Alias for [`utils.CreateEditorAction`](lua://utils.CreateEditorAction).
---@param actionType EditorActionType
---@param ... any
---@return EditorAction
function createEA(actionType, ...)
    return utils.CreateEditorAction(actionType, ...)
end

---Alias for [`utils.CreateScrollGroup`](lua://utils.CreateScrollGroup).
---@param svs ScrollVelocity[]
---@param initialSV? number
---@param colorRgb? string
---@return ScrollGroup
function createSG(svs, initialSV, colorRgb)
    return utils.CreateScrollGroup(svs, initialSV, colorRgb)
end
