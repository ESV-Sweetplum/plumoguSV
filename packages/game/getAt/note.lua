require("packages.table.searchClosest")
function game.getNoteOffsetAt(offset, forward)
    local startTimes = cache.lists.hitObjectStartTimes
    if (not truthy(startTimes)) then return -1 end
    if (state.SongTime > startTimes[#startTimes]) then return startTimes[#startTimes] end
    if (state.SongTime < startTimes[1]) then return startTimes[1] end

    local startTime = table.searchClosest(startTimes, offset, tn(forward) + 1)
    return startTime
end
