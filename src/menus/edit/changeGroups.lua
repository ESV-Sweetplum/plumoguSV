function changeGroupsMenu()
    local menuVars = getMenuVars("changeGroups")

    menuVars.advancedMode = RadioButtons("Type:", menuVars.advancedMode, { "Simple", "Advanced" }, { false, true })
    AddSeparator()
    local action = menuVars.clone and "Clone" or "Move"

    if (menuVars.advancedMode) then

    else
        imgui.AlignTextToFramePadding()
        menuVars.designatedTimingGroup = chooseTimingGroup(table.concat({ "  ", action, " to: " }),
            menuVars.designatedTimingGroup)
    end

    _, menuVars.changeSVs = imgui.Checkbox("Change SVs?", menuVars.changeSVs)
    KeepSameLine()
    _, menuVars.changeSSFs = imgui.Checkbox("Change SSFs?", menuVars.changeSSFs)

    menuVars.clone = RadioButtons("Mode: ", menuVars.clone, { "Clone", "Move" }, { true, false })

    AddSeparator()

    cache.saveTable("changeGroupsMenu", menuVars)

    simpleActionMenu(table.concat({ action, " items to ", menuVars.designatedTimingGroup }), 2, changeGroups, menuVars)
end
