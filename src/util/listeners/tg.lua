function listenForTimingGroupCount()
    cache.tgList = game.getTimingGroupList()

    listen(function(action, type, fromLua)
        if (tonumber(action.Type) <= 44) then return end
        cache.tgList = game.getTimingGroupList()
    end)
end
