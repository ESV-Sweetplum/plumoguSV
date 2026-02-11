function penisMenu(settingVars)
    penisSettingsMenu(settingVars)

    simpleActionMenu("Place SVs", 1, placePenisSV, settingVars)
end

function penisSettingsMenu(settingVars)
    _, settingVars.bWidth = imgui.InputInt(("Ball Width"):obfuscate(), math.floor(settingVars.bWidth))
    _, settingVars.sWidth = imgui.InputInt(("Shaft Width"):obfuscate(), math.floor(settingVars.sWidth))

    _, settingVars.sCurvature = imgui.SliderInt(("S Curvature"):obfuscate(), settingVars.sCurvature, 1, 100,
        settingVars.sCurvature .. "%%")
    _, settingVars.bCurvature = imgui.SliderInt(("B Curvature"):obfuscate(), settingVars.bCurvature, 1, 100,
        settingVars.bCurvature .. "%%")
end
