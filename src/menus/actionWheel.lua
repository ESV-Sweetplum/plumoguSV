function checkForActionWheel()
    if (not globalVars.advancedMode) then return end

    local actionWheelKeyCombo = globalVars.hotkeyList[hotkeys_enum.open_action_wheel]
    cache.actionWheelState = kbm.holdingKeyCombo(actionWheelKeyCombo) or false

    if (kbm.pressedKeyCombo(actionWheelKeyCombo)) then
        cache.actionWheelPos = imgui.GetMousePos()
    end

    local SEGMENT_COUNT = 8
    local SEGMENT_SIZE = math.pi * 2 / SEGMENT_COUNT

    local BORDER_WIDTH = 10

    local TARGET_ACTION_WHEEL_SIZE = cache.actionWheelState and 100 or 0
    local TARGET_ACTION_WHEEL_EXPANSION_TIME = 250 * (cache.actionWheelState and 1 or 1.5)
    if (not cache.actionWheelSize) then cache.actionWheelSize = 0 end
    cache.actionWheelSize = cache.actionWheelSize +
        state.DeltaTime * 5.75 / TARGET_ACTION_WHEEL_EXPANSION_TIME * (TARGET_ACTION_WHEEL_SIZE - cache.actionWheelSize)
    if (cache.actionWheelSize > TARGET_ACTION_WHEEL_SIZE - 1 and cache.actionWheelState) then
        cache.actionWheelSize = TARGET_ACTION_WHEEL_SIZE
    end
    if (cache.actionWheelSize < 1) then
        cache.actionWheelSize = 0
    end

    if (not cache.actionWheelPos or cache.actionWheelSize == 0) then
        cache.previousSegment = -1
        cache.previousSegmentTime = 0
        return
    end

    local ctx = imgui.GetForegroundDrawList()
    ctx.AddCircle(cache.actionWheelPos or vctr2(0), cache.actionWheelSize - BORDER_WIDTH / 2,
        imgui.GetColorU32(imgui_col.ButtonActive), 128, BORDER_WIDTH)
    ctx.AddCircleFilled(cache.actionWheelPos or vctr2(0), cache.actionWheelSize - BORDER_WIDTH,
        imgui.GetColorU32(imgui_col.Button, 0.6))

    local deltaPos = imgui.GetMousePos() - cache.actionWheelPos
    local angle = (math.pi * 2 - math.atan2(deltaPos.y, deltaPos.x) - math.pi / 2) % (math.pi * 2)
    local offset = math.pi / SEGMENT_COUNT

    local segment = 0

    if (angle >= offset and angle <= math.pi * 2 - offset) then
        segment = math.ceil((angle - offset) / SEGMENT_SIZE)
    end

    if (segment != cache.previousSegment) then
        cache.previousSegment = segment
        cache.previousSegmentTime = 0
    else
        cache.previousSegmentTime = cache.previousSegmentTime + state.DeltaTime
    end

    if (vector.Dot(vector.Abs(deltaPos), vctr2(1)) < 1) then return end

    ctx.PathLineTo(cache.actionWheelPos)
    ctx.PathArcTo(cache.actionWheelPos, cache.actionWheelSize - BORDER_WIDTH,
        -segment * SEGMENT_SIZE - offset - math.pi / 2,
        -segment * SEGMENT_SIZE + offset - math.pi / 2, 64)
    ctx.PathLineTo(cache.actionWheelPos)

    local HOVER_TIME = 100
    local progress = math.clamp(cache.previousSegmentTime / HOVER_TIME, 0, 1)
    local col = color.vrgbaToUint(color.uintToRgba(imgui.GetColorU32(imgui_col.PlotHistogramHovered)) *
        vector.New(1, 1, 1,
            progress))

    ctx.PathFillConvex(col)
    ctx.PathClear()

    if (utils.IsKeyReleased(keys.LeftAlt)) then
        local preset = globalVars.presets[1]
        local data = table.parse(preset.data)
        globalVars.placeTypeIndex = table.indexOf(CREATE_TYPES, preset.type)
        cache.saveTable(preset.menu .. preset.type .. 'Settings', data.settingVars)
        cache.saveTable('place' .. preset.type .. 'Menu', data.menuVars)
    end
end
