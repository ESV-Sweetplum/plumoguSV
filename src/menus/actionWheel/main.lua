function checkForActionWheel()
    if (not globalVars.advancedMode) then return end

    local ACTION_WHEEL_FUNCTIONS = {
        {
            kusaMovementUp,
            kusaMovementRight,
            kusaMovementDown,
            kusaMovementLeft,
        },
        {
            kusaColorRed,
            kusaColorOrange,
            kusaColorYellow,
            kusaColorGreen,
            kusaColorCyan,
            kusaColorBlue,
            kusaColorPurple,
            kusaColorPink,
            kusaColorWhite,
        },
    }

    local ACTION_WHEEL_DISPLAYS = {
        kusaMovementDisplay,
        kusaColorDisplay,
    }

    local actionWheelData = {
        state = false,
        pos = vctr2(0),
        size = 0,
        prevSegment = -1,
        prevSegmentTime = 0,
    }

    cache.load('actionWheel', actionWheelData)

    if (globalVars.actionWheelActivationIndex == 1) then     -- Hover/Release
        actionWheelData.state = utils.IsKeyDown(keys.LeftAlt) or false
    elseif (globalVars.actionWheelActivationIndex == 2) then -- Tap/Click
        if (utils.IsKeyPressed(keys.LeftAlt)) then actionWheelData.state = not actionWheelData.state end
    end

    if (utils.IsKeyPressed(keys.LeftAlt) and actionWheelData.state) then
        actionWheelData.pos = imgui.GetMousePos()
    end

    local SEGMENT_COUNT = #ACTION_WHEEL_FUNCTIONS[globalVars.actionWheelTypeIndex]
    local SEGMENT_SIZE = math.pi * 2 / SEGMENT_COUNT

    local BORDER_WIDTH = 10

    local MAX_ACTION_WHEEL_SIZE = 100

    local TARGET_ACTION_WHEEL_SIZE = actionWheelData.state and MAX_ACTION_WHEEL_SIZE or 0
    local TARGET_ACTION_WHEEL_EXPANSION_TIME = 250 * (actionWheelData.state and 1 or 1.5)
    if (not actionWheelData.size) then actionWheelData.size = 0 end
    actionWheelData.size = actionWheelData.size +
        state.DeltaTime * 5.75 / TARGET_ACTION_WHEEL_EXPANSION_TIME * (TARGET_ACTION_WHEEL_SIZE - actionWheelData.size)
    if (actionWheelData.size > TARGET_ACTION_WHEEL_SIZE - 1 and actionWheelData.state) then
        actionWheelData.size = TARGET_ACTION_WHEEL_SIZE
    end
    if (actionWheelData.size < 1) then
        actionWheelData.size = 0
    end

    if (not actionWheelData.pos or actionWheelData.size == 0) then
        actionWheelData.prevSegment = -1
        actionWheelData.prevSegmentTime = 0
        return
    end

    local ctx = imgui.GetForegroundDrawList()
    ctx.AddCircle(actionWheelData.pos or vctr2(0), actionWheelData.size - BORDER_WIDTH / 2,
        imgui.GetColorU32(imgui_col.ButtonActive), 128, BORDER_WIDTH)
    ctx.AddCircleFilled(actionWheelData.pos or vctr2(0), actionWheelData.size - BORDER_WIDTH,
        imgui.GetColorU32(imgui_col.Button, 0.6))

    local deltaPos = imgui.GetMousePos() - actionWheelData.pos
    local angle = (math.pi * 2 + math.atan2(deltaPos.y, deltaPos.x) + math.pi / 2) % (math.pi * 2)
    local offset = math.pi / SEGMENT_COUNT
    local movedMouse = vector.Dot(vector.Abs(deltaPos), vctr2(1)) >= 1

    local selectedSegment = 0

    if (angle >= offset and angle <= math.pi * 2 - offset) then
        selectedSegment = math.ceil((angle - offset) / SEGMENT_SIZE)
    end

    if (selectedSegment ~= actionWheelData.prevSegment) then
        actionWheelData.prevSegment = selectedSegment
        actionWheelData.prevSegmentTime = 0
    else
        actionWheelData.prevSegmentTime = actionWheelData.prevSegmentTime + state.DeltaTime
    end

    if (not movedMouse) then
        ACTION_WHEEL_DISPLAYS[globalVars.actionWheelTypeIndex](actionWheelData.pos, actionWheelData.size, -1)
        cache.save('actionWheel', actionWheelData)
        return
    end

    ctx.PathLineTo(actionWheelData.pos)
    ctx.PathArcTo(actionWheelData.pos, actionWheelData.size - BORDER_WIDTH,
        selectedSegment * SEGMENT_SIZE - offset - math.pi / 2,
        selectedSegment * SEGMENT_SIZE + offset - math.pi / 2, 64)
    ctx.PathLineTo(actionWheelData.pos)

    local HOVER_TIME = 100
    local progress = math.clamp(actionWheelData.prevSegmentTime / HOVER_TIME, 0, 1)
    local col = color.vrgbaToUint(color.uintToRgba(imgui.GetColorU32(imgui_col.PlotHistogramHovered)) *
        vector.New(1, 1, 1,
            progress))

    ctx.PathFillConvex(col)
    ctx.PathClear()

    if (utils.IsKeyReleased(keys.LeftAlt) and globalVars.actionWheelActivationIndex == 1) then
        ACTION_WHEEL_FUNCTIONS[globalVars.actionWheelTypeIndex][selectedSegment + 1]()
    end
    if (imgui.IsMouseClicked('Left') and globalVars.actionWheelActivationIndex == 2) then
        ACTION_WHEEL_FUNCTIONS[globalVars.actionWheelTypeIndex][selectedSegment + 1]()
        actionWheelData.state = false
    end

    cache.save('actionWheel', actionWheelData)
    ACTION_WHEEL_DISPLAYS[globalVars.actionWheelTypeIndex](actionWheelData.pos, actionWheelData.size, selectedSegment)
end
