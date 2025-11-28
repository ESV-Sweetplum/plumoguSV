-- Creates the scale (displace) menu
function scaleDisplaceMenu()
    local menuVars = getMenuVars("scaleDisplace")

    scaleDisplaceSettingsMenu(menuVars)
    cache.saveTable("scaleDisplaceMenu", menuVars)

    AddSeparator()
    local buttonText = "Scale SVs between selected notes##displace"
    simpleActionMenu(buttonText, 2, scaleDisplaceSVs, menuVars)
end

function scaleMultiplyMenu()
    local menuVars = getMenuVars("scaleMultiply")

    scaleMultiplySettingsMenu(menuVars)
    cache.saveTable("scaleMultiplyMenu", menuVars)

    AddSeparator()
    local buttonText = "Scale SVs between selected notes##multiply"
    simpleActionMenu(buttonText, 2, scaleMultiplySVs, menuVars)
end

function scaleDisplaceSettingsMenu(menuVars)
    menuVars.scaleSpotIndex = Combo("Displace Spot", DISPLACE_SCALE_SPOTS, menuVars.scaleSpotIndex)
    scaleMultiplySettingsMenu(menuVars)
end

function scaleMultiplySettingsMenu(menuVars)
    chooseScaleType(menuVars)
end
