direction = { 1, 1 }

function draw()
    if (not state.CurrentTimingPoint) then return end
    local performanceMode = globalVars.performanceMode

    PLUGIN_NAME = "plumoguSV-dev"

    state.IsWindowHovered = imgui.IsWindowHovered()

    startNextWindowNotCollapsed(PLUGIN_NAME)
    imgui.SetNextWindowSizeConstraints(vctr2(0), vector.Max(table.vectorize2(state.WindowSize) / 2, vctr2(600)))
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

    if (not direction) then
        direction = { 1, 1 }
    end

    local pos = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (pos.x + dim.x > state.WindowSize[1] or pos.x < 0) then
        direction[1] = -direction[1]
    end
    if (pos.y + dim.y > state.WindowSize[2] or pos.y < 0) then
        direction[2] = -direction[2]
    end

    imgui.SetWindowPos(PLUGIN_NAME, pos + table.vectorize2(direction) * vctr2(state.DeltaTime) / 2)

    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
    imgui.BeginTabBar("SV tabs")
    for i = 1, #TAB_MENUS do
        createMenuTab(TAB_MENUS[i])
    end
    imgui.EndTabBar()

    if (not performanceMode) then
        if (globalVars.showVibratoWidget) then
            imgui.Begin("plumoguSV-vibrato", imgui_window_flags.AlwaysAutoResize)
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

    imgui.End()

    logoThread()

    cache.boolean.changeOccurred = false
    local groups = cache.tgList
    if (state.SelectedScrollGroupId ~= groups[globalVars.scrollGroupIndex]) then
        globalVars.scrollGroupIndex = table.indexOf(groups, state.SelectedScrollGroupId)
    end
end
