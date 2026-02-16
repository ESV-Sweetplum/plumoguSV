function animationFramesSetupMenu(settingVars)
    chooseMenuStep(settingVars)
    if settingVars.menuStep == 1 then
        KeepSameLine()
        imgui.Text('Choose Frame Settings')
        AddSeparator()
        BasicInputInt(settingVars, 'numFrames', 'Total # Frames', { 1, MAX_ANIMATION_FRAMES })
        chooseFrameSpacing(settingVars)
        chooseDistance(settingVars)
        HelpMarker('Initial separating distance from selected note to the first frame')
        BasicCheckbox(settingVars, 'reverseFrameOrder', 'Reverse frame order when placing SVs')
        AddSeparator()
        chooseNoteSkinType(settingVars)
    elseif settingVars.menuStep == 2 then
        KeepSameLine()
        imgui.Text('Adjust Notes/Frames')
        AddSeparator()
        imgui.Columns(2, 'Notes and Frames', false)
        addFrameTimes(settingVars)
        displayFrameTimes(settingVars)
        removeSelectedFrameTimeButton(settingVars)
        AddPadding()
        chooseFrameTimeData(settingVars)
        imgui.NextColumn()
        chooseCurrentFrame(settingVars)
        drawCurrentFrame(settingVars)
        imgui.Columns(1)
        local invisibleButtonSize = vector.New(2 * (ACTION_BUTTON_SIZE.x + 1.5 * SAMELINE_SPACING), 1)
        imgui.InvisibleButton('sv isnt a real skill', invisibleButtonSize)
    else
        KeepSameLine()
        imgui.Text('Place SVs')
        AddSeparator()
        if not isTruthy(settingVars.frameTimes) then
            imgui.Text("No notes added in Step 2, so can't place SVs yet")
            return
        end
        HelpMarker('This tool displaces notes into frames after the (first) selected note')
        HelpMarker('Works with pre-existing SVs or no SVs in the map')
        HelpMarker('This is technically an edit SV tool, but it replaces the old animate function')
        HelpMarker('Make sure to prepare an empty area for the frames after the note you select')
        HelpMarker('Note: frame positions and viewing them will break if SV distances change')
        simpleActionMenu('Setup frames after selected note', 1, displaceNotesForAnimationFrames, settingVars)
    end
end

