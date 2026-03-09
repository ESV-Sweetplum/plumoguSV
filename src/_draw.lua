function draw()
    if (not state.CurrentTimingPoint) then return end
    local performanceMode = globalVars.performanceMode

    PLUGIN_NAME = 'plumoguSV-dev'

    state.IsWindowHovered = imgui.IsWindowHovered()

    startNextWindowNotCollapsed(PLUGIN_NAME)
    imgui.SetNextWindowSizeConstraints(vctr2(0), vector.Max(table.vectorize2(state.WindowSize) / 2, vctr2(676))) -- RAHHHH 6 7 6 7 6 7 6 7 6 7 6 7
    imgui.Begin(PLUGIN_NAME, imgui_window_flags.AlwaysAutoResize)

    if (not performanceMode) then
        addGradient()
        renderBackground()
        drawCapybaraParent()
        drawCursorTrail()
        pulseController()
        checkForGlobalHotkeys()
        setPluginAppearance()
    end

    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
    imgui.BeginTabBar('SV tabs')
    for i = 1, #TAB_MENUS do
        createMenuTab(TAB_MENUS[i])
    end
    imgui.EndTabBar()

    if (not performanceMode) then
        if (globalVars.showVibratoWidget) then
            imgui.Begin('plumoguSV-vibrato', imgui_window_flags.AlwaysAutoResize)
            imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
            placeVibratoSVMenu(true)
            imgui.End()
        end
        if (globalVars.showNoteDataWidget) then
            renderNoteDataWidget()
        end
        if (globalVars.showMeasureDataWidget) then
            renderMeasureDataWidget()
        end
    end
    if (cache.windows.showTutorialWindow) then
        showTutorialWindow()
    end
    if (cache.windows.showSettingsWindow) then
        showPluginSettingsWindow()
    end
    if (cache.windows.showPatchNotesWindow) then
        showPatchNotesWindow()
    end

    if (not performanceMode and map.ToString():sub(1, 49) == 'elxnce2 - DJ ELXNCE BRINGS BACK EARLY 2021 VIBES ') then
        runTest()
    end

    imgui.End()

    logoThread()

    cache.boolean.changeOccurred = false
    local groups = cache.tgList
    if (state.SelectedScrollGroupId ~= groups[globalVars.scrollGroupIndex]) then
        globalVars.scrollGroupIndex = table.indexOf(groups, state.SelectedScrollGroupId)
    end

    local ctx = imgui.GetForegroundDrawList()

    ctx.AddCircleFilled(ballPos, ballSize, color.vrgbaToUint(getCurrentRGBColors(0.5)))

    ballVelocity = ballVelocity + ballAcceleration * state.DeltaTime * speedFactor
    ballPos = ballPos + ballVelocity * state.DeltaTime * speedFactor

    if (ballPos.y + ballSize > state.WindowSize[2]) then
        ballVelocity = ballVelocity * vector.New(1, -1)
        ballPos.y = state.WindowSize[2] - ballSize - 1
    end

    if (ballPos.x + ballSize > state.WindowSize[1] or ballPos.x < 0) then
        ballVelocity = ballVelocity * vector.New(-1, 1)
        ballPos.x = math.clamp(ballPos.x, 1, state.WindowSize[1] - ballSize - 1)
    end
end

ballSize = 25
ballPos = vector.New(150, 150)
ballVelocity = vector.New(15, 0)
ballAcceleration = vector.New(0, 1)
speedFactor = 0.3

creatingPlatform = false
