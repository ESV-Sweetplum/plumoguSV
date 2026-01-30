function alignTimingLines()
    local tpsToRemove = {}
    local currentTP = state.CurrentTimingPoint
    local starttime = currentTP.StartTime
    local length = map.GetTimingPointLength(currentTP)
    local endtime = starttime + length
    local signature = tn(currentTP.Signature)
    local bpm = currentTP.Bpm

    local mspb = 60000 / bpm
    local msptl = mspb * signature

    local noteTimes = table.property(map.HitObjects, "StartTime")

    local times = {}
    local tpsToAdd = {}

    for time = starttime, endtime, msptl do
        local originalTime = math.floor(time)
        while (isTruthy(noteTimes) and (noteTimes[1] < originalTime - 5)) do
            table.remove(noteTimes, 1)
        end
        if (not isTruthy(noteTimes)) then
            table.insert(times, originalTime)
        elseif (math.abs(noteTimes[1] - originalTime) <= 5) then
            table.insert(times, noteTimes[1])
        else
            table.insert(times, originalTime)
        end
    end
    for _, time in ipairs(times) do
        local initialTl = game.get.timingPointAt(time)
        if (initialTl.StartTime == time) then
            table.insert(tpsToRemove, initialTl)
        end
        table.insert(tpsToAdd, utils.CreateTimingPoint(time, initialTl.Bpm, initialTl.Signature, initialTl.Hidden))
    end
    actions.PerformBatch({
        createEA(action_type.AddTimingPointBatch, tpsToAdd),
        createEA(action_type.RemoveTimingPointBatch, tpsToRemove)
    })

    toggleablePrint("s!", "Created " .. #tpsToAdd .. pluralize(" timing point.", #tpsToAdd, -2))
    if (isTruthy(tpsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #tpsToRemove .. pluralize(" timing point.", #tpsToRemove, -2))
    end
end

function fixFlippedLNEnds()
    local svsToRemove = {}
    local svsToAdd = {}
    local svTimeIsAdded = {}
    local lnEndTimeFixed = {}
    local fixedLNEndsCount = 0
    for _, ho in ipairs(map.HitObjects) do
        local lnEndTime = ho.EndTime
        local isLN = lnEndTime ~= 0
        local endHasNegativeSV = (game.get.svMultiplierAt(lnEndTime) <= 0)
        local hasntAlreadyBeenFixed = lnEndTimeFixed[lnEndTime] == nil
        if isLN and endHasNegativeSV and hasntAlreadyBeenFixed then
            lnEndTimeFixed[lnEndTime] = true
            local multiplier = getUsableDisplacementMultiplier(lnEndTime)
            local duration = 1 / multiplier
            local timeAt = lnEndTime
            local timeAfter = lnEndTime + duration
            local timeAfterAfter = lnEndTime + duration + duration
            svTimeIsAdded[timeAt] = true
            svTimeIsAdded[timeAfter] = true
            svTimeIsAdded[timeAfterAfter] = true
            local svMultiplierAt = game.get.svMultiplierAt(timeAt)
            local svMultiplierAfter = game.get.svMultiplierAt(timeAfter)
            local svMultiplierAfterAfter = game.get.svMultiplierAt(timeAfterAfter)
            local newMultiplierAt = 0.001
            local newMultiplierAfter = svMultiplierAt + svMultiplierAfter
            local newMultiplierAfterAfter = svMultiplierAfterAfter
            addSVToList(svsToAdd, timeAt, newMultiplierAt, true)
            addSVToList(svsToAdd, timeAfter, newMultiplierAfter, true)
            addSVToList(svsToAdd, timeAfterAfter, newMultiplierAfterAfter, true)
            fixedLNEndsCount = fixedLNEndsCount + 1
        end
    end
    local startOffset = map.HitObjects[1].StartTime
    local endOffset = map.HitObjects[#map.HitObjects].EndTime
    if endOffset == 0 then endOffset = map.HitObjects[#map.HitObjects].StartTime end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)

    local type = isTruthy(fixedLNEndsCount) and "s!" or "w!"
    print(type, "Fixed " .. fixedLNEndsCount .. pluralize(" flipped LN end.", fixedLNEndsCount, -2))
end

function mergeSVsAndSSFs()
    local editorActions = {}
    local svSum = 0
    local ssfSum = 0
    local ogTg = state.SelectedScrollGroupId

    for tgId, tg in pairs(map.TimingGroups) do
        state.SelectedScrollGroupId = tgId
        local svTimeDict = {}
        local svsToRemove = {}
        local ssfTimeDict = {}
        local ssfsToRemove = {}

        for _, sv in ipairs(table.reverse(map.ScrollVelocities)) do -- reverse to prioritize second sv in list
            if (svTimeDict[sv.StartTime]) then
                table.insert(svsToRemove, sv)
            else
                svTimeDict[sv.StartTime] = true
            end
        end

        for _, ssf in ipairs(table.reverse(map.ScrollSpeedFactors)) do -- reverse to prioritize second sv in list
            if (ssfTimeDict[ssf.StartTime]) then
                table.insert(ssfsToRemove, ssf)
            else
                ssfTimeDict[ssf.StartTime] = true
            end
        end
        table.insert(editorActions, createEA(action_type.RemoveScrollVelocityBatch, svsToRemove))
        table.insert(editorActions, createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove))

        svSum = svSum + #svsToRemove
        ssfSum = ssfSum + #ssfsToRemove
    end

    if (isTruthy(svSum + ssfSum)) then actions.PerformBatch(editorActions) end
    local type = isTruthy(svSum + ssfSum) and "s!" or "w!"
    print(type,
        table.concat({ "Removed ", svSum, pluralize(" SV", svSum), " and ", ssfSum, pluralize(
            " SSF.", ssfSum, -2) }))

    state.SelectedScrollGroupId = ogTg
end

function mergeNotes()
    local noteDict = {}
    local notesToRemove = {}
    for _, ho in ipairs(map.HitObjects) do
        if (not noteDict[ho.StartTime]) then
            noteDict[ho.StartTime] = { [ho.Lane] = true }
        else
            if (not noteDict[ho.StartTime][ho.Lane]) then
                noteDict[ho.StartTime][ho.Lane] = true
            else
                table.insert(notesToRemove, ho)
            end
        end
    end
    if (isTruthy(notesToRemove)) then actions.RemoveHitObjectBatch(notesToRemove) end
    local type = isTruthy(notesToRemove) and "s!" or "w!"
    print(type, "Removed " .. #notesToRemove .. pluralize(" note.", #notesToRemove, -2))
end

function removeUnnecessarySVsAndSSFs()
    local editorActions = {}
    local ogTG = state.SelectedScrollGroupId
    local svSum = 0
    local ssfSum = 0
    for tgId, tg in pairs(map.TimingGroups) do
        local svsToRemove = {}
        state.SelectedScrollGroupId = tgId
        local prevMultiplier = state.SelectedScrollGroup.InitialScrollVelocity or map.InitialScrollVelocity or 1
        for _, sv in ipairs(map.ScrollVelocities) do
            local m = sv.Multiplier
            if m == prevMultiplier then table.insert(svsToRemove, sv) end
            prevMultiplier = m
        end
        table.insert(editorActions, createEA(action_type.RemoveScrollVelocityBatch, svsToRemove, tg))
        svSum = svSum + #svsToRemove

        local ssfsToRemove = {}
        local tgSsfCount = #map.ScrollSpeedFactors
        local doublePrevSSFMult = 1
        local prevSSFMult = 1
        local atRiskSSF = {}
        for idx, ssf in ipairs(map.ScrollSpeedFactors) do
            if (idx == 1) then goto nextSSF end
            if (ssf.Multiplier == prevSSFMult and prevSSFMult == doublePrevSSFMult) then
                table.insert(ssfsToRemove, atRiskSSF)
            end
            ::nextSSF::
            doublePrevSSFMult = prevSSFMult
            prevSSFMult = ssf.Multiplier
            atRiskSSF = ssf
        end
        table.insert(editorActions, createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove, tg))
        ssfSum = ssfSum + #ssfsToRemove
    end
    if (isTruthy(svSum + ssfSum)) then actions.PerformBatch(editorActions) end
    local type = isTruthy(svSum + ssfSum) and "s!" or "w!"
    print(type,
        table.concat({ "Removed ", svSum, pluralize(" SV", svSum), " and ", ssfSum, pluralize(" SSF.", ssfSum, -2) }))
    state.SelectedScrollGroupId = ogTG
end

function removeAllHitSounds()
    local hitsoundActions = {}
    local objs = {}
    if (not isTruthy(#state.SelectedHitObjects)) then
        print("e!", "You are not currently selecting anything.")
        return
    end
    local hos = game.get.uniqueNotesBetweenSelected()
    for _, ho in ipairs(hos) do
        local hs = tonumber(ho.HitSound)
        if hs > 1 then
            table.insert(hitsoundActions, createEA(action_type.RemoveHitsound, { ho }, hs))
            table.insert(objs, ho.StartTime .. "|" .. ho.Lane)
        end
    end
    local type = isTruthy(hitsoundActions) and "s!" or "w!"
    print(type,
        "Removed " ..
        #hitsoundActions .. pluralize(" hitsound.", #hitsoundActions, -2))
    print("w!", "Note that the Quaver hitsound system is funky and some hitsounds exist that aren't audible.")
    imgui.SetClipboardText(table.concat(objs, ","))
    actions.PerformBatch(hitsoundActions)
end

function removePostTGSVsAndSSFs()
    local editorActions = {}
    local ogTG = state.SelectedScrollGroupId
    local svSum = 0
    local ssfSum = 0
    local lastHoDict = {}
    for _, ho in pairs(map.HitObjects) do
        local maxTime = math.max(ho.StartTime, ho.EndTime)
        if (not lastHoDict[ho.TimingGroup] or lastHoDict[ho.TimingGroup] < maxTime) then
            lastHoDict[ho.TimingGroup] = maxTime
        end
    end
    for tgId, tg in pairs(map.TimingGroups) do
        if (tg == map.DefaultScrollGroup or tg == map.GlobalScrollGroup) then goto nextTG end
        do
            state.SelectedScrollGroupId = tgId
            local maxTime = lastHoDict[tgId]
            local svsToAdd = {}
            local svsToRemove = {}
            local ssfsToRemove = {}
            for _, sv in pairs(map.ScrollVelocities) do
                if (sv.StartTime > maxTime + 1) then
                    table.insert(svsToRemove, sv)
                end
            end
            for _, ssf in pairs(map.ScrollSpeedFactors) do
                if (ssf.StartTime > maxTime + 1) then
                    table.insert(ssfsToRemove, ssf)
                end
            end
            prepareDisplacingSVs(maxTime, svsToAdd, {}, nil,
                100000, 0)
            table.insert(editorActions, createEA(action_type.RemoveScrollVelocityBatch, svsToRemove))
            table.insert(editorActions, createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove))
            table.insert(editorActions, createEA(action_type.AddScrollVelocityBatch, svsToAdd))
            svSum = svSum + #svsToRemove
            ssfSum = ssfSum + #ssfsToRemove
        end
        ::nextTG::
    end
    if (isTruthy(svSum + ssfSum)) then actions.PerformBatch(editorActions) end
    local type = isTruthy(svSum + ssfSum) and "s!" or "w!"
    print(type,
        table.concat({ "Removed ", svSum, pluralize(" SV", svSum), " and ", ssfSum, pluralize(" SSF.", ssfSum, -2) }))
    state.SelectedScrollGroupId = ogTG
end
