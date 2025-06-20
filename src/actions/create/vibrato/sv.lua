function svVibrato(menuVars, heightFunc)
    local offsets = uniqueNoteOffsetsBetweenSelected()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToAdd = {} ---@type ScrollVelocity[]
    local svsToRemove = {} ---@type ScrollVelocity[]
    local svTimeIsAdded = {}

    local fps = VIBRATO_FRAME_RATES[menuVars.vibratoQuality]
    local fpsList = {}

    for i = 1, #offsets - 1 do
        local start = offsets[i]
        local next = offsets[i + 1]
        local startPos = (start - startOffset) / (endOffset - startOffset)
        local endPos = (next - startOffset) / (endOffset - startOffset)
        local posDifference = endPos - startPos
        local trueFPS = fps
        local lowestDecimal = 1e10
        for t = fps - 3, fps + 3 do
            local decimal = ((next - start) / 1000 * fps / 2) % 1
            if (decimal < lowestDecimal) then
                trueFPS = t
                lowestDecimal = decimal
            end
        end

        table.insert(fpsList, trueFPS)

        local teleportCount = math.floor((next - start) / 1000 * trueFPS / 2) * 2

        if (menuVars.sides == 1) then
            for tp = 1, teleportCount do
                local x = (tp - 1) / (teleportCount)
                local offset = next * x + start * (1 - x)
                local height = heightFunc(((math.floor((tp - 1) / 2) * 2) / (teleportCount - 2)) * posDifference +
                    startPos, tp)
                if (tp % 2 == 1) then
                    height = -height
                end
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
        elseif (menuVars.sides == 2) then
            prepareDisplacingSVs(start, svsToAdd, svTimeIsAdded, nil,
                -heightFunc(startPos, 1), 0)
            for tp = 2, teleportCount - 1 do
                local x = (tp - 1) / (teleportCount - 1)
                local offset = next * x + start * (1 - x)
                local initHeight = heightFunc(((math.floor((tp - 2) / 2) * 2) / (teleportCount - 2)) * posDifference +
                    startPos, tp - 1)
                local newHeight = heightFunc(((math.floor((tp - 1) / 2) * 2) / (teleportCount - 2)) * posDifference +
                    startPos, tp)
                local height = initHeight + newHeight
                if (tp % 2 == 1) then
                    height = -height
                end
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
            prepareDisplacingSVs(next, svsToAdd, svTimeIsAdded,
                heightFunc(((math.floor((teleportCount - 2) / 2) * 2) / teleportCount) * posDifference + startPos,
                    teleportCount),
                0, nil)
        else
            teleportCount = math.floor((next - start) / 1000 * trueFPS / 3) * 3
            prepareDisplacingSVs(start, svsToAdd, svTimeIsAdded, nil,
                -heightFunc(startPos, 1), 0)
            prepareDisplacingSVs(start, svsToAdd, svTimeIsAdded, nil,
                heightFunc(startPos + 2 / (teleportCount - 1) * posDifference, 3) + heightFunc(startPos, 1), 0)
            for tp = 3, teleportCount - 3, 3 do
                local x = (tp - 1) / (teleportCount - 1)
                local offset = next * x + start * (1 - x)
                local height = heightFunc(startPos + tp / (teleportCount - 1) * posDifference, tp)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -height, 0)
                x = tp / (teleportCount - 1)
                offset = next * x + start * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -height, 0)
                x = (tp + 1) / (teleportCount - 1)
                offset = next * x + start * (1 - x)
                local newHeight = heightFunc(startPos + (tp + 3) / (teleportCount - 1) * posDifference, tp + 2)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height + newHeight, 0)
            end
            prepareDisplacingSVs(next, svsToAdd, svTimeIsAdded,
                heightFunc(1, teleportCount), 0, nil)
        end
    end

    toggleablePrint("s!", "Created " .. #svsToAdd .. " SVs at a frame rate of " .. table.average(fpsList, true) .. "fps.")

    getRemovableSVs(sort(svsToRemove, sortAscendingStartTime), svTimeIsAdded, startOffset, endOffset, svsToRemove)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
