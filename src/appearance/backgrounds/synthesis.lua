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
    local bgVars = {
        snapTable = {},
        pulseCount = 0,
        snapOffset = 0,
        lastDifference = 0
    }

    getVariables("synthesis", bgVars)

    local circleSize = 10

    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local maxDim = math.sqrt(dim.x ^ 2 + dim.y ^ 2)

    local curTime = state.SongTime

    local tl = game.getTimingPointAt(curTime)
    local msptl = 60000 / tl.Bpm * math.toNumber(tl.Signature)

    local snapTable = bgVars.snapTable
    local pulseCount = bgVars.pulseCount
    local mostRecentStart = game.getNoteOffsetAt(curTime)

    local nearestBar = map.GetNearestSnapTimeFromTime(false, 1, curTime)

    if (#snapTable >= (maxDim / 1.6) / circleSize) then
        bgVars.snapOffset = circleSize
        table.remove(snapTable, 1)
    end

    if (bgVars.snapOffset > 0.001) then
        bgVars.snapOffset = bgVars.snapOffset * 0.99 ^ state.DeltaTime
    end

    if (curTime - mostRecentStart < bgVars.lastDifference) then
        table.insert(snapTable, game.getSnapAt(mostRecentStart, true))
    end

    bgVars.lastDifference = curTime - mostRecentStart

    for idx, snap in pairs(snapTable) do
        local colTbl = RGB_SNAP_MAP[snap]

        ctx.AddCircle(dim / 2 + topLeft, circleSize * (idx - 1) + bgVars.snapOffset,
            rgbaToUint(colTbl[1] * 4 / 5 + 51, colTbl[2] * 4 / 5 + 51, colTbl[3] * 4 / 5 + 51, 100))
    end

    saveVariables("synthesis", bgVars)
end
