function fixFlippedLNEnds()
    local svsToRemove = {}
    local svsToAdd = {}
    local svTimeIsAdded = {}
    local lnEndTimeFixed = {}
    local fixedLNEndsCount = 0
    for _, ho in ipairs(map.HitObjects) do
        local lnEndTime = ho.EndTime
        local isLN = lnEndTime ~= 0
        local endHasNegativeSV = (game.getSVMultiplierAt(lnEndTime) <= 0)
        local hasntAlreadyBeenFixed = lnEndTimeFixed[lnEndTime] == nil
        if isLN and endHasNegativeSV and hasntAlreadyBeenFixed then
            lnEndTimeFixed[lnEndTime] = true
            local multiplier = getUsableDisplacementMultiplier(lnEndTime)
            local duration = 1 / multiplier
            local timeAt = lnEndTime
            local timeAfter = lnEndTime + duration
            local timeAfterAfter = lnEndTime + duration + duration
            svTimeIsAdded[timeAt] = true
            svTimeIsAdded[timeAfter] = true
            svTimeIsAdded[timeAfterAfter] = true
            local svMultiplierAt = game.getSVMultiplierAt(timeAt)
            local svMultiplierAfter = game.getSVMultiplierAt(timeAfter)
            local svMultiplierAfterAfter = game.getSVMultiplierAt(timeAfterAfter)
            local newMultiplierAt = 0.001
            local newMultiplierAfter = svMultiplierAt + svMultiplierAfter
            local newMultiplierAfterAfter = svMultiplierAfterAfter
            addSVToList(svsToAdd, timeAt, newMultiplierAt, true)
            addSVToList(svsToAdd, timeAfter, newMultiplierAfter, true)
            addSVToList(svsToAdd, timeAfterAfter, newMultiplierAfterAfter, true)
            fixedLNEndsCount = fixedLNEndsCount + 1
        end
    end
    local startOffset = map.HitObjects[1].StartTime
    local endOffset = map.HitObjects[#map.HitObjects].EndTime
    if endOffset == 0 then endOffset = map.HitObjects[#map.HitObjects].StartTime end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)

    local type = "s!"

    if (fixedLNEndsCount == 0) then type = "!" end

    print(type, "Fixed " .. fixedLNEndsCount .. " flipped LN ends")
end
