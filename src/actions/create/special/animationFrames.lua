function displaceNotesForAnimationFrames(settingVars)
    local frameDistance = settingVars.frameDistance
    local initialDistance = settingVars.distance
    local numFrames = settingVars.numFrames
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local selectedStartTime = uniqueSelectedNoteOffsets()[1]
    local firstFrameTimeTime = settingVars.frameTimes[1].time
    local lastFrameTimeTime = settingVars.frameTimes[#settingVars.frameTimes].time
    local firstOffset = math.min(selectedStartTime, firstFrameTimeTime)
    local lastOffset = math.max(selectedStartTime, lastFrameTimeTime)
    for i = 1, #settingVars.frameTimes do
        local frameTime = settingVars.frameTimes[i]
        local noteOffset = frameTime.time
        local frame = frameTime.frame
        local position = frameTime.position

        local startOffset = math.min(selectedStartTime, noteOffset)
        local endOffset = math.max(selectedStartTime, noteOffset)
        local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
        addStartSVIfMissing(svsBetweenOffsets, startOffset)
        local distanceBetweenOffsets = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset,
            endOffset)
        local distanceToTargetNote = distanceBetweenOffsets
        if selectedStartTime < noteOffset then distanceToTargetNote = -distanceBetweenOffsets end

        local numFrameDistances = frame - 1
        if settingVars.reverseFrameOrder then numFrameDistances = numFrames - frame end
        local totalFrameDistances = frameDistance * numFrameDistances
        local distanceAfterTargetNote = initialDistance + totalFrameDistances + position

        local noteDisplaceAmount = distanceToTargetNote + distanceAfterTargetNote
        local beforeDisplacement = noteDisplaceAmount
        local atDisplacement = -noteDisplaceAmount
        local afterDisplacement = 0
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, firstOffset, lastOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
    -- Maybe add in future: use svbeforebefore + isnotetimeadded to
    -- account for displacement discrepancies (if discrepancy is above certain amount)
end
