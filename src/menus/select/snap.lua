function selectBySnapMenu()
    local menuVars = getMenuVars("selectBySnap")
    chooseSnap(menuVars)
    saveVariables("selectBySnapMenu", menuVars)

    AddSeparator()
    simpleActionMenu(
        "Select notes with 1/" .. menuVars.snap .. " snap",
        2,
        selectBySnap, menuVars)
end
