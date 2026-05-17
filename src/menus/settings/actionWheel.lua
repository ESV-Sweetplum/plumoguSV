function showActionWheelSettings()
    local oldActionWheelTypeIndex = globalVars.actionWheelTypeIndex
    imgui.SeparatorText('Activation Mode')
    HoverToolTip('How the action wheel should open, and how you should execute actions.')
    globalVars.actionWheelActivationIndex = RadioButtons('',
        globalVars.actionWheelActivationIndex, { 'Hover/Release', 'Tap/Click' }, { 1, 2 },
        { 'Hover over the desired item (while holding the action wheel key), then release the action wheel key to activate it.',
            'Tap on the action wheel key, then click on the item you want.' })
    imgui.SeparatorText('Wheel Contents')
    globalVars.actionWheelTypeIndex = Combo('Action Wheel Mode', ACTION_WHEEL_TYPES, globalVars.actionWheelTypeIndex, nil,
        nil, ACTION_WHEEL_TOOLTIP_LIST)
    if (oldActionWheelTypeIndex ~= globalVars.actionWheelTypeIndex) then
        write(globalVars)
    end
end
