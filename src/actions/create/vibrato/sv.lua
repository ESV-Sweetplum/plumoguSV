---comment
---@param menuVars any
---@param heightFn fun(t: number, idx?: integer): number
function svVibrato(menuVars, heightFn)
    printLegacyLNMessage()
    local offsets = game.get.uniqueNoteOffsetsBetweenSelected(true)
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

        if teleportCount < 2 then
            print("e!", "Some notes are too close together to place vibrato. Check for notes that are 1ms apart.")
            return
        end

        if (menuVars.sides == 1) then
            for tp = 1, teleportCount do
                local x = (tp - 1) / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local height = heightFn(math.floor((tp - 1) / 2) * 2 / teleportCount * posDifference +
                    startPos, tp)
                if (tp % 2 == 1) then
                    height = -height
                end
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
        elseif (menuVars.sides == 2) then
            teleportCount = teleportCount + 1
            prepareDisplacingSVs(startVibro, svsToAdd, svTimeIsAdded, nil,
                -heightFn(startPos, 0), 0)
            for tp = 1, teleportCount - 2, 2 do
                local x = tp / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local prevHeight = heightFn((tp - 1) / (teleportCount - 1) * posDifference +
                    startPos, tp)
                local newHeight = heightFn((tp + 1) / (teleportCount - 1) * posDifference +
                    startPos, tp + 1)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    prevHeight + newHeight, 0)
                x = (tp + 1) / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -newHeight * 2, 0)
            end
            prepareDisplacingSVs(nextVibro * (1 - 2 / teleportCount) + 2 * startVibro / teleportCount, svsToAdd,
                svTimeIsAdded, nil,
                heightFn(posDifference * (1 - 2 / (teleportCount - 1)) + startPos, teleportCount - 2) +
                heightFn(endPos, teleportCount - 1), 0)
            prepareDisplacingSVs(nextVibro * (1 - 1 / teleportCount) + startVibro / teleportCount, svsToAdd,
                svTimeIsAdded, nil,
                -heightFn(endPos, teleportCount), 0)
        else
            for tp = 1, teleportCount - 2, 3 do
                local x = (tp - 1) / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local height = heightFn(startPos + (tp - 1) / teleportCount * posDifference, (tp - 1) / 3 + 1)
                local newHeight = heightFn(startPos + (tp + 2) / teleportCount * posDifference, (tp - 1) / 3 + 2)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -height, 0)
                x = tp / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height + newHeight, 0)
                x = (tp + 1) / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -newHeight, 0)
            end
        end
    end

    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
