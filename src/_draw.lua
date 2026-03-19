function runOtherTest()
    local ogTg = state.SelectedScrollGroupId
    local svsToAdd = {}

    for _, v in pairs(state.SelectedHitObjects) do
        state.SelectedScrollGroupId = 'splitter_col_' .. v.Lane
        local dist = getDist(v.StartTime, v.Lane)
        local curSSF = map.GetScrollSpeedFactorAt(v.StartTime + 1).Multiplier
        prepareDisplacingSVs(v.StartTime, svsToAdd, {}, dist * curSSF, -dist * curSSF, 0)
    end

    actions.PlaceScrollVelocityBatch(svsToAdd)
    state.SelectedScrollGroupId = ogTg
end

function getDist(t, l)
    local ogTg = state.SelectedScrollGroupId
    state.SelectedScrollGroupId = 'w_receptor_' .. l
    svsBetweenOffsets = game.get.svsBetweenOffsets(t, 200479)
    local nsvDistance = 200479 - t
    addStartSVIfMissing(svsBetweenOffsets, t)
    local totalDistance = calculateDisplacementFromSVs(svsBetweenOffsets, t, 200479) or 0
    local roundedSVDistance = math.round(totalDistance, 3)
    state.SelectedScrollGroupId = ogTg
    return roundedSVDistance
end

function draw()
    if (not state.CurrentTimingPoint or not imgui or not state) then return end
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

    if (imgui.Button('run')) then
        runOtherTest()
    end

    imgui.End()

    logoThread()

    cache.boolean.changeOccurred = false
    local groups = cache.tgList
    if (state.SelectedScrollGroupId ~= groups[globalVars.scrollGroupIndex]) then
        globalVars.scrollGroupIndex = table.indexOf(groups, state.SelectedScrollGroupId)
    end
end
