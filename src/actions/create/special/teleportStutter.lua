function placeTeleportStutterSVs(settingVars)
    local finalSVType = FINAL_SV_TYPES[settingVars.finalSVIndex]
    local svPercent = settingVars.svPercent * 0.01
    local lastSVPercent = svPercent
    local lastMainSV = settingVars.mainSV
    if settingVars.linearlyChange then
        lastSVPercent = settingVars.svPercent2 * 0.01
        lastMainSV = settingVars.mainSV2
    end
    local offsets = game.get.uniqueNoteOffsetsBetweenSelected()
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local numTeleportSets = #offsets - 1
    local svsToAdd = {}
    local svsToRemove = game.get.svsBetweenOffsets(firstOffset, lastOffset, finalSVType == "Override")
    local svPercents = generateLinearSet(svPercent, lastSVPercent, numTeleportSets)
    local mainSVs = generateLinearSet(settingVars.mainSV, lastMainSV, numTeleportSets)

    removeAndAddSVs(svsToRemove, svsToAdd)
    for i = 1, numTeleportSets do
        local thisMainSV = mainSVs[i]
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local offsetInterval = endOffset - startOffset
        local startMultiplier = getUsableDisplacementMultiplier(startOffset)
        local startDuration = 1 / startMultiplier
        local endMultiplier = getUsableDisplacementMultiplier(endOffset)
        local endDuration = 1 / endMultiplier
        local startDistance = offsetInterval * svPercents[i]
        if settingVars.useDistance then startDistance = settingVars.distance end
        local expectedDistance = offsetInterval * settingVars.avgSV
        local traveledDistance = offsetInterval * thisMainSV
        local endDistance = expectedDistance - startDistance - traveledDistance
        local sv1 = thisMainSV + startDistance * startMultiplier
        local sv2 = thisMainSV
        local sv3 = thisMainSV + endDistance * endMultiplier
        for j = 0, settingVars.stuttersPerSection - 1 do
            local x = j / settingVars.stuttersPerSection
            local currentStart = (endOffset - startOffset) * j / settingVars.stuttersPerSection + startOffset
            local currentEnd = (endOffset - startOffset) * (j + 1) / settingVars.stuttersPerSection + startOffset
            addSVToList(svsToAdd, currentStart, sv1 / settingVars.stuttersPerSection, true)
            if sv2 ~= sv1 then
                addSVToList(svsToAdd, currentStart + startDuration, sv2,
                    true)
            end
            if sv3 ~= sv2 then addSVToList(svsToAdd, currentEnd - endDuration, sv3 / settingVars.stuttersPerSection, true) end
        end
    end
    local finalMultiplier = settingVars.avgSV
    if finalSVType ~= "Normal" then
        finalMultiplier = settingVars.customSV
    end
    addFinalSV(svsToAdd, lastOffset, finalMultiplier, finalSVType == "Override")
    removeAndAddSVs(svsToRemove, svsToAdd)
end
