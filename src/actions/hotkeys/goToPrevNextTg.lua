function goToPrevTg()
    local groups = cache.tgList
    local selectedTgDict = {}
    if (not truthy(state.SelectedHitObjects)) then
        globalVars.scrollGroupIndex = math.wrappedClamp(globalVars.scrollGroupIndex - 1, 1, #groups)
        state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
        return
    end
    for _, ho in pairs(state.SelectedHitObjects) do
        if (not selectedTgDict[ho.TimingGroup]) then
            selectedTgDict[ho.TimingGroup] = table.indexOf(groups, ho.TimingGroup)
        end
    end
    local idList = table.keys(selectedTgDict)
    if (not table.includes(idList, groups[globalVars.scrollGroupIndex])) then
        globalVars.scrollGroupIndex = selectedTgDict[idList[#idList]]
        state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
        return
    end
    local idIndex = table.indexOf(idList, state.SelectedScrollGroupId)
    globalVars.scrollGroupIndex = selectedTgDict[idList[math.wrappedClamp(idIndex - 1, 1, #idList)]]
    state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
end

function goToNextTg()
    local groups = cache.tgList
    local selectedTgDict = {}
    if (not truthy(state.SelectedHitObjects)) then
        globalVars.scrollGroupIndex = math.wrappedClamp(globalVars.scrollGroupIndex + 1, 1, #groups)
        state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
        return
    end
    for _, ho in pairs(state.SelectedHitObjects) do
        if (not selectedTgDict[ho.TimingGroup]) then
            selectedTgDict[ho.TimingGroup] = table.indexOf(groups, ho.TimingGroup)
        end
    end
    local idList = table.keys(selectedTgDict)
    if (not table.includes(idList, groups[globalVars.scrollGroupIndex])) then
        globalVars.scrollGroupIndex = selectedTgDict[idList[1]]
        state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
        return
    end
    local idIndex = table.indexOf(idList, state.SelectedScrollGroupId)
    globalVars.scrollGroupIndex = selectedTgDict[idList[math.wrappedClamp(idIndex + 1, 1, #idList)]]
    state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
end
