function selectByTimingGroupMenu()
    local menuVars = getMenuVars("selectByTimingGroup")

    menuVars.designatedTimingGroup = chooseTimingGroup("Select in:", menuVars.designatedTimingGroup)

    simpleActionMenu(table.concat({ "Select notes in ", menuVars.designatedTimingGroup }), 2, selectByTimingGroup,
        menuVars)

    cache.saveTable("selectByTimingGroupMenu", menuVars)
end
