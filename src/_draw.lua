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
    if (devMode and imgui.Button("bruh")) then
        setCustomStyleString(
            "v2 wB@w!Kg pBKPZ31 fB@g3%& fBHA:)){ fBA^y9_S tBOInyJ tBA^j~Cu tBC9C-30 cMHsM%@ sG^ov;E sGA^t-|8 bnR*g'E bH^miz< bA^v[<y tb9X-t: tH^mqb^ tA^so:( hr:-.jN hH:-.jN hA:-.jN sr4$wSM tt^z^I- tSB:-/=T sGH^r#Yw pL^nN*A pLH^e,5- pH^xDDQ pHH^zUcE br^e+8* lOTCR^e+8* lPTCLT^zUc2 lPTCRT^zW]z lBTL94b4N lBTRJ)f// lBBLJ)f// lBBR^jNl& sG^ov;E sGA^t-|8",
            true)
    end

    imgui.End()

    logoThread()

    cache.boolean.changeOccurred = false
    local groups = cache.tgList
    if (state.SelectedScrollGroupId ~= groups[globalVars.scrollGroupIndex]) then
        globalVars.scrollGroupIndex = table.indexOf(groups, state.SelectedScrollGroupId)
    end
end