function removeSelectedFrameTimeButton(settingVars)
    if not isTruthy(settingVars.frameTimes) then return end
    if not imgui.Button('Removed currently selected time', BEEG_BUTTON_SIZE) then return end
    table.remove(settingVars.frameTimes, settingVars.selectedTimeIndex)
    local maxIndex = math.max(1, #settingVars.frameTimes)
    settingVars.selectedTimeIndex = math.clamp(settingVars.selectedTimeIndex, 1, maxIndex)
end

function addFrameTimes(settingVars)
    if not imgui.Button('Add selected notes to use for frames', ACTION_BUTTON_SIZE) then return end

    local hasAlreadyAddedLaneTime = {}
    for _ = 1, game.keyCount do
        table.insert(hasAlreadyAddedLaneTime, {})
    end
    local frameTimeToIndex = {}
    local totalTimes = #settingVars.frameTimes
    for i = 1, totalTimes do
        local frameTime = settingVars.frameTimes[i] ---@cast frameTime { time: number, lanes: number[] }
        local time = frameTime.time
        local lanes = frameTime.lanes
        frameTimeToIndex[time] = i
        for j = 1, #lanes do
            local lane = lanes[j]
            hasAlreadyAddedLaneTime[lane][time] = true
        end
    end
    for _, ho in pairs(state.SelectedHitObjects) do
        local lane = ho.Lane
        local time = ho.StartTime
        if (not hasAlreadyAddedLaneTime[lane][time]) then
            hasAlreadyAddedLaneTime[lane][time] = true
            if frameTimeToIndex[time] then
                local index = frameTimeToIndex[time]
                local frameTime = settingVars.frameTimes[index] ---@cast frameTime { time: number, lanes: number[] }
                table.insert(frameTime.lanes, lane)
                frameTime.lanes = sort(frameTime.lanes, sortAscending)
            else
                local defaultFrame = settingVars.currentFrame
                local defaultPosition = 0
                local newFrameTime = createFrameTime(time, { lane }, defaultFrame, defaultPosition)
                table.insert(settingVars.frameTimes, newFrameTime)
                frameTimeToIndex[time] = #settingVars.frameTimes
            end
        end
    end
    settingVars.frameTimes = sort(settingVars.frameTimes, sortAscendingTime)
end

function displayFrameTimes(settingVars)
    if not isTruthy(settingVars.frameTimes) then
        imgui.Text('Add notes to fill the selection box below')
    else
        imgui.Text('time | lanes | frame # | position')
    end
    HelpMarker('Make sure to select ALL lanes from a chord with multiple notes, not just one lane')
    AddPadding()
    local frameTimeSelectionArea = vector.New(ACTION_BUTTON_SIZE.x, 120)
    imgui.BeginChild('Frame Times', frameTimeSelectionArea, 1)
    for i = 1, #settingVars.frameTimes do
        local frameTimeData = {}
        local frameTime = settingVars.frameTimes[i]
        frameTimeData[1] = frameTime.time
        frameTimeData[2] = frameTime.lanes .. ', '
        frameTimeData[3] = frameTime.frame
        frameTimeData[4] = frameTime.position
        local selectableText = frameTimeData .. ' | '
        if imgui.Selectable(selectableText, settingVars.selectedTimeIndex == i) then
            settingVars.selectedTimeIndex = i
        end
    end
    imgui.EndChild()
end

function drawCurrentFrame(settingVars)
    local mapKeyCount = game.keyCount
    local noteWidth = 200 / mapKeyCount
    local noteSpacing = 5
    local barNoteHeight = math.round(2 * noteWidth / 5, 0)
    local noteColor = color.rgbaToUint(117, 117, 117, 255)
    local noteSkinType = NOTE_SKIN_TYPES[settingVars.noteSkinTypeIndex]
    local drawlist = imgui.GetWindowDrawList()
    local childHeight = 250
    imgui.BeginChild('Current Frame', vector.New(255, childHeight), 1)
    for _, frameTime in pairs(settingVars.frameTimes) do
        if not frameTime.frame == settingVars.currentFrame then goto continue end
        for _, lane in pairs(frameTime.lanes) do
            if noteSkinType == 'Bar' then
                local x1 = 2 * noteSpacing + (noteWidth + noteSpacing) * (lane - 1)
                local y1 = (childHeight - 2 * noteSpacing) - (frameTime.position / 2)
                local x2 = x1 + noteWidth
                local y2 = y1 - barNoteHeight
                if globalVars.upscroll then
                    y1 = childHeight - y1
                    y2 = y1 + barNoteHeight
                end
                local p1 = coordsRelativeToWindow(x1, y1)
                local p2 = coordsRelativeToWindow(x2, y2)
                drawlist.AddRectFilled(p1, p2, noteColor)
            elseif noteSkinType == 'Circle' then
                local circleRadius = noteWidth / 2
                local leftBlankSpace = 2 * noteSpacing + circleRadius
                local yBlankSpace = 2 * noteSpacing + circleRadius + frameTime.position / 2
                local x1 = leftBlankSpace + (noteWidth + noteSpacing) * (lane - 1)
                local y1 = childHeight - yBlankSpace
                if globalVars.upscroll then
                    y1 = childHeight - y1
                end
                local p1 = coordsRelativeToWindow(x1, y1)
                drawlist.AddCircleFilled(p1, circleRadius, noteColor, 20)
            end
        end
        ::continue::
    end
    imgui.EndChild()
end

function addSelectedNoteTimesToList(menuVars)
    for _, ho in pairs(state.SelectedHitObjects) do
        table.insert(menuVars.noteTimes, ho.StartTime)
    end
    menuVars.noteTimes = table.dedupe(menuVars.noteTimes)
    menuVars.noteTimes = sort(menuVars.noteTimes, sortAscending)
end
