-- Creates the scale (displace) menu
function scaleDisplaceMenu()
    local menuVars = getMenuVars("scaleDisplace")
    menuVars.scaleSpotIndex = Combo("Displace Spot", DISPLACE_SCALE_SPOTS, menuVars.scaleSpotIndex)
    chooseScaleType(menuVars)
    cache.saveTable("scaleDisplaceMenu", menuVars)

    AddSeparator()
    local buttonText = "Scale SVs between selected notes##displace"
    simpleActionMenu(buttonText, 2, scaleDisplaceSVs, menuVars)
end

function scaleMultiplyMenu()
    local menuVars = getMenuVars("scaleMultiply")
    chooseScaleType(menuVars)
    cache.saveTable("scaleMultiplyMenu", menuVars)

    AddSeparator()
    local buttonText = "Scale SVs between selected notes##multiply"
    simpleActionMenu(buttonText, 2, scaleMultiplySVs, menuVars)
end
