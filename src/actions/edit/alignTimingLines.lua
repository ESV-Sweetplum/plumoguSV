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
        if (#noteTimes == 0) then
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
        utils.CreateEditorAction(action_type.AddTimingPointBatch, timingpoints),
        utils.CreateEditorAction(action_type.RemoveTimingPointBatch, tpsToRemove)
    })

    toggleablePrint("s!", "Created " .. #timingpoints .. pluralize(" timing point.", #timingpoints, -2))
    toggleablePrint("e!", "Deleted " .. #tpsToRemove .. pluralize(" timing point.", #tpsToRemove, -2))
end
