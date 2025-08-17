function copyItems(menuVars)
    clearCopiedItems(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local lines = game.getLinesBetweenOffsets(startOffset, endOffset)
    local svs = game.getSVsBetweenOffsets(startOffset, endOffset)
    local ssfs = game.getSSFsBetweenOffsets(startOffset, endOffset)
    local bms = game.getBookmarksBetweenOffsets(startOffset, endOffset)
    if (not menuVars.copyTable[1]) then goto continue1 end
    for _, line in ipairs(lines) do
        local copiedLine = {
            relativeOffset = line.StartTime - startOffset,
            bpm = line.Bpm,
            signature = line.Signature,
            hidden = line.Hidden,
        }
        table.insert(menuVars.copied.lines[menuVars.curSlot], copiedLine)
    end
    ::continue1::
    if (not menuVars.copyTable[2]) then goto continue2 end
    for _, sv in ipairs(svs) do
        local copiedSV = {
            relativeOffset = sv.StartTime - startOffset,
            multiplier = sv.Multiplier
        }
        table.insert(menuVars.copied.SVs[menuVars.curSlot], copiedSV)
    end
    ::continue2::
    if (not menuVars.copyTable[3]) then goto continue3 end
    for _, ssf in ipairs(ssfs) do
        local copiedSSF = {
            relativeOffset = ssf.StartTime - startOffset,
            multiplier = ssf.Multiplier
        }
        table.insert(menuVars.copied.SSFs[menuVars.curSlot], copiedSSF)
    end
    ::continue3::
    if (not menuVars.copyTable[4]) then goto continue4 end
    for _, bm in ipairs(bms) do
        local copiedBM = {
            relativeOffset = bm.StartTime - startOffset,
            note = bm.Note
        }
        table.insert(menuVars.copied.BMs[menuVars.curSlot], copiedBM)
    end
    ::continue4::
    if (#menuVars.copied.BMs[menuVars.curSlot] > 0) then
        toggleablePrint("s!",
            "Copied " .. #menuVars.copied.BMs[menuVars.curSlot] .. " Bookmarks.")
    end
    if (#menuVars.copied.SSFs[menuVars.curSlot] > 0) then
        toggleablePrint("s!",
            "Copied " .. #menuVars.copied.SSFs[menuVars.curSlot] .. " SSFs.")
    end
    if (#menuVars.copied.SVs[menuVars.curSlot] > 0) then
        toggleablePrint("s!",
            "Copied " .. #menuVars.copied.SVs[menuVars.curSlot] .. " SVs.")
    end
    if (#menuVars.copied.lines[menuVars.curSlot] > 0) then
        toggleablePrint("s!",
            "Copied " .. #menuVars.copied.lines[menuVars.curSlot] .. " Lines.")
    end
end

function clearCopiedItems(menuVars)
    local newCopied = table.duplicate(menuVars.copied)
    newCopied.lines[menuVars.curSlot] = {}
    newCopied.SVs[menuVars.curSlot] = {}
    newCopied.SSFs[menuVars.curSlot] = {}
    newCopied.BMs[menuVars.curSlot] = {}
    menuVars.copied = newCopied
end

function pasteItems(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local lastCopiedLine = menuVars.copied.lines[menuVars.curSlot][#menuVars.copied.lines[menuVars.curSlot]]
    local lastCopiedSV = menuVars.copied.SVs[menuVars.curSlot][#menuVars.copied.SVs[menuVars.curSlot]]
    local lastCopiedSSF = menuVars.copied.SSFs[menuVars.curSlot][#menuVars.copied.SSFs[menuVars.curSlot]]
    local lastCopiedBM = menuVars.copied.BMs[menuVars.curSlot][#menuVars.copied.BMs[menuVars.curSlot]]

    local lastCopiedValue = lastCopiedSV
    if (lastCopiedValue == nil) then
        lastCopiedValue = lastCopiedSSF or lastCopiedLine or lastCopiedBM or { relativeOffset = 0 }
    end

    local endRemoveOffset = endOffset + lastCopiedValue.relativeOffset + 1 / 128
    local linesToRemove = menuVars.copyTable[1] and game.getLinesBetweenOffsets(startOffset, endRemoveOffset) or {}
    local svsToRemove = menuVars.copyTable[2] and game.getSVsBetweenOffsets(startOffset, endRemoveOffset) or {}
    local ssfsToRemove = menuVars.copyTable[3] and game.getSSFsBetweenOffsets(startOffset, endRemoveOffset) or {}
    local bmsToRemove = menuVars.copyTable[4] and game.getBookmarksBetweenOffsets(startOffset, endRemoveOffset) or {}
    if globalVars.dontReplaceSV then
        linesToRemove = {}
        svsToRemove = {}
        ssfsToRemove = {}
        bmsToRemove = {}
    end
    local linesToAdd = {}
    local svsToAdd = {}
    local ssfsToAdd = {}
    local bmsToAdd = {}
    local hitObjectTimes = table.property(map.HitObjects, "StartTime")
    for i = 1, #offsets do
        local pasteOffset = offsets[i]
        local nextOffset = offsets[math.clamp(i + 1, 1, #offsets)]
        local ignoranceTolerance = 0.01
        for _, line in ipairs(menuVars.copied.lines[menuVars.curSlot]) do
            local timeToPasteLine = pasteOffset + line.relativeOffset
            if (math.abs(timeToPasteLine - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto skip1
            end
            table.insert(linesToAdd, utils.CreateTimingPoint(timeToPasteLine, line.bpm, line.signature, line.hidden))
            ::skip1::
        end
        for _, sv in ipairs(menuVars.copied.SVs[menuVars.curSlot]) do
            local timeToPasteSV = pasteOffset + sv.relativeOffset
            if (math.abs(timeToPasteSV - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto skip2
            end
            if menuVars.tryAlign then
                timeToPasteSV = tryAlignToHitObjects(timeToPasteSV, hitObjectTimes, menuVars.alignWindow)
            end
            table.insert(svsToAdd, createSV(timeToPasteSV, sv.multiplier))
            ::skip2::
        end
        for _, ssf in ipairs(menuVars.copied.SSFs[menuVars.curSlot]) do
            local timeToPasteSSF = pasteOffset + ssf.relativeOffset
            if (math.abs(timeToPasteSSF - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto skip3
            end
            table.insert(ssfsToAdd, createSSF(timeToPasteSSF, ssf.multiplier))
            ::skip3::
        end
        for _, bm in ipairs(menuVars.copied.BMs[menuVars.curSlot]) do
            local timeToPasteBM = pasteOffset + bm.relativeOffset
            if (math.abs(timeToPasteBM - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto skip4
            end
            table.insert(bmsToAdd, utils.CreateBookmark(timeToPasteBM, bm.note))
            ::skip4::
        end
    end
    actions.PerformBatch({
        utils.CreateEditorAction(action_type.RemoveTimingPointBatch, linesToRemove),
        utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svsToRemove),
        utils.CreateEditorAction(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
        utils.CreateEditorAction(action_type.RemoveBookmarkBatch, bmsToRemove),
        utils.CreateEditorAction(action_type.AddTimingPointBatch, linesToAdd),
        utils.CreateEditorAction(action_type.AddScrollVelocityBatch, svsToAdd),
        utils.CreateEditorAction(action_type.AddScrollSpeedFactorBatch, ssfsToAdd),
        utils.CreateEditorAction(action_type.AddBookmarkBatch, bmsToAdd),
    })
    if (truthy(linesToRemove)) then
        toggleablePrint("e!", "Deleted " .. #linesToRemove .. pluralize(" timing point.", #linesToRemove, -2))
    end
    if (truthy(svsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #svsToRemove .. pluralize(" scroll velocity.", #svsToRemove, -2))
    end
    if (truthy(ssfsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #ssfsToRemove .. pluralize(" scroll speed factor.", #ssfsToRemove, -2))
    end
    if (truthy(bmsToRemove)) then
        toggleablePrint("e!", "Deleted " .. #bmsToRemove .. pluralize(" bookmark.", #bmsToRemove, -2))
    end
    if (truthy(linesToAdd)) then
        toggleablePrint("s!", "Created " .. #linesToAdd .. pluralize(" timing point.", #linesToAdd, -2))
    end
    if (truthy(svsToAdd)) then
        toggleablePrint("s!",
            "Created " .. #svsToAdd .. pluralize(" scroll velocity.", #svsToAdd, -2))
    end
    if (truthy(ssfsToAdd)) then
        toggleablePrint("s!",
            "Created " .. #ssfsToAdd .. pluralize(" scroll speed factor.", #ssfsToAdd, -2))
    end
    if (truthy(bmsToAdd)) then
        toggleablePrint("s!", "Created " .. #bmsToAdd .. pluralize(" bookmark.", #bmsToAdd, -2))
    end
end

function tryAlignToHitObjects(time, hitObjectTimes, alignWindow)
    if not truthy(hitObjectTimes) then
        return time
    end

    local closestTime = table.searchClosest(hitObjectTimes, time)

    if math.abs(closestTime - time) > alignWindow then
        return time
    end

    time = math.frac(time) + closestTime - 1
    if math.abs(closestTime - (time + 1)) < math.abs(closestTime - time) then
        time = time + 1
    end

    return time
end
