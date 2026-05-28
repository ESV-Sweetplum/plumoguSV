-- Creates the scale (displace) menu
function scaleDisplaceMenu()
    local menuVars = getMenuVars('scaleDisplace')

    scaleDisplaceSettingsMenu(menuVars)
    cache.save('scaleDisplaceMenu', menuVars)

    simpleActionMenu('Scale SVs between selected notes##displace', 2, scaleDisplaceSVs, menuVars)
end

function scaleMultiplyMenu()
    local menuVars = getMenuVars('scaleMultiply')

    scaleMultiplySettingsMenu(menuVars)
    cache.save('scaleMultiplyMenu', menuVars)

    simpleActionMenu('Scale SVs between selected notes##multiply', 2, scaleMultiplySVs, menuVars)
    if menuVars.scaleTypeIndex ~= 2 then
        simpleActionMenu('Scale SSFs between selected notes##multiply', 2, scaleMultiplySSFs, menuVars, true)
    end
end

function scaleDisplaceSettingsMenu(menuVars)
    menuVars.scaleSpotIndex = Combo('Displace Spot', DISPLACE_SCALE_SPOTS, menuVars.scaleSpotIndex)
    scaleMultiplySettingsMenu(menuVars)
end

function scaleMultiplySettingsMenu(menuVars) chooseScaleType(menuVars) end
