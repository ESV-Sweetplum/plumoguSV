SETTING_TYPES = {
    "General",
    "Default Properties",
    "Appearance",
    "Custom Theme",
    "Windows + Widgets",
    "Keybinds",
}

function showPluginSettingsWindow()
    local bgColor = vector.New(0.2, 0.2, 0.2, 1)

    imgui.PopStyleColor(20)
    setIncognitoColors()
    setPluginAppearanceStyles("Rounded + Border")
    imgui.PushStyleColor(imgui_col.WindowBg, bgColor)
    imgui.PushStyleColor(imgui_col.TitleBg, bgColor)
    imgui.PushStyleColor(imgui_col.TitleBgActive, bgColor)
    imgui.PushStyleColor(imgui_col.Border, vector4(1))
    imgui.SetNextWindowCollapsed(false)
    _, settingsOpened = imgui.Begin("plumoguSV Settings", true, 42)
    imgui.SetWindowSize("plumoguSV Settings", vector.New(433, 400))

    local typeIndex = state.GetValue("settings_typeIndex", 1)

    imgui.Columns(2, "settings_columnList", true)
    imgui.SetColumnWidth(0, 150)
    imgui.SetColumnWidth(1, 283)

    -- CATEGORY COLUMN

    imgui.BeginChild(420)
    imgui.Text("Setting Type")
    imgui.Separator()
    for idx, v in pairs(SETTING_TYPES) do
        if (v == "Custom Theme" and COLOR_THEMES[globalVars.colorThemeIndex] ~= "CUSTOM") then goto skip end
        if (imgui.Selectable(v, typeIndex == idx)) then
            typeIndex = idx
        end
        ::skip::
    end
    AddSeparator()
    if (imgui.Button("Reset Settings")) then
        write({})
        globalVars = DEFAULT_GLOBAL_VARS
        globalVars.hotkeyList = table.duplicate(DEFAULT_HOTKEY_LIST)
        toggleablePrint("e!", "Settings have been reset.")
    end
    -- Crash the fucking game
    if (imgui.Button("show me the quzz (quaver huzz)")) then
        ---@diagnostic disable-next-line: param-type-mismatch
        imgui.Text(nil)
    end
    local text = state.GetValue("crazy", "Crazy?")
    local full =
    " I was crazy once. They put me in a map. A ranked map. A ranked map with no SV. And no SV makes me crazy. Crazy?"
    if (imgui.Button(text)) then
        state.SetValue("activateCrazy", true)
    end
    if (state.GetValue("activateCrazy")) then
        imgui.TextWrapped(text)
        if (clock.listen("crazy", 10 * math.exp(- #text / 100))) then
            local curIdx = state.GetValue("crazyIdx", 1)
            if (curIdx > #full) then curIdx = curIdx - #full end
            text = text .. full:charAt(curIdx)
            state.SetValue("crazyIdx", curIdx + 1)
            state.SetValue("crazy", text)
        end
        if (imgui.GetScrollMaxY() > imgui.GetScrollY()) then
            imgui.SetScrollHereY(1)
        end
    end
    imgui.EndChild()
    imgui.NextColumn()

    -- SETTINGS COLUMN

    imgui.BeginChild(69)
    if (SETTING_TYPES[typeIndex] == "General") then
        showGeneralSettings()
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
    if (SETTING_TYPES[typeIndex] == "Custom Theme" and COLOR_THEMES[globalVars.colorThemeIndex] == "CUSTOM") then
        showCustomThemeSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Keybinds") then
        showKeybindSettings()
    end
    imgui.EndChild()
    imgui.Columns(1)
    state.SetValue("settings_typeIndex", typeIndex)
    if (not settingsOpened) then
        state.SetValue("showSettingsWindow", false)
        state.SetValue("settings_typeIndex", 1)
        state.SetValue("crazy", "Crazy?")
        state.SetValue("activateCrazy", false)
        state.SetValue("crazyIdx", 1)
    end
    imgui.PopStyleColor(41)
    setPluginAppearanceColors(COLOR_THEMES[globalVars.colorThemeIndex])
    setPluginAppearanceStyles(STYLE_THEMES[globalVars.styleThemeIndex])
    imgui.End()
end
