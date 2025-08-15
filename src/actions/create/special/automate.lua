function automateCopySVs(settingVars)
    settingVars.copiedSVs = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svs = game.getSVsBetweenOffsets(startOffset, endOffset)
    if (not #svs or #svs == 0) then
        toggleablePrint("w!", "No SVs found within the copiable region.")
        return
    end
    local firstSVTime = svs[1].StartTime
    local svs = game.getSVsBetweenOffsets(startOffset, endOffset)
    for _, sv in ipairs(svs) do
        local copiedSV = {
            relativeOffset = sv.StartTime - firstSVTime,
            multiplier = sv.Multiplier
        }
        table.insert(settingVars.copiedSVs, copiedSV)
    end
    if (#settingVars.copiedSVs > 0) then toggleablePrint("s!", "Copied " .. #settingVars.copiedSVs .. " SVs.") end
end

function clearAutomateSVs(settingVars)
    settingVars.copiedSVs = {}
end

function automateSVs(settingVars)
    local selected = state.SelectedHitObjects
    local actionList = {}

    local ids = utils.GenerateTimingGroupIds(#selected, "automate_")
    local neededIds = {}
    local timeSinceLastObject = 0
    local idIndex = 0
    for idx, ho in pairs(selected) do
        if (not settingVars.maintainMs and idx == 1) then goto continue end
        do -- avoid jumping over local scope error
            local thisTime = truthy(ho.EndTime) and ho.EndTime or ho.StartTime
            local prevTime = truthy(selected[math.max(1, idx - 1)].EndTime) and selected[math.max(1, idx - 1)].EndTime or
                selected[math.max(1, idx - 1)].StartTime

            timeSinceLastObject = timeSinceLastObject + thisTime - prevTime
            if (timeSinceLastObject > settingVars.ms and settingVars.maintainMs and settingVars.optimizeTGs) then
                idIndex = 1
                timeSinceLastObject = 0
            else
                idIndex = idIndex + 1
            end
            local idName = ids[idIndex]
            if (not neededIds[idName]) then
                neededIds[idName] = { hos = {}, svs = {} }
            end
            table.insert(neededIds[idName].hos, ho)
            local startTime = truthy(selected[1].EndTime) and selected[1].EndTime or selected[1].StartTime
            local secondaryTime = truthy(selected[2].EndTime) and selected[2].EndTime or selected[2].StartTime
            for _, sv in ipairs(settingVars.copiedSVs) do
                local currentTime = truthy(ho.EndTime) and ho.EndTime or ho.StartTime
                local maxRelativeOffset = settingVars.copiedSVs[#settingVars.copiedSVs].relativeOffset
                local progress = 1 - sv.relativeOffset / maxRelativeOffset
                local tempMultiplier = sv.multiplier
                if (settingVars.scaleSVs) then
                    local scalingFactor =
                        (currentTime - startTime) / (secondaryTime - startTime)
                    if (not settingVars.maintainMs) then scalingFactor = 1 / scalingFactor end
                    tempMultiplier = tempMultiplier * scalingFactor
                end

                if (settingVars.maintainMs) then
                    svTime = currentTime - progress * settingVars.ms
                else
                    svTime = currentTime - progress * (currentTime - startTime)
                end
                table.insert(neededIds[idName].svs, createSV(svTime, tempMultiplier))
            end
        end
        ::continue::
    end

    for id, data in pairs(neededIds) do
        local r = math.random(255)
        local g = math.random(255)
        local b = math.random(255)

        local tg = utils.CreateScrollGroup(data.svs, settingVars.initialSV or 1, table.concat({ r, g, b }, ","))
        local action = utils.CreateEditorAction(action_type.CreateTimingGroup, id, tg, data.hos)

        table.insert(actionList, action)
    end

    actions.PerformBatch(actionList)

    toggleablePrint("w!", "Automated.")
end
