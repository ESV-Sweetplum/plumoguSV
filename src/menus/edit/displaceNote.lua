function displaceNoteMenu()
    local menuVars = getMenuVars("displaceNote")
    chooseVaryingDistance(menuVars)
    BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")
    saveVariables("displaceNoteMenu", menuVars)

    AddSeparator()
    simpleActionMenu("Displace selected notes", 1, displaceNoteSVsParent, menuVars)
end
