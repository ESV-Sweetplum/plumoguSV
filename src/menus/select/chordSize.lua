function selectChordSizeMenu()
    local menuVars = getMenuVars("selectChordSize")

    _, menuVars.single = imgui.Checkbox("Select Singles", menuVars.single)
    KeepSameLine()
    _, menuVars.jump = imgui.Checkbox("Select Jumps", menuVars.jump)
    _, menuVars.hand = imgui.Checkbox("Select Hands", menuVars.hand)
    KeepSameLine()
    _, menuVars.quad = imgui.Checkbox("Select Quads", menuVars.quad)

    BasicInputInt(menuVars, "laneSelector", "Lane Selector")

    simpleActionMenu("Select chords within region", 2, selectByChordSizes, menuVars)

    saveVariables("selectChordSizeMenu", menuVars)
end
