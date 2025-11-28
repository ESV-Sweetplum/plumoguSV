function listenForTimingGroupCount()
    cache.tgList = game.getTimingGroupList()

    listen(function(action, type, fromLua)
        local actionIndex = tonumber(action.Type)
        if (actionIndex <= 44 and actionIndex ~= 37) then return end
        cache.tgList = game.getTimingGroupList()
    end)
end
