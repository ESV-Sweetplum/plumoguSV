function getMapStats()
    local currentTg = state.SelectedScrollGroupId
    local tgList = map.GetTimingGroupIds()
    local svSum = 0
    local ssfSum = 0
    for _, tg in ipairs(tgList) do
        state.SelectedScrollGroupId = tg
        svSum = svSum + #map.ScrollVelocities
        ssfSum = ssfSum + #map.ScrollSpeedFactors
    end
    print("s!",
        "That's an average of " ..
        math.round(svSum * 1000 / map.TrackLength, 2) ..
        " SVs per second, or " .. math.round(ssfSum * 1000 / map.TrackLength, 2) .. " SSFs per second.")
    print("s!", "This map also contains " .. #map.TimingPoints .. " timing points.")
    print("s!",
        "This map has " .. svSum .. " SVs and " .. ssfSum .. " SSFs across " .. #tgList .. " timing groups.")
    print("w!",
        "Remember that the quality of map has no correlation with the object count! Try to be optimal in your object usage.")
    state.SelectedScrollGroupId = currentTg
end
