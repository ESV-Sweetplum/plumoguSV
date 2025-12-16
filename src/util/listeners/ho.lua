function listenForHitObjectChanges()
    function refreshHitObjectStartTimes()
        cache.lists.hitObjectStartTimes = table.dedupe(table.property(map.HitObjects, "StartTime"))
    end

    refreshHitObjectStartTimes()

    listen(function(action, type, fromLua)
        cache.boolean.changeOccurred = true
        if (tonumber(action.Type) <= 7 and not globalVars.performanceMode) then
            refreshHitObjectStartTimes()
        end
    end)
end
