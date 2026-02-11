SETTING_TYPES = {
    "General",
    "Advanced",
    "Appearance",
    "Custom Theme",
    "Default Properties",
    "Windows + Widgets",
    "Keybinds",
}

function showPluginSettingsWindow()
    if (not globalVars.performanceMode) then
        local bgColor = vector.New(0.2, 0.2, 0.2, 1)
        imgui.PopStyleColor(20)
        setIncognitoColors()
        setPluginAppearanceStyles("Rounded + Border")
        imgui.PushStyleColor(imgui_col.WindowBg, bgColor)
        imgui.PushStyleColor(imgui_col.TitleBg, bgColor)
        imgui.PushStyleColor(imgui_col.TitleBgActive, bgColor)
        imgui.PushStyleColor(imgui_col.Border, vctr4(1))
    end
    startNextWindowNotCollapsed("plumoguSV Settings")
    _, settingsOpened = imgui.Begin("plumoguSV Settings", true, 42)
    imgui.SetWindowSize("plumoguSV Settings", vector.New(433, 400))

    local typeIndex = cache.settingTypeIndex or 1

    imgui.Columns(2, "settings_columnList", true)
    imgui.SetColumnWidth(0, 150)
    imgui.SetColumnWidth(1, 283)

    imgui.BeginChild("Setting Categories")

    imgui.Text(("Setting Type"):obfuscate())
    imgui.Separator()

    --- Key is name of setting. If value with respect to key is true, will hide setting at the left
    local hideSettingDict = {
        ["Advanced"] = not globalVars.advancedMode,
        ["Custom Theme"] = (globalVars.colorThemeName:sub(1, 7) ~= "custom_" or globalVars.performanceMode)
    }

    for idx, v in pairs(SETTING_TYPES) do
        if (hideSettingDict[v]) then goto nextSetting end
        if (imgui.Selectable(v, typeIndex == idx)) then
            typeIndex = idx
        end
        ::nextSetting::
    end
    AddSeparator()
    if (imgui.Button(("Reset Settings"):obfuscate())) then
        write({})
        globalVars = DEFAULT_GLOBAL_VARS
        toggleablePrint("e!", "Settings have been reset.")
    end
    if (globalVars.advancedMode) then renderMemeButtons() end

    imgui.EndChild()
    imgui.NextColumn()

    imgui.BeginChild("Settings Data")
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)

    cache.settingTypeIndex = typeIndex

    if (SETTING_TYPES[typeIndex] == "General") then
        showGeneralSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Advanced") then
        showAdvancedSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Default Properties") then
        showDefaultPropertiesSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Windows + Widgets") then
        showWindowSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Appearance") then
        showAppearanceSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Custom Theme") then
        showCustomThemeSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Keybinds") then
        showKeybindSettings()
    end

    imgui.PopItemWidth()
    imgui.EndChild()

    imgui.Columns(1)
    if (not settingsOpened) then
        cache.windows.showSettingsWindow = false
        cache.settingTypeIndex = 1
        state.SetValue("crazy", "Crazy?")
        state.SetValue("activateCrazy", false)
        state.SetValue("crazyIdx", 1)
    end
    if (not globalVars.performanceMode) then
        imgui.PopStyleColor(41)
        pulseController()
        setPluginAppearanceColors(globalVars.colorThemeName, true)
        setPluginAppearanceStyles(STYLE_THEMES[globalVars.styleThemeIndex])
    end
    imgui.End()
end

function renderMemeButtons()
    if (GradientButton("show me the quzz\n(quaver huzz)", color.vctr.red, color.vctr.white, 1500)) then
        ---@diagnostic disable-next-line: param-type-mismatch
        imgui.Text(nil)
    end
    HoverToolTip("Press this button once (if you don't have any work saved) and never again.")
    if (GradientButton("fuck you and\nyour stupid editor", color.vctr.red, color.vctr.white, 1500)) then
        cache.boolean.destroyEditor = true
    end
    HoverToolTip("Press this button once (if you don't have any work saved) and never again.")
    if (cache.boolean.destroyEditor) then
        actions.GoToObjects(math.floor(math.random() * map.TrackLength))
        local ho1 = map.HitObjects[1]
        actions.RemoveHitObject(ho1)
        actions.Undo()
    end
    local text = state.GetValue("crazy", "Crazy?")
    local full =
    " I was crazy\nonce. They put me in\na map. A ranked map.\nA ranked map\nwith no SV. And no\nSV makes me crazy.\nCrazy?"
    if (imgui.Button(("Crazy?"):obfuscate())) then
        state.SetValue("activateCrazy", true)
    end
    if (state.GetValue("activateCrazy")) then
        imgui.TextUnformatted(text)
        if (clock.listen("crazy", 5 * math.exp(- #text / 1500))) then
            local curIdx = state.GetValue("crazyIdx", 1)
            if (curIdx > #full) then curIdx = curIdx - #full end
            local char = full:charAt(curIdx)
            text = text .. full:charAt(curIdx)
            if (full:charAt(curIdx) == "\n") then
                curIdx = curIdx + 1
                text = text .. full:charAt(curIdx)
            end
            state.SetValue("crazyIdx", curIdx + 1)
            state.SetValue("crazy", text)
        end
        if (imgui.GetScrollMaxY() > imgui.GetScrollY()) then
            imgui.SetScrollHereY(1)
        end
    end
end
