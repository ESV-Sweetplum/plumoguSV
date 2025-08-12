function displaceViewMenu()
    local menuVars = getMenuVars("displaceView")
    chooseDistance(menuVars)
    cache.saveTable("displaceViewMenu", menuVars)

    AddSeparator()
    simpleActionMenu("Displace view between selected notes", 2, displaceViewSVs, menuVars)
end
