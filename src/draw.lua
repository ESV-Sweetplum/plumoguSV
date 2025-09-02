function draw()
    if (not state.CurrentTimingPoint) then return end
    local performanceMode = globalVars.performanceMode
    tempClockCount = 0

    state.IsWindowHovered = imgui.IsWindowHovered()

    startNextWindowNotCollapsed("plumoguSV-dev")
    imgui.SetNextWindowSizeConstraints(vctr2(0), vector.Max(table.vectorize2(state.WindowSize) / 2, vctr2(600)))
    imgui.Begin("plumoguSV-dev", imgui_window_flags.AlwaysAutoResize)

    if (not performanceMode) then
        renderBackground()
        drawCapybaraParent()
        drawCursorTrail()
        pulseController()
        checkForGlobalHotkeys()

        if (clock.listen("appearanceRefresh", 1000)) then
            setPluginAppearance()
        end
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

    imgui.End()

    logoThread()

    cache.boolean.changeOccurred = false
end

function renderNoteDataWidget()
    if (#state.SelectedHitObjects ~= 1) then return end
    imgui.BeginTooltip()
    imgui.Text("Note Info:")
    local selectedNote = state.SelectedHitObjects[1]
    imgui.Text("StartTime = " .. selectedNote.StartTime .. " ms")
    local noteIsNotLN = selectedNote.EndTime == 0
    if noteIsNotLN then
        imgui.EndTooltip()
        return
    end

    local lnLength = selectedNote.EndTime - selectedNote.StartTime
    imgui.Text("EndTime = " .. selectedNote.EndTime .. " ms")
    imgui.Text("LN Length = " .. lnLength .. " ms")
    imgui.EndTooltip()
end

function renderMeasureDataWidget()
    if #state.SelectedHitObjects < 2 then return end

    local widgetVars = {
        oldStartOffset = -69,
        oldEndOffset = -69,
        nsvDistance = 0,
        roundedSVDistance = 0,
        roundedAvgSV = 0
    }

    cache.loadTable("measureWidget", widgetVars)

    local uniqueDict = {}
    for _, ho in ipairs(state.SelectedHitObjects) do -- game.uniqueSelectedNoteOffsets was not used here because this approach exits the function faster
        if (not table.contains(uniqueDict, ho.StartTime)) then
            table.insert(uniqueDict, ho.StartTime)
        end
        if (#uniqueDict > 2) then return end
    end
    uniqueDict = sort(uniqueDict, sortAscending) ---@type number[]
    local startOffset = uniqueDict[1]
    local endOffset = uniqueDict[2] or uniqueDict[1]
    if (math.abs(endOffset - startOffset) < 1e-10) then return end
    if (endOffset ~= widgetVars.oldEndOffset or startOffset ~= widgetVars.oldStartOffset or cache.boolean.changeOccurred) then
        svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
        widgetVars.nsvDistance = endOffset - startOffset
        addStartSVIfMissing(svsBetweenOffsets, startOffset)
        totalDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset, endOffset)
        widgetVars.roundedSVDistance = math.round(totalDistance, 3)
        avgSV = totalDistance / (endOffset - startOffset)
        widgetVars.roundedAvgSV = math.round(avgSV, 3)
    end
    imgui.BeginTooltip()
    imgui.Text("Measure Info:")
    imgui.Text("NSV Distance = " .. widgetVars.nsvDistance .. " ms")
    imgui.Text("SV Distance = " .. widgetVars.roundedSVDistance .. " msx")
    imgui.Text("Avg SV = " .. widgetVars.roundedAvgSV .. "x")
    imgui.EndTooltip()

    widgetVars.oldStartOffset = startOffset
    widgetVars.oldEndOffset = endOffset

    cache.saveTable("measureWidget", widgetVars)
end
