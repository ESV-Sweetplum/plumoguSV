function renderMeasureDataWidget()
    if #state.SelectedHitObjects == 0 then return end

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
    if (#state.SelectedHitObjects == 1 and state.SelectedHitObjects[1].EndTime ~= 0) then
        uniqueDict = { state.SelectedHitObjects[1].StartTime, state.SelectedHitObjects[1].EndTime }
        imgui.BeginTooltip()
        AddSeparator()
        imgui.EndTooltip()
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
