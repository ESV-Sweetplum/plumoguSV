function game.getTimingGroupList()
    local baseList = table.keys(map.TimingGroups)
    local defaultIndex = table.indexOf(baseList, "$Default")
    table.remove(baseList, defaultIndex)

    local globalIndex = table.indexOf(baseList, "$Global")
    table.remove(baseList, globalIndex)

    table.insert(baseList, 1, "$Default")
    table.insert(baseList, 2, "$Global")

    if (globalVars.hideAutomatic) then table.filter(baseList, function(str) return not string.find(str, "automate_") end) end

    return baseList
end
