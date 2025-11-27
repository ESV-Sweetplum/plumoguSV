function alignTimingLines()
    local tpsToRemove = {}
    local currentTP = state.CurrentTimingPoint
    local starttime = currentTP.StartTime
    local length = map.GetTimingPointLength(currentTP)
    local endtime = starttime + length
    local signature = math.toNumber(currentTP.Signature)
    local bpm = currentTP.Bpm

    local mspb = 60000 / bpm
    local msptl = mspb * signature

    local noteTimes = table.property(map.HitObjects, "StartTime")

    local times = {}
    local timingpoints = {}

    for time = starttime, endtime, msptl do
        local originalTime = math.floor(time)
        while (truthy(noteTimes) and (noteTimes[1] < originalTime - 5)) do
            table.remove(noteTimes, 1)
        end
        if (not truthy(noteTimes)) then
            table.insert(times, originalTime)
        elseif (math.abs(noteTimes[1] - originalTime) <= 5) then
            table.insert(times, noteTimes[1])
        else
            table.insert(times, originalTime)
        end
    end
    for _, time in ipairs(times) do
        if (game.getTimingPointAt(time).StartTime == time) then
            table.insert(tpsToRemove, game.getTimingPointAt(time))
        end
        table.insert(timingpoints, utils.CreateTimingPoint(time, bpm, signature))
    end
    actions.PerformBatch({
        createEA(action_type.AddTimingPointBatch, timingpoints),
        createEA(action_type.RemoveTimingPointBatch, tpsToRemove)
    })

    toggleablePrint("s!", "Created " .. #timingpoints .. pluralize(" timing point.", #timingpoints, -2))
    if (truthy(#tpsToRemove)) then
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
        local endHasNegativeSV = (game.getSVMultiplierAt(lnEndTime) <= 0)
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
            local svMultiplierAt = game.getSVMultiplierAt(timeAt)
            local svMultiplierAfter = game.getSVMultiplierAt(timeAfter)
            local svMultiplierAfterAfter = game.getSVMultiplierAt(timeAfterAfter)
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

    local type = truthy(fixedLNEndsCount) and "s!" or "w!"
    print(type, "Fixed " .. fixedLNEndsCount .. pluralize(" flipped LN end.", fixedLNEndsCount, -2))
end

function mergeSVs()
    local svTimeDict = {}
    local svsToRemove = {}
    for _, sv in ipairs(table.reverse(map.ScrollVelocities)) do -- reverse to prioritize second sv in list
        if (svTimeDict[sv.StartTime]) then
            table.insert(svsToRemove, sv)
        else
            svTimeDict[sv.StartTime] = true
        end
    end

    if (truthy(svsToRemove)) then actions.RemoveScrollVelocityBatch(svsToRemove) end
    local type = truthy(svsToRemove) and "s!" or "w!"
    print(type, "Removed " .. #svsToRemove .. pluralize(" SV.", #svsToRemove, -2))
end

function mergeSSFs()
    local ssfTimeDict = {}
    local ssfsToRemove = {}
    for _, ssf in ipairs(table.reverse(map.ScrollSpeedFactors)) do -- reverse to prioritize second sv in list
        if (ssfTimeDict[ssf.StartTime]) then
            table.insert(ssfsToRemove, ssf)
        else
            ssfTimeDict[ssf.StartTime] = true
        end
    end

    if (truthy(ssfsToRemove)) then actions.Perform(createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove)) end
    local type = truthy(ssfsToRemove) and "s!" or "w!"
    print(type, "Removed " .. #ssfsToRemove .. pluralize(" SSF.", #ssfsToRemove, -2))
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
    if (truthy(notesToRemove)) then actions.RemoveHitObjectBatch(notesToRemove) end
    local type = truthy(notesToRemove) and "s!" or "w!"
    print(type, "Removed " .. #notesToRemove .. pluralize(" note.", #notesToRemove, -2))
end

function removeUnnecessarySVs()
    local editorActions = {}
    local ogTg = state.SelectedScrollGroupId
    local svSum = 0
    for tgId, tg in pairs(map.TimingGroups) do
        local svsToRemove = {}
        state.SelectedScrollGroupId = tgId
        local prevMultiplier = state.SelectedScrollGroup.InitialScrollVelocity or map.InitialScrollVelocity or 1
        for _, sv in ipairs(map.ScrollVelocities) do
            local m = sv.Multiplier
            if (m == prevMultiplier) then table.insert(svsToRemove, sv) end
            prevMultiplier = m
        end
        table.insert(editorActions, createEA(action_type.RemoveScrollVelocityBatch, svsToRemove, tg))
        svSum = svSum + #svsToRemove
    end
    if (truthy(svSum)) then actions.PerformBatch(editorActions) end
    local type = truthy(svSum) and "s!" or "w!"
    print(type, "Removed " .. svSum .. pluralize(" SV.", svSum, -2))
    state.SelectedScrollGroupId = ogTg
end

function removeAllHitSounds()
    local hitsoundActions = {}
    local objs = {}
    for _, ho in ipairs(map.HitObjects) do
        local hs = tonumber(ho.HitSound)
        if (hs > 1) then
            table.insert(hitsoundActions, createEA(action_type.RemoveHitsound, { ho }, hs))
            table.insert(objs, ho.StartTime .. "|" .. ho.Lane)
        end
    end
    local type = truthy(hitsoundActions) and "s!" or "w!"
    print(type,
        "Removed " ..
        #hitsoundActions .. pluralize(" hitsound.", #hitsoundActions, -2))
    print("w!", "Note that the Quaver hitsound system is funky and some hitsounds exist that aren't audible.")
    imgui.SetClipboardText(table.concat(objs, ","))
    actions.PerformBatch(hitsoundActions)
end
