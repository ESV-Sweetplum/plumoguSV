function updateDirectEdit()
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not truthy(offsets) and not truthy(cache.lists.directSVList)) then return end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]

    if (not truthy(offsets)) then
        cache.lists.directSVList = {}
        return
    end

    cache.lists.directSVList = game.get.svsBetweenOffsets(firstOffset - 50, lastOffset + 50)
end

function directSVMenu()
    local menuVars = getMenuVars("directSV")

    if (clock.listen("directSV", 300)) then
        updateDirectEdit()
    end
    local svs = cache.lists.directSVList or {}
    if (not truthy(svs)) then
        menuVars.selectableIndex = 1
        if (not truthy(state.SelectedHitObjects)) then
            imgui.TextWrapped("Select a note to view local SVs.")
        else
            imgui
                .TextWrapped("There are no SVs in this area.")
        end
        return
    end

    if (menuVars.selectableIndex > #svs) then menuVars.selectableIndex = #svs end

    menuVars.startTime = ComputableInputFloat("Start Time", svs[menuVars.selectableIndex].StartTime, 10)

    if (imgui.IsItemDeactivatedAfterEdit()) then
        actions.PerformBatch({ createEA(action_type.RemoveScrollVelocity, svs[menuVars.selectableIndex]),
            createEA(action_type.AddScrollVelocity, createSV(menuVars.startTime or 0, menuVars.multiplier)) })
    end

    menuVars.multiplier = ComputableInputFloat("Multiplier", svs[menuVars.selectableIndex].Multiplier, 10)

    if (imgui.IsItemDeactivatedAfterEdit()) then
        actions.PerformBatch({ createEA(action_type.RemoveScrollVelocity, svs[menuVars.selectableIndex]),
            createEA(action_type.AddScrollVelocity, createSV(menuVars.startTime, menuVars.multiplier or 1)) })
    end

    imgui.Separator()

    if (imgui.ArrowButton("##DirectSVLeft", imgui_dir.Left)) then
        menuVars.pageNumber = math.clamp(menuVars.pageNumber - 1, 1, math.ceil(#svs * 0.1))
    end

    KeepSameLine()
    imgui.Text("Page ")
    KeepSameLine()
    imgui.SetNextItemWidth(100)
    _, menuVars.pageNumber = imgui.InputInt("##PageNum", math.clamp(menuVars.pageNumber, 1, math.ceil(#svs * 0.1)), 0)
    KeepSameLine()
    imgui.Text(" of " .. math.ceil(#svs * 0.1))
    KeepSameLine()
    if (imgui.ArrowButton("##DirectSVRight", imgui_dir.Right)) then
        menuVars.pageNumber = math.clamp(menuVars.pageNumber + 1, 1, math.ceil(#svs * 0.1))
    end

    imgui.Separator()
    imgui.Text("Start Time")
    KeepSameLine()
    imgui.SetCursorPosX(150)
    imgui.Text("Multiplier")
    imgui.Separator()

    local startingPoint = 10 * menuVars.pageNumber - 10

    imgui.BeginTable("Test", 2)
    for idx, v in pairs(table.slice(svs, startingPoint + 1, startingPoint + 10)) do
        imgui.PushID(idx)
        imgui.TableNextRow()
        imgui.TableSetColumnIndex(0)
        imgui.Selectable(tostring(math.round(v.StartTime, 2)), menuVars.selectableIndex == idx,
            imgui_selectable_flags.SpanAllColumns)
        if (imgui.IsItemClicked()) then
            menuVars.selectableIndex = idx + startingPoint
        end
        imgui.TableSetColumnIndex(1)
        imgui.SetCursorPosX(150)
        imgui.Text(tostring(math.round(v.Multiplier, 2)));
        imgui.PopID()
    end

    imgui.EndTable()

    cache.saveTable("directSVMenu", menuVars)
end
