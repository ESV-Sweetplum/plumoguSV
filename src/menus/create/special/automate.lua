function automateSVMenu(settingVars)
    local copiedSVCount = #settingVars.copiedSVs

    if copiedSVCount == 0 then
        BasicCheckbox(settingVars, "deleteCopiedSVs", "Delete Copied SVs?",
            "If true, will automatically delete the SVs that are copied.")
        simpleActionMenu("Copy SVs between selected notes", 2, automateCopySVs, settingVars)
        return
    end

    FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearAutomateSVs, settingVars)
    AddSeparator()
    automateSVSettingsMenu(settingVars)

    simpleActionMenu("Automate SVs for selected notes", 2, automateSVs, settingVars)
end

function automateSVSettingsMenu(settingVars)
    settingVars.initialSV = NegatableComputableInputFloat("Initial SV", settingVars.initialSV, 2, "x")
    _, settingVars.scaleSVs = imgui.Checkbox("Scale SVs?", settingVars.scaleSVs)
    KeepSameLine()
    _, settingVars.optimizeTGs = imgui.Checkbox("Optimize TGs?", settingVars.optimizeTGs)
    _, settingVars.maintainMs = imgui.Checkbox("Static Time?", settingVars.maintainMs)
    if (settingVars.maintainMs) then
        KeepSameLine()
        imgui.PushItemWidth(71)
        settingVars.ms = ComputableInputFloat("Time", settingVars.ms, 2, "ms")
        imgui.PopItemWidth()
    end
end
