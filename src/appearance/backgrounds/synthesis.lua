local RGB_SNAP_MAP = {
    [1] = { 255, 0, 0 },
    [2] = { 0, 0, 255 },
    [3] = { 120, 0, 255 },
    [4] = { 255, 255, 0 },
    [5] = { 255, 255, 255 },
    [6] = { 255, 0, 255 },
    [8] = { 255, 120, 0 },
    [12] = { 0, 120, 255 },
    [16] = { 0, 255, 0 },
}

function renderSynthesis()
    local circleSize = 10

    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local maxDim = math.sqrt(dim.x ^ 2 + dim.y ^ 2)

    local curTime = state.SongTime

    local tl = getTimingPointAt(curTime)
    local msptl = 60000 / tl.Bpm * math.toNumber(tl.Signature)

    local snapTable = state.GetValue("synthesis_snapTable", {})
    local pulseCount = state.GetValue("synthesis_pulseCount", 0)
    local mostRecentStart = getHitObjectStartTimeAt(curTime)

    local nearestBar = map.GetNearestSnapTimeFromTime(false, 1, curTime)

    if (#snapTable >= (maxDim / 1.6) / circleSize) then
        state.SetValue("synthesis_snapOffset", circleSize)
        table.remove(snapTable, 1)
    end

    local snapOffset = state.GetValue("synthesis_snapOffset", 0)
    if (snapOffset > 0.001) then
        snapOffset = snapOffset * 0.99 ^ state.DeltaTime
    end

    local lastDifference = state.GetValue("synthesis_lastDifference", 0)
    if (curTime - mostRecentStart < lastDifference) then
        table.insert(snapTable, getSnapFromTime(mostRecentStart, true))
    end

    state.SetValue("synthesis_lastDifference", curTime - mostRecentStart)
    state.SetValue("synthesis_snapTable", snapTable)

    for idx, snap in pairs(snapTable) do
        local colTbl = RGB_SNAP_MAP[snap]

        ctx.AddCircle(dim / 2 + topLeft, circleSize * (idx - 1) + snapOffset,
            rgbaToUint(colTbl[1] * 4 / 5 + 51, colTbl[2] * 4 / 5 + 51, colTbl[3] * 4 / 5 + 51, 100))
    end

    state.SetValue("synthesis_snapOffset", snapOffset)
end
