function awake()
    local tempGlobalVars = read()

    if (not tempGlobalVars) then
        write(globalVars) -- First time launching plugin
        print("w!",
            'This seems to be your first time using plumoguSV. If you need any help, please press the button labelled "Click Here to View Various Tutorials".')
        setPresets({})
    else
        setGlobalVars(tempGlobalVars)
        loadDefaultProperties(tempGlobalVars.defaultProperties)
        setPresets(tempGlobalVars.presets or {})
    end

    initializeNoteLockMode()
    listenForHitObjectChanges()
    keyCount = map.GetKeyCount(false)

    state.SelectedScrollGroupId = "$Default" or map.GetTimingGroupIds()[1]
end

function listenForHitObjectChanges()
    state.SetValue("hoStartTimes", table.dedupe(table.property(map.HitObjects, "StartTime")))

    listen(function(action, type, fromLua)
        if (tonumber(action.Type) > 9) then return end

        state.SetValue("hoStartTimes", table.dedupe(table.property(map.HitObjects, "StartTime")))
    end)
end
