function listenForHitObjectChanges()
    local function setHitObjectStartTimes()
        cache.lists.hitObjectStartTimes = table.dedupe(table.property(map.HitObjects, "StartTime"))
    end

    setHitObjectStartTimes()

    listen(function(action, type, fromLua)
        cache.boolean.changeOccurred = true
        if (tonumber(action.Type) <= 7) then
            setHitObjectStartTimes()
        end
    end)
end
