function changeGroups(menuVars)
    if (state.SelectedScrollGroupId == menuVars.designatedTimingGroup) then
        print("w!", "Moving from one timing group to the same timing group will do nothing.")
        return
    end
    local offsets = uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]

    local svsToRemove = game.getSVsBetweenOffsets(startOffset, endOffset, true)
    local ssfsToRemove = game.getSSFsBetweenOffsets(startOffset, endOffset, true)

    local svsToAdd = {}
    local ssfsToAdd = {}

    local oldGroup = state.SelectedScrollGroupId

    for _, sv in ipairs(svsToRemove) do
        table.insert(svsToAdd, createSV(sv.StartTime, sv.Multiplier))
    end
    for _, ssf in ipairs(ssfsToRemove) do
        table.insert(ssfsToAdd, createSSF(ssf.StartTime, ssf.Multiplier))
    end

    local actionList = {}
    local willChangeSVs = menuVars.changeSVs and #svsToRemove ~= 0
    local willChangeSSFs = menuVars.changeSSFs and #ssfsToRemove ~= 0
    if (willChangeSVs) then
        table.insert(actionList, utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svsToRemove))
        state.SelectedScrollGroupId = menuVars
            .designatedTimingGroup -- must change in the middle because previous line applies to previous tg, next line applies to next tg
        table.insert(actionList, utils.CreateEditorAction(action_type.AddScrollVelocityBatch, svsToAdd))
    end
    if (willChangeSSFs) then
        table.insert(actionList, utils.CreateEditorAction(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove))
        state.SelectedScrollGroupId = menuVars.designatedTimingGroup
        table.insert(actionList, utils.CreateEditorAction(action_type.AddScrollSpeedFactorBatch, ssfsToAdd))
    end

    if (#actionList == 0) then
        state.SelectedScrollGroupId = oldGroup
        return
    end

    actions.PerformBatch(actionList)
    if (willChangeSVs) then
        toggleablePrint("s!",
            "Successfully moved " .. #svsToRemove ..
            pluralize(" SV", #svsToRemove) .. ' to "' .. menuVars.designatedTimingGroup .. '".')
    end
    if (willChangeSSFs) then
        toggleablePrint("s!",
            "Successfully moved " .. #ssfsToRemove ..
            pluralize(" SSF", #ssfsToRemove) .. ' to "' .. menuVars.designatedTimingGroup .. '".')
    end
end
