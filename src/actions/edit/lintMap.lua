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
    toggleablePrint("e!", "Deleted " .. #tpsToRemove .. pluralize(" timing point.", #tpsToRemove, -2))
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

    if (truthy(svsToRemove)) then actions.Perform(createEA(action_type.RemoveScrollVelocityBatch, svsToRemove)) end
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
    if (truthy(notesToRemove)) then actions.Perform(createEA(action_type.RemoveHitObjectBatch, notesToRemove)) end
    local type = truthy(notesToRemove) and "s!" or "w!"
    print(type, "Removed " .. #notesToRemove .. pluralize(" note.", #notesToRemove, -2))
end
