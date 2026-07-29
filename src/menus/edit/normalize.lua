-- Creates the scale (displace) menu
function normalizeDisplaceMenu()
    local menuVars = getMenuVars('normalizeDisplace')

    normalizeDisplaceSettingsMenu(menuVars)
    cache.save('normalizeDisplaceMenu', menuVars)

    simpleActionMenu('Normalize notes between selected##displace', 2, normalizeDisplaceSVs, menuVars)
end

function normalizeDisplaceSettingsMenu(menuVars) chooseAverageSV(menuVars) end
