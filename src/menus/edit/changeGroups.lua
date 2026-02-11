function changeGroupsMenu()
    local menuVars = getMenuVars("changeGroups")

    local action = changeGroupsSettingsMenu(menuVars)

    cache.saveTable("changeGroupsMenu", menuVars)

    simpleActionMenu(table.concat({ action, " items to ", menuVars.designatedTimingGroup }), 2, changeGroups, menuVars)
end

function changeGroupsSettingsMenu(menuVars)
    local action = menuVars.clone and "Clone" or "Move"

    imgui.AlignTextToFramePadding()
    menuVars.designatedTimingGroup = chooseTimingGroup(table.concat({ "  ", action, " to: " }),
        menuVars.designatedTimingGroup)

    _, menuVars.changeSVs = imgui.Checkbox(("Change SVs?"):obfuscate(), menuVars.changeSVs)
    KeepSameLine()
    _, menuVars.changeSSFs = imgui.Checkbox(("Change SSFs?"):obfuscate(), menuVars.changeSSFs)

    menuVars.clone = RadioButtons("Mode: ", menuVars.clone, { "Clone", "Move" }, { true, false })

    return action
end
