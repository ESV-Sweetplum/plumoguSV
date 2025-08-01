function createSV(startTime, multiplier)
    return utils.CreateScrollVelocity(startTime, multiplier)
end

function createSSF(startTime, multiplier)
    return utils.CreateScrollSpeedFactor(startTime, multiplier)
end

function createEA(actionType, ...)
    return utils.CreateEditorAction(actionType, ...)
end
