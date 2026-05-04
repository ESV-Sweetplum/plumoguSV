function checkForActionWheel()
    cache.actionWheelState = kbm.holdingKeyCombo(globalVars.hotkeyList[hotkeys_enum.open_action_wheel]) or false
    if (not cache.actionWheelState) then return end

    local TARGET_ACTION_WHEEL_SIZE = cache.actionWheelState and 100 or 0
    local TARGET_ACTION_WHEEL_EXPANSION_TIME = 200
    if (not cache.actionWheelSize) then cache.actionWheelSize = 0 end
    cache.actionWheelSize = cache.actionWheelSize +
        state.DeltaTime * 5.75 / TARGET_ACTION_WHEEL_EXPANSION_TIME * (TARGET_ACTION_WHEEL_SIZE - cache.actionWheelSize)
    if (cache.actionWheelSize > TARGET_ACTION_WHEEL_SIZE - 1) then
        cache.actionWheelSize = TARGET_ACTION_WHEEL_SIZE
    end
    if (cache.actionWheelSize < 0) then
        cache.actionWheelSize = 0
    end

    local ctx = imgui.GetForegroundDrawList()
    ctx.AddCircleFilled(imgui.GetMousePos(), cache.actionWheelSize, color.int.white)

    if (not truthy(cache.actionWheelSize)) then return end
end
