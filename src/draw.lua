function draw()
    if (not state.CurrentTimingPoint) then return end

    state.SetValue("ComputableInputFloatIndex", 1)
    state.SetValue("StatedInputTextIndex", 1)
    state.IsWindowHovered = imgui.IsWindowHovered()

    drawCapybaraParent()
    drawCursorTrail()
    setPluginAppearance()

    startNextWindowNotCollapsed("plumoguSV-autoOpen")
    imgui.Begin("plumoguSV-dev", imgui_window_flags.AlwaysAutoResize)

    renderBackground()

    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
    imgui.BeginTabBar("SV tabs")
    for i = 1, #TAB_MENUS do
        createMenuTab(TAB_MENUS[i])
    end
    imgui.EndTabBar()

    if (globalVars.showVibratoWidget) then
        imgui.Begin("plumoguSV-Vibrato", imgui_window_flags.AlwaysAutoResize)
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
    if (state.GetValue("showTutorialWindow")) then
        renderTutorialMenu()
    end

    imgui.End()

    pulseController()
    checkForGlobalHotkeys()
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
    local widgetVars = {
        oldStartOffset = -69,
        oldEndOffset = -69,
        nsvDistance = 0,
        roundedSVDistance = 0,
        roundedAvgSV = 0
    }

    cache.loadTable("measureWidget", widgetVars)

    if #state.SelectedHitObjects < 2 then return end
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
    if (endOffset ~= widgetVars.oldEndOffset or startOffset ~= widgetVars.oldStartOffset) then
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
