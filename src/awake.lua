function awake()
    local tempGlobalVars = read()

    if (not tempGlobalVars) then
        write(globalVars) -- First time launching plugin
        print("w!",
            'This seems to be your first time using plumoguSV. If you need any help, please press the button labelled "View Tutorials" in the "Info" tab.')
        setPresets({})
    else
        setGlobalVars(tempGlobalVars)
        loadDefaultProperties(tempGlobalVars.defaultProperties)
        setPresets(tempGlobalVars.presets or {})
    end

    initializeNoteLockMode()
    listenForHitObjectChanges()
    game.keyCount = map.GetKeyCount()

    state.SelectedScrollGroupId = "$Default" or map.GetTimingGroupIds()[1]

    if (not state.CurrentTimingPoint) then
        print("e!", "Please place a timing point before attempting to use plumoguSV.")
    end
end

function listenForHitObjectChanges()
    local function setHitObjectStartTimes()
        cache.lists.hitObjectStartTimes = table.dedupe(table.property(map.HitObjects, "StartTime"))
    end

    setHitObjectStartTimes()

    listen(function(action, type, fromLua)
        if (tonumber(action.Type) > 7) then return end
        setHitObjectStartTimes()
    end)
end
