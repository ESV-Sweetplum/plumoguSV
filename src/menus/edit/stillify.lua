function stillifyMenu()
    local menuVars = getMenuVars('stillify')

    stillifySettingsMenu(menuVars)
    cache.save('stillifyMenu', menuVars)

    simpleActionMenu('Stillify', 2, stillify, menuVars, false)
end

function stillifySettingsMenu(menuVars) chooseAverageSV(menuVars) end
