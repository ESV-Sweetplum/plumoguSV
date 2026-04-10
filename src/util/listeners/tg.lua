function listenForTimingGroupCount()
    local function refreshTgList()
        local baseList = game.get.timingGroupList()
        if (globalVars.hideAutomatic) then
            table.filter(baseList,
                function(str) return not string.find(str, 'automate_') end)
        end
        cache.tgList = baseList
    end

    listen(function(action, type, fromLua)
        local actionIndex = tonumber(action.Type)
        if (actionIndex < action_type.CreateTimingGroup and actionIndex ~= action_type.Batch) then return end

        refreshTgList()
    end)
end
