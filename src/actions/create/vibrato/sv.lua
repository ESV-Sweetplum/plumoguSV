---comment
---@param menuVars any
---@param heightFn fun(t: number, idx?: integer): number
function svVibrato(menuVars, heightFn)
    printLegacyLNMessage()
    local deviance = menuVars.deviationDistance or 0
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
            print('e!', 'Some notes are too close together to place vibrato. Check for notes that are 1ms apart.')
            return
        end

        if (menuVars.sides == 1) then
            for tp = 1, teleportCount, 2 do
                local x = (tp - 1) / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local height = heightFn(math.floor((tp - 1) / 2) * 2 / teleportCount * posDifference +
                    startPos, tp)
                height = deviateVibratoHeight(height, menuVars.deviationFunctionIndex, menuVars.deviationDistance)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
                x = tp / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                height = -height
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
        elseif (menuVars.sides == 2) then
            teleportCount = teleportCount + 1
            prepareDisplacingSVs(startVibro, svsToAdd, svTimeIsAdded, nil,
                -heightFn(startPos, 0), 0)
            local prevHeight = heightFn(startPos, 0)
            for tp = 1, teleportCount - 2, 2 do
                local x = tp / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local newHeight = heightFn((tp + 1) / (teleportCount - 1) * posDifference +
                    startPos, tp + 1)
                newHeight = deviateVibratoHeight(newHeight, menuVars.deviationFunctionIndex, menuVars.deviationDistance)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    prevHeight + newHeight, 0)
                x = (tp + 1) / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                local multiplicativeFactor = tp == teleportCount - 2 and 1 or 2
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -newHeight * multiplicativeFactor, 0)
                prevHeight = newHeight
            end
        else
            local prevHeight = heightFn(startPos, 1)
            for tp = 1, teleportCount - 2, 3 do
                local x = (tp - 1) / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local newHeight = heightFn(startPos + (tp + 2) / teleportCount * posDifference, (tp - 1) / 3 + 2)
                newHeight = deviateVibratoHeight(newHeight, menuVars.deviationFunctionIndex, menuVars.deviationDistance)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -prevHeight, 0)
                x = tp / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    prevHeight + newHeight, 0)
                x = (tp + 1) / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -newHeight, 0)
                prevHeight = newHeight
            end
        end
    end

    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end

function deviateVibratoHeight(initHeight, deviationIndex, deviationDistance)
    if (deviationIndex == 1) then return initHeight end -- None
    if (deviationIndex == 2) then                       -- Linear
        return initHeight + (math.random() * 2 - 1) * deviationDistance
    end
    if (deviationIndex == 3) then -- Gaussian
        local stdDevTolerance = 2
        return initHeight + math.gaussianRandom(0, deviationDistance / stdDevTolerance, stdDevTolerance)
    end
    return initHeight
end
