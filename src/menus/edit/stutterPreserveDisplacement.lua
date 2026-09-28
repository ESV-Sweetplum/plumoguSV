function stutterPreserveDisplacementMenu()
    local menuVars = getMenuVars('stutterPreserveDisplacement')

    stutterPreserveDisplacementSettingsMenu(menuVars)
    cache.save('stutterPreserveDisplacementMenu', menuVars)

    simpleActionMenu('Stutter SVs between selected notes', 2, stutterPreserveDisplacementSVs, menuVars)
end

function stutterPreserveDisplacementSettingsMenu(menuVars)
    chooseControlSecondSV(menuVars)
    _, menuVars.startSV = imgui.InputFloat('SV Value', menuVars.startSV, 0, 0, '%.2fx')
    chooseStutterDuration(menuVars)
end
