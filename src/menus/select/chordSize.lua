function selectChordSizeMenu()
    local menuVars = getMenuVars("selectChordSize")

    for idx = 1, game.keyCount do
        local varLabel = "select" .. idx
        local label = table.concat({ "Size " .. idx .. " Chord" })
        _, menuVars[varLabel] = imgui.Checkbox(label, menuVars[varLabel])
        if (idx % 2 == 1) then KeepSameLine() end
    end

    -- BasicInputInt(menuVars, "laneSelector", "Lane Selector")

    simpleActionMenu("Select chords within region", 2, selectByChordSizes, menuVars)

    saveVariables("selectChordSizeMenu", menuVars)
end
