function reverseScrollMenu()
    local menuVars = getMenuVars("reverseScroll")

    reverseScrollSettingsMenu(menuVars)

    cache.saveTable("reverseScrollMenu", menuVars)

    AddSeparator()
    local buttonText = "Reverse scroll between selected notes"
    simpleActionMenu(buttonText, 2, reverseScrollSVs, menuVars)
end

function reverseScrollSettingsMenu(menuVars)
    chooseDistance(menuVars)
    HelpMarker("Height at which reverse scroll notes are hit")
end
