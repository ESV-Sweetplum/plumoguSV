function listenForTimingGroupCount()
    cache.tgList = game.getTimingGroupList()

    listen(function(action, type, fromLua)
        local actionIndex = tonumber(action.Type)
        if (actionIndex < action_type.CreateTimingGroup and actionIndex ~= action_type.Batch) then return end
        cache.tgList = game.getTimingGroupList()
    end)
end
