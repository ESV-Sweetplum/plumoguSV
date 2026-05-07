function showActionWheelSettings()
    local oldActionWheelTypeIndex = globalVars.actionWheelTypeIndex
    globalVars.actionWheelTypeIndex = Combo('Action Wheel Mode', ACTION_WHEEL_TYPES, globalVars.actionWheelTypeIndex, nil,
        nil, ACTION_WHEEL_TOOLTIP_LIST)
    if (oldActionWheelTypeIndex ~= globalVars.actionWheelTypeIndex) then
        write(globalVars)
    end
end
