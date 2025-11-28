function convertSVSSFMenu()
    local menuVars = getMenuVars("convertSVSSF")

    convertSVSSFSettingsMenu(menuVars)

    cache.saveTable("convertSVSSFMenu", menuVars)

    simpleActionMenu(menuVars.conversionDirection and "Convert SVs -> SSFs" or "Convert SSFs -> SVs", 2, convertSVSSF,
        menuVars, false, false)
    simpleActionMenu("Swap SVs <-> SSFs", 2, swapSVSSF,
        nil, true, true)
end

function convertSVSSFSettingsMenu(menuVars)
    chooseConvertSVSSFDirection(menuVars)
end
