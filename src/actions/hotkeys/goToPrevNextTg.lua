function changeTGIndex(diff)
    local groups = cache.tgList
    local selectedTgDict = {}
    if (not isTruthy(state.SelectedHitObjects)) then
        globalVars.scrollGroupIndex = math.wrap(globalVars.scrollGroupIndex + diff, 1, #groups, true)
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
    if (#table.keys(selectedTgDict) == 1) then return end
    local idIndex = table.indexOf(idList, state.SelectedScrollGroupId)
    globalVars.scrollGroupIndex = selectedTgDict[idList[math.wrap(idIndex + diff, 1, #idList, true)]]
    state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
end

function goToPrevTg()
    changeTGIndex(-1)
end

function goToNextTg()
    changeTGIndex(1)
end
