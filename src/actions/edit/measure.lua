function measureSVs(menuVars)
    local roundingDecimalPlaces = 5
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
    addStartSVIfMissing(svsBetweenOffsets, startOffset)

    menuVars.roundedNSVDistance = endOffset - startOffset
    menuVars.nsvDistance = tostring(menuVars.roundedNSVDistance)

    local totalDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset, endOffset)
    menuVars.roundedSVDistance = math.round(totalDistance, roundingDecimalPlaces)
    menuVars.svDistance = tostring(totalDistance)

    local avgSV = totalDistance / menuVars.roundedNSVDistance
    menuVars.roundedAvgSV = math.round(avgSV, roundingDecimalPlaces)
    menuVars.avgSV = tostring(avgSV)

    local durationStart = 1 / getUsableDisplacementMultiplier(startOffset)
    local timeAt = startOffset
    local timeAfter = startOffset + durationStart
    local multiplierAt = game.getSVMultiplierAt(timeAt)
    local multiplierAfter = game.getSVMultiplierAt(timeAfter)
    local startDisplacement = -(multiplierAt - multiplierAfter) * durationStart
    menuVars.roundedStartDisplacement = math.round(startDisplacement, roundingDecimalPlaces)
    menuVars.startDisplacement = tostring(startDisplacement)

    local durationEnd = 1 / getUsableDisplacementMultiplier(startOffset)
    local timeBefore = endOffset - durationEnd
    local timeBeforeBefore = timeBefore - durationEnd
    local multiplierBefore = game.getSVMultiplierAt(timeBefore)
    local multiplierBeforeBefore = game.getSVMultiplierAt(timeBeforeBefore)
    local endDisplacement = (multiplierBefore - multiplierBeforeBefore) * durationEnd
    menuVars.roundedEndDisplacement = math.round(endDisplacement, roundingDecimalPlaces)
    menuVars.endDisplacement = tostring(endDisplacement)

    local trueDistance = totalDistance - endDisplacement + startDisplacement
    local trueAvgSV = trueDistance / menuVars.roundedNSVDistance
    menuVars.roundedAvgSVDisplaceless = math.round(trueAvgSV, roundingDecimalPlaces)
    menuVars.avgSVDisplaceless = tostring(trueAvgSV)
end
