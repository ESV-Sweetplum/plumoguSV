function showAppearanceSettings()
    if (globalVars.performanceMode) then
        imgui.TextColored(color.vctr.red,
            "Performance mode is currently enabled.\nPlease disable it to access appearance features.")
        imgui.BeginDisabled()
    end
    chooseStyleTheme()
    chooseColorTheme()
    if (COLOR_THEMES[globalVars.colorThemeIndex] ~= "CUSTOM" and imgui.Button("Load Theme to Custom")) then
        setPluginAppearanceColors(COLOR_THEMES[globalVars.colorThemeIndex])
        local customStyle = {}
        for _, id in ipairs(customStyleIds) do
            customStyle[id] = color.uintToRgba(imgui.GetColorU32(imgui_col[id:capitalize()])) / vctr4(255)
        end
        globalVars.customStyle = customStyle
        globalVars.colorThemeIndex = table.indexOf(COLOR_THEMES, "CUSTOM")
    end
    HoverToolTip(
        "Clicking this will recreate this theme in the CUSTOM theme option, allowing you to customize it however you'd like without having to clone it manually.")
    AddSeparator()
    chooseCursorTrail()
    chooseCursorTrailShape()
    chooseEffectFPS()
    chooseCursorTrailPoints()
    chooseCursorShapeSize()
    chooseSnakeSpringConstant()
    chooseCursorTrailGhost()
    AddSeparator()
    GlobalCheckbox("disableLoadup", "Disable Loadup Animation",
        "Disables the loadup animation when launching the editor.")
    KeepSameLine()
    if (imgui.Button("Play", vector.New(42, 24))) then
        cache_logoStartTime = clock.getTime()
    end
    AddSeparator()
    GlobalCheckbox("drawCapybara", "Capybara", "Draws a capybara at the bottom right of the screen")
    imgui.SameLine(0, RADIO_BUTTON_SPACING)
    GlobalCheckbox("drawCapybara2", "Capybara 2", "Draws a capybara at the bottom left of the screen")
    GlobalCheckbox("drawCapybara312", "Capybara 312", "Draws a capybara???!?!??!!!!? AGAIN?!?!")
    AddSeparator()
    choosePulseCoefficient()
    GlobalCheckbox("useCustomPulseColor", "Use Custom Color?")
    if (not globalVars.useCustomPulseColor) then imgui.BeginDisabled() end
    KeepSameLine()
    if (imgui.Button("Edit Color")) then
        state.SetValue("showColorPicker", true)
    end
    if (state.GetValue("showColorPicker")) then
        choosePulseColor()
    end
    if (not globalVars.useCustomPulseColor) then
        imgui.EndDisabled()
        state.SetValue("showColorPicker", false)
    end
    AddSeparator()
    local oldDynamicBgIndex = globalVars.dynamicBackgroundIndex
    globalVars.dynamicBackgroundIndex = Combo("Dynamic BG", DYNAMIC_BACKGROUND_TYPES, oldDynamicBgIndex)
    if (oldDynamicBgIndex ~= globalVars.dynamicBackgroundIndex) then
        write(globalVars)
    end
    if (globalVars.performanceMode) then
        imgui.EndDisabled()
    end
end
