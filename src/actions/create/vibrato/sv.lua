function svVibrato(menuVars, heightFunc)
    local offsets = uniqueNoteOffsetsBetweenSelected()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToAdd = {} ---@type ScrollVelocity[]
    local svsToRemove = {} ---@type ScrollVelocity[]
    local svTimeIsAdded = {}

    local fps = VIBRATO_FRAME_RATES[menuVars.vibratoQuality]

    for i = 1, #offsets - 1 do
        local start = offsets[i]
        local next = offsets[i + 1]
        local startPos = (start - startOffset) / (endOffset - startOffset)
        local endPos = (next - startOffset) / (endOffset - startOffset)
        local posDifference = endPos - startPos

        local roundingFactor = math.max(menuVars.sides, 2)
        local teleportCount = math.floor((next - start) / 1000 * fps / roundingFactor) * roundingFactor

        if (menuVars.sides == 1) then
            for tp = 1, teleportCount do
                local x = (tp - 1) / (teleportCount)
                local offset = next * x + start * (1 - x)
                local height = heightFunc(((math.floor((tp - 1) * 0.5) * 2) / (teleportCount - 2)) * posDifference +
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
            for tp = 1, teleportCount - 2 do
                local x = tp / (teleportCount - 1)
                local offset = next * x + start * (1 - x)
                local initHeight = heightFunc(tp / (teleportCount - 1) * posDifference +
                    startPos, tp - 1)
                local newHeight = heightFunc((tp + 1) / (teleportCount - 1) * posDifference +
                    startPos, tp)
                local height = initHeight + newHeight
                if (tp % 2 == 0) then
                    height = -height
                end
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
            prepareDisplacingSVs(next, svsToAdd, svTimeIsAdded,
                heightFunc(endPos, teleportCount), 0, nil)
        else
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
                heightFunc(endPos, teleportCount), 0, nil)
        end
    end

    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
