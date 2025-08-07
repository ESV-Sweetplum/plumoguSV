VIBRATO_SVS = { -- types of vibrato SVs
    "Linear##Vibrato",
    "Exponential##Vibrato",
    "Sinusoidal##Vibrato",
    "Sigmoidal##Vibrato",
    "Custom##Vibrato"
}

function placeVibratoSVMenu(separateWindow)
    PresetButton()
    local menuVars = getMenuVars("placeVibrato")
    chooseVibratoSVType(menuVars)

    AddSeparator()
    imgui.Text("Vibrato Settings:")
    menuVars.vibratoMode = Combo("Vibrato Mode", VIBRATO_TYPES, menuVars.vibratoMode)
    chooseVibratoQuality(menuVars)
    if (menuVars.vibratoMode ~= 2) then
        chooseVibratoSides(menuVars)
    end

    local currentSVType = VIBRATO_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType .. (menuVars.vibratoMode == 1 and "SV" or "SSF"), "Vibrato")
    if globalVars.showPresetMenu then
        renderPresetMenu("Vibrato", menuVars, settingVars)
        return
    end

    AddSeparator()

    if currentSVType == "Linear##Vibrato" then linearVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Exponential##Vibrato" then exponentialVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Sinusoidal##Vibrato" then sinusoidalVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Sigmoidal##Vibrato" then sigmoidalVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Custom##Vibrato" then customVibratoMenu(menuVars, settingVars, separateWindow) end

    local labelText = currentSVType .. (menuVars.vibratoMode == 1 and "SV" or "SSF") .. "Vibrato"
    saveVariables(labelText .. "Settings", settingVars)
    saveVariables("placeVibratoMenu", menuVars)
end
