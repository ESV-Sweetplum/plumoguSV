---comment
---@param menuVars any
---@param heightFn fun(t: number, idx?: integer): number
function svVibrato(menuVars, heightFn)
    local offsets = game.uniqueNoteOffsetsBetweenSelected(true)
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToAdd = {} ---@type ScrollVelocity[]
    local svsToRemove = {} ---@type ScrollVelocity[]
    local svTimeIsAdded = {}

    local fps = VIBRATO_FRAME_RATES[menuVars.vibratoQuality] + 0.69

    for i = 1, #offsets - 1 do
        local startVibro = offsets[i]
        local nextVibro = offsets[i + 1]
        local startPos = (startVibro - startOffset) / (endOffset - startOffset)
        local endPos = (nextVibro - startOffset) / (endOffset - startOffset)
        local posDifference = endPos - startPos

        local roundingFactor = math.max(menuVars.sides, 2)
        local teleportCount = math.floor((nextVibro - startVibro) / 1000 * fps / roundingFactor) * roundingFactor

        if (teleportCount < 2) then
            print("e!", "Some notes are too close together to place vibrato.")
            return
        end

        if (menuVars.sides == 1) then
            for tp = 1, teleportCount do
                local x = (tp - 1) / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local height = heightFn(math.floor(tp / 2) * 2 / teleportCount * posDifference +
                    startPos, tp)
                if (tp % 2 == 1) then
                    height = -height
                end
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
        elseif (menuVars.sides == 2) then
            prepareDisplacingSVs(startVibro, svsToAdd, svTimeIsAdded, nil,
                -heightFn(startPos, 1), 0)
            for tp = 1, teleportCount - 2 do
                local x = tp / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local initHeight = heightFn(tp / teleportCount * posDifference +
                    startPos, tp)
                local newHeight = heightFn((tp + 1) / teleportCount * posDifference +
                    startPos, tp + 1)
                local height = initHeight + newHeight
                if (tp % 2 == 0) then
                    height = -height
                end
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
            prepareDisplacingSVs(nextVibro * (1 - 1 / teleportCount) + startVibro * (1 / teleportCount), svsToAdd,
                svTimeIsAdded,
                heightFn((1 - 2 / teleportCount) * posDifference + startPos, teleportCount), 0, nil)
        else
            prepareDisplacingSVs(startVibro, svsToAdd, svTimeIsAdded, nil,
                -heightFn(startPos, 1), 0)
            prepareDisplacingSVs(startVibro, svsToAdd, svTimeIsAdded, nil,
                heightFn(startPos + 2 / (teleportCount - 1) * posDifference, 3) + heightFn(startPos, 1), 0)
            for tp = 3, teleportCount - 3, 3 do
                local x = (tp - 1) / (teleportCount - 1)
                local offset = nextVibro * x + startVibro * (1 - x)
                local height = heightFn(startPos + tp / (teleportCount - 1) * posDifference, tp)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -height, 0)
                x = tp / (teleportCount - 1)
                offset = nextVibro * x + startVibro * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -height, 0)
                x = (tp + 1) / (teleportCount - 1)
                offset = nextVibro * x + startVibro * (1 - x)
                local newHeight = heightFn(startPos + (tp + 3) / (teleportCount - 1) * posDifference, tp + 2)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height + newHeight, 0)
            end
            prepareDisplacingSVs(nextVibro, svsToAdd, svTimeIsAdded,
                heightFn(endPos, teleportCount), 0, nil)
        end
    end

    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
