-- Creates the displace view menu
function displaceViewMenu()
    local menuVars = getMenuVars("displaceView")
    chooseDistance(menuVars)
    saveVariables("displaceViewMenu", menuVars)

    addSeparator()
    simpleActionMenu("Displace view between selected notes", 2, displaceViewSVs, nil, menuVars)
end
