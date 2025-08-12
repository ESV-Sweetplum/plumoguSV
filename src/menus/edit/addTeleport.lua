function addTeleportMenu()
    local menuVars = getMenuVars("addTeleport")
    chooseDistance(menuVars)
    BasicCheckbox(menuVars, "teleportBeforeHand", "Add teleport before note")
    cache.saveTable("addTeleportMenu", menuVars)

    AddSeparator()
    simpleActionMenu("Add teleport SVs at selected notes", 1, addTeleportSVs, menuVars)
end
