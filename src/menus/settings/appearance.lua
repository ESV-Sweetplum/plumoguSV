function showAppearanceSettings()
    if (globalVars.performanceMode) then
        imgui.TextColored(color.vctr.red,
            "Performance mode is currently enabled.\nPlease disable it to access appearance features.")
        imgui.BeginDisabled()
    end
    chooseStyleTheme()
    chooseColorTheme()
    if (globalVars.colorThemeName ~= "CUSTOM" and imgui.Button("Load Theme to Custom")) then
        setPluginAppearanceColors(globalVars.colorThemeName)
        local customStyle = {}
        for _, id in ipairs(customStyleIds) do
            local query = id:capitalize()
            if (query:match("%u%l+") == "Loadup") then
                customStyle[id] = loadup[query:sub(7)]
                goto nextCustomStyle
            end
            customStyle[id] = color.uintToRgba(imgui.GetColorU32(imgui_col[query]))
            ::nextCustomStyle::
        end
        globalCustomStyle = customStyle
        globalVars.colorThemeName = "CUSTOM"
        setPluginAppearanceColors("CUSTOM")
    end
    if (globalVars.colorThemeName ~= "CUSTOM") then
        HoverToolTip(
            "Clicking this will recreate this theme in the CUSTOM theme option, allowing you to customize it however you'd like without having to clone it manually.")
    end
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
        cache.logoStartTime = clock.getTime()
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
        cache.windows.showColorPicker = not cache.windows.showColorPicker
    end
    if (cache.windows.showColorPicker) then
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
