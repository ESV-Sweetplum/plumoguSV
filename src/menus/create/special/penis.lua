function penisMenu(settingVars)
    penisSettingsMenu(settingVars)

    simpleActionMenu("Place SVs", 1, placePenisSV, settingVars)
end

function penisSettingsMenu(settingVars)
    _, settingVars.bWidth = imgui.InputInt("Ball Width", math.floor(settingVars.bWidth))
    _, settingVars.sWidth = imgui.InputInt("Shaft Width", math.floor(settingVars.sWidth))

    _, settingVars.sCurvature = imgui.SliderInt("S Curvature", settingVars.sCurvature, 1, 100,
        settingVars.sCurvature .. "%%")
    _, settingVars.bCurvature = imgui.SliderInt("B Curvature", settingVars.bCurvature, 1, 100,
        settingVars.bCurvature .. "%%")
end
