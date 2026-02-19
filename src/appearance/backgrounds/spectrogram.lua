function renderSVSpectrogram()
    local binCount = 12
    local doubleBinCount = binCount * 2

    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos() + vector.New(0, 50)
    local dim = imgui.GetWindowSize() - vector.New(0, 50)
    local bottomLeft = topLeft + vector.New(0, dim.y)
    local binWidth = dim.x / binCount
    local binScalingFactor = 1.1
    local taperMinTime = 50
    local taperMaxTime = 2000
    local tgCount = #cache.tgList

    for tgId, tg in pairs(map.TimingGroups) do
        local col
        local binValues = {}
        local m = game.get.svMultiplierAt(state.SongTime, tgId)
        local ssf = math.abs(game.get.ssfMultiplierAt(state.SongTime, tgId))
        local startTime = math.max(game.get.svStartTimeAt(state.SongTime, tgId),
            game.get.ssfStartTimeAt(state.SongTime, tgId))
        local afterTime = state.SongTime - startTime
        if (math.abs(afterTime) > taperMaxTime) then
            binValues = table.constructRepeating(0.1, binCount)
            goto nextTg
        end
        for side = -1, 1, 2 do
            for i = -binCount / 2, binCount / 2 - 1 do
                local binLower = ((binScalingFactor ^ (i + binCount / 2)) ^ binScalingFactor - 1) * side
                local binHigher = binLower * binScalingFactor + (binScalingFactor - 1) * side
                local str = math.max(1 - math.abs((m * ssf - (binLower + binHigher) / 2) / (binHigher - binLower)), 0) *
                    0.99 +
                    0.01
                str = str *
                    math.pow((1 - math.clamp((afterTime - taperMinTime) / (taperMaxTime - taperMinTime), 0, 1)), 4)
                if (side == -1) then
                    table.insert(binValues, 1, str)
                else
                    table.insert(binValues, str)
                end
            end
        end

        binValues = smoothenSpectrogram(binValues)
        col = color.vrgbaToUint(color.strToRgba(tg.ColorRgb or '255,255,255')) - color.int.alphaMask * 200

        if (tgCount == 2) then
            col = imgui.GetColorU32(imgui_col.Text, 0.5)
            rCol = imgui.GetColorU32(imgui_col.CheckMark, 0.5)
        end

        for i, value in ipairs(binValues) do
            if (tgCount == 2) then
                thisCol = color.vrgbaToUint(color.uintToRgba(col) * (doubleBinCount - i + 1) / (doubleBinCount + 1) +
                    color.uintToRgba(rCol) * (i - 1) / (doubleBinCount + 1))
                nextCol = color.vrgbaToUint(color.uintToRgba(col) * (doubleBinCount - i) / (doubleBinCount + 1) +
                    color.uintToRgba(rCol) * i / (doubleBinCount + 1))
                ctx.AddRectFilledMultiColor(bottomLeft + (i - 1) / doubleBinCount * vector.New(dim.x, 0),
                    bottomLeft + vector.New((i) / doubleBinCount * dim.x, -dim.y * value),
                    thisCol, nextCol, nextCol, thisCol)
            else
                ctx.AddRectFilled(bottomLeft + (i - 1) / doubleBinCount * vector.New(dim.x, 0),
                    bottomLeft + vector.New((i) / doubleBinCount * dim.x, -dim.y * value),
                    col)
            end
        end
        ::nextTg::
    end
end

function smoothenSpectrogram(data)
    if (not cache.gaussianKernel) then
        local k, r = math.createKernel('gaussian', { sigma = 2.6 })
        cache.gaussianKernel = k
        cache.gaussianRadius = r
    end
    local kernel = cache.gaussianKernel
    local radius = cache.gaussianRadius
    local result = {}

    for i = 1, #data do
        local acc = 0
        for k = -radius, radius do
            local idx = i + k
            if idx < 1 then idx = 1 end
            if idx > #data then idx = #data end
            acc = acc + data[idx] * kernel[k + radius + 1]
        end
        result[i] = acc
    end

    return result
end
