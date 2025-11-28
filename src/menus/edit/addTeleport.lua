function addTeleportMenu()
    local menuVars = getMenuVars("addTeleport")
    addTeleportSettingsMenu(menuVars)
    cache.saveTable("addTeleportMenu", menuVars)

    AddSeparator()
    simpleActionMenu("Add teleport SVs at selected notes", 1, addTeleportSVs, menuVars)
end

function addTeleportSettingsMenu(menuVars)
    chooseDistance(menuVars)
    BasicCheckbox(menuVars, "teleportBeforeHand", "Add teleport before note")
end
