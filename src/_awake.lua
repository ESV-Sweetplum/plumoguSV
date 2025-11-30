function awake()
    loadup = {} -- later inserted to via setStyleVars.lua

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
    listenForTimingGroupCount()
    setPluginAppearance()

    state.SelectedScrollGroupId = "$Default" or map.GetTimingGroupIds()[1]

    if (not truthy(map.TimingPoints)) then
        print("e!", "Please place a timing point before attempting to use plumoguSV.")
    end

    if (state.Scale ~= 1) then
        local printedScale = math.round(state.Scale * 100)
        print("e!",
            "Your ImGui scale is set to " ..
            printedScale .. "% instead of 100%. For visual purposes, please set it back to 100%.")
    end
end
