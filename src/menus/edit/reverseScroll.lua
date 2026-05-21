function reverseScrollMenu()
    local menuVars = getMenuVars('reverseScroll')

    reverseScrollSettingsMenu(menuVars)

    cache.save('reverseScrollMenu', menuVars)

    simpleActionMenu('Reverse scroll between selected notes', 2, reverseScrollSVs, menuVars)
end

function reverseScrollSettingsMenu(menuVars)
    chooseDistance(menuVars)
    HelpMarker('Height at which reverse scroll notes are hit')
end
