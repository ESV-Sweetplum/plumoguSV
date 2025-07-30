function placeTeleportStutterSVs(settingVars)
    local finalSVType = FINAL_SV_TYPES[settingVars.finalSVIndex]
    local svPercent = settingVars.svPercent * 0.01
    local lastSVPercent = svPercent
    local lastMainSV = settingVars.mainSV
    if settingVars.linearlyChange then
        lastSVPercent = settingVars.svPercent2 * 0.01
        lastMainSV = settingVars.mainSV2
    end
    local offsets = uniqueNoteOffsetsBetweenSelected()
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local numTeleportSets = #offsets - 1
    local svsToAdd = {}
    local svsToRemove = game.getSVsBetweenOffsets(firstOffset, lastOffset, finalSVType == "Override")
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
        addSVToList(svsToAdd, startOffset, sv1, true)
        if sv2 ~= sv1 then addSVToList(svsToAdd, startOffset + startDuration, sv2, true) end
        if sv3 ~= sv2 then addSVToList(svsToAdd, endOffset - endDuration, sv3, true) end
    end
    local finalMultiplier = settingVars.avgSV
    if finalSVType ~= "Normal" then
        finalMultiplier = settingVars.customSV
    end
    addFinalSV(svsToAdd, lastOffset, finalMultiplier, finalSVType == "Override")
    removeAndAddSVs(svsToRemove, svsToAdd)
end

function placeTeleportStutterSSFs(settingVars)
    local finalSVType = FINAL_SV_TYPES[settingVars.finalSVIndex]
    local svPercent = settingVars.svPercent * 0.01
    local lastSVPercent = svPercent
    local lastMainSV = settingVars.mainSV
    if settingVars.linearlyChange then
        lastSVPercent = settingVars.svPercent2 * 0.01
        lastMainSV = settingVars.mainSV2
    end
    local offsets = uniqueNoteOffsetsBetweenSelected()
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local numTeleportSets = #offsets - 1
    local ssfsToAdd = {}
    local ssfsToRemove = game.getSSFsBetweenOffsets(firstOffset, lastOffset, finalSVType == "Override")
    local ssfPercents = generateLinearSet(svPercent, lastSVPercent, numTeleportSets)
    local mainSSFs = generateLinearSet(settingVars.mainSV, lastMainSV, numTeleportSets)

    removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
    for i = 1, numTeleportSets do
        local thisMainSSF = mainSSFs[i]
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local offsetInterval = endOffset - startOffset
        local startMultiplier = getUsableDisplacementMultiplier(startOffset)
        local startDuration = 1 / startMultiplier
        local endMultiplier = getUsableDisplacementMultiplier(endOffset)
        local endDuration = 1 / endMultiplier
        local startDistance = offsetInterval * ssfPercents[i]
        if settingVars.useDistance then startDistance = settingVars.distance end
        local expectedDistance = offsetInterval * settingVars.avgSV
        local traveledDistance = offsetInterval * thisMainSSF
        local endDistance = expectedDistance - startDistance - traveledDistance
        local ssf1 = thisMainSSF + startDistance * startMultiplier
        local ssf2 = thisMainSSF
        local ssf3 = thisMainSSF + endDistance * endMultiplier
        addSSFToList(ssfsToAdd, startOffset, ssf1, true)
        if ssf2 ~= ssf1 then addSSFToList(ssfsToAdd, startOffset + startDuration, ssf2, true) end
        if ssf3 ~= ssf2 then addSSFToList(ssfsToAdd, endOffset - endDuration, ssf3, true) end
    end
    local finalMultiplier = settingVars.avgSV
    if finalSVType ~= "Normal" then
        finalMultiplier = settingVars.customSV
    end
    addFinalSSF(ssfsToAdd, lastOffset, finalMultiplier, finalSVType == "Override")
    removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
end
