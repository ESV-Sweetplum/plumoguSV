function showAppearanceSettings()
    if (globalVars.performanceMode) then
        imgui.TextColored(color.vctr.red,
            "Performance mode is currently enabled.\nPlease disable it to access appearance features.")
        imgui.BeginDisabled()
    end
    chooseStyleTheme()
    chooseColorTheme()
    if (imgui.Button("Copy Current Theme")) then
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
        globalCustomStyle.border = cache.borderColor
        local newName = "custom_Copy of " .. globalVars.colorThemeName:gsub("^custom_", "")
        globalVars.colorThemeName = newName
        if (not globalVars.customStyles) then globalVars.customStyles = {} end
        globalVars.customStyles[newName] = globalCustomStyle
        setPluginAppearanceColors(newName)
        write(globalVars)
    end
    if (globalVars.colorThemeName:sub(1, 7) ~= "custom_") then
        HoverToolTip(
            "Clicking this will recreate this theme in the CUSTOM theme option, allowing you to customize it however you'd like without having to clone it manually.")
    end
    KeepSameLine()
    if (imgui.Button("Import Theme")) then
        cache.boolean.importingCustomTheme = not cache.boolean.importingCustomTheme
    end
    if (cache.boolean.importingCustomTheme) then
        local input = state.GetValue("importingCustomThemeInput", "")
        imgui.SetNextItemWidth(180)
        _, input = imgui.InputTextWithHint("##customThemeStr", "Paste your theme string here.", input, 69420)
        state.SetValue("importingCustomThemeInput", input)
        KeepSameLine()
        if (imgui.Button("Send")) then
            setCustomStyleString(input)
            settingsChanged = true
            cache.boolean.importingCustomTheme = false
            state.SetValue("importingCustomThemeInput", "")
        end
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

function chooseColorTheme()
    local function renderThemeTree(tree)
        local padding = 10

        if (tree[1]) then
            local maxItemSize = 0
            for _, item in ipairs(tree) do
                if (imgui.CalcTextSize(item.id).x > maxItemSize) then
                    maxItemSize = imgui.CalcTextSize(item.id).x * 1.03
                end
            end
            for _, item in ipairs(tree) do
                local col = item.textColor
                local sz = vector.New(maxItemSize, imgui.CalcTextSize(item.id).y) + vector.New(padding, 0)
                imgui.BeginChild("themetree" .. item.id, sz)
                local topLeft = imgui.GetWindowPos()
                local dim = imgui.GetWindowSize()
                local pos = imgui.GetMousePos()
                if (pos.x > topLeft.x and pos.x < topLeft.x + dim.x and pos.y > topLeft.y and pos.y < topLeft.y + dim.y) then
                    local ctx = imgui.GetWindowDrawList()
                    ctx.AddRectFilled(topLeft, topLeft + dim, color.int.white - color.int.alphaMask * 200)
                end
                if (type(item.textColor[1]) == "table") then
                    local strLen = item.id:len()
                    local charProgress = 0
                    local subdivisionLength = #item.textColor - 1
                    for char in item.id:gmatch(".") do
                        local progress = charProgress / (strLen - 1) * subdivisionLength % (1 + 1 / 10000)
                        local currentSubdivision = 1 + math.floor(charProgress / (strLen - 0.999) * subdivisionLength)
                        local col1 = vector.New(item.textColor[currentSubdivision][1] / 255,
                            item.textColor[currentSubdivision][2] / 255, item.textColor[currentSubdivision][3] / 255, 1)
                        local col2 = vector.New(item.textColor[currentSubdivision + 1][1] / 255,
                            item.textColor[currentSubdivision + 1][2] / 255,
                            item.textColor[currentSubdivision + 1][3] / 255, 1)
                        imgui.TextColored(col1 * (1 - progress) +
                            col2 * progress, char)
                        imgui.SameLine(0, 0)
                        charProgress = charProgress + 1
                    end
                else
                    for char in item.id:gmatch(".") do
                        imgui.TextColored(vector.New(col[1] / 255, col[2] / 255, col[3] / 255, 1), char)
                        imgui.SameLine(0, 0)
                    end
                end
                imgui.EndChild()
                if (imgui.IsItemClicked("Left")) then
                    globalVars.colorThemeName = item.internalId or item.id
                    if (item.internalId) then
                        globalCustomStyle = globalVars.customStyles[globalVars.colorThemeName]
                    end
                    write(globalVars)
                    imgui.CloseCurrentPopup()
                end
            end
        else
            for k, v in pairs(tree) do
                if (k == "Custom") then
                    if (imgui.BeginMenu("Custom Themes")) then
                        if (not globalVars.customStyles or not next(globalVars.customStyles)) then
                            imgui.Text("No Custom Themes")
                        else
                            renderThemeTree(table.map(table.keys(globalVars.customStyles), function(s)
                                return {
                                    id = s:sub(8),
                                    textColor = { 255, 255, 255 },
                                    internalId = s
                                }
                            end))
                        end
                        imgui.EndMenu()
                    end
                else
                    ---@diagnostic disable-next-line: param-type-mismatch
                    if (imgui.BeginMenu(k)) then
                        renderThemeTree(v)
                        imgui.EndMenu()
                    end
                end
            end
        end
    end

    if (imgui.BeginCombo("Color Theme", globalVars.colorThemeName:gsub("custom_", ""):fixToSize(130))) then
        renderThemeTree(THEME_TREE)
        imgui.EndCombo()
    end

    local isRGBColorTheme = globalVars.colorThemeName:find("RGB") or globalVars.colorThemeName:find("BGR")
    if not isRGBColorTheme or globalVars.colorThemeName:find("custom_") then return end

    chooseRGBPeriod()
end
