SPECIAL_SVS = { -- types of special SVs
    'Stutter',
    'Teleport Stutter',
    'Frames Setup',
    'Automate',
    'Penis',
}

function placeSpecialSVMenu()
    PresetButton()
    local menuVars = getMenuVars('placeSpecial')
    chooseSpecialSVType(menuVars)

    AddSeparator()
    local currentSVType = SPECIAL_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType, 'Special')
    if globalVars.showPresetMenu then
        renderPresetMenu('Special', menuVars, settingVars)
        cache.saveTable(currentSVType .. 'SpecialSettings', settingVars)
        cache.saveTable('placeSpecialMenu', menuVars)
        return
    end

    if currentSVType == 'Stutter' then stutterMenu(settingVars) end
    if currentSVType == 'Teleport Stutter' then teleportStutterMenu(settingVars) end
    if currentSVType == 'Frames Setup' then
        animationFramesSetupMenu(settingVars)
    end
    if currentSVType == 'Automate' then automateSVMenu(settingVars) end
    if currentSVType == 'Penis' then penisMenu(settingVars) end

    cache.saveTable(currentSVType .. 'SpecialSettings', settingVars)
    cache.saveTable('placeSpecialMenu', menuVars)
end
