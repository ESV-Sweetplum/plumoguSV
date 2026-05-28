function displaceViewMenu()
    local menuVars = getMenuVars('displaceView')

    displaceViewSettingsMenu(menuVars)
    cache.save('displaceViewMenu', menuVars)

    simpleActionMenu('Displace view between selected notes', 2, displaceViewSVs, menuVars)
end

function displaceViewSettingsMenu(menuVars) chooseDistance(menuVars) end
