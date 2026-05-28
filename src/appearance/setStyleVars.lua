function setPluginAppearance()
    local colorTheme = globalVars.colorThemeName
    local styleTheme = STYLE_THEMES[globalVars.styleThemeIndex]

    setPluginAppearanceStyles(styleTheme)
    setPluginAppearanceColors(colorTheme)
end

function setPluginAppearanceStyles(styleTheme)
    local cornerRoundnessvalue = (styleTheme == 'Boxed' or styleTheme == 'Boxed + Border') and 0 or 5 -- up to 12, 14 for WindowRounding and 16 for ChildRounding

    local borderSize = tn(styleTheme == 'Rounded + Border' or styleTheme == 'Boxed + Border')

    imgui.PushStyleVar(imgui_style_var.FrameBorderSize, borderSize)
    imgui.PushStyleVar(imgui_style_var.WindowPadding, vector.New(PADDING_WIDTH, 8))
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushStyleVar(imgui_style_var.ItemSpacing, vector.New(DEFAULT_WIDGET_HEIGHT * 0.5 - 1, 4))
    imgui.PushStyleVar(imgui_style_var.ItemInnerSpacing, vector.New(SAMELINE_SPACING, 6))
    imgui.PushStyleVar(imgui_style_var.WindowRounding, cornerRoundnessvalue)
    imgui.PushStyleVar(imgui_style_var.ChildRounding, cornerRoundnessvalue)
    imgui.PushStyleVar(imgui_style_var.FrameRounding, cornerRoundnessvalue)
    imgui.PushStyleVar(imgui_style_var.GrabRounding, cornerRoundnessvalue)
    imgui.PushStyleVar(imgui_style_var.ScrollbarRounding, cornerRoundnessvalue)
    imgui.PushStyleVar(imgui_style_var.TabRounding, cornerRoundnessvalue)
    imgui.PushStyleVar(imgui_style_var.CellPadding, 0)

    -- Doesn't work even though TabBorderSize is changeable in the style editor demo
    -- imgui.PushStyleVar( imgui_style_var.TabBorderSize,      borderSize           )

    -- https://github.com/ocornut/imgui/issues/7297
    -- Apparently TabBorderSize doesn't have a imgui_style_var, so it can only be changed with
    -- imgui.GetStyle() which hasn't worked from my testing in Quaver plugins
end

function setPluginAppearanceColors(themeName, disableBorderOverwrite)
    local THEMES = {
        ['Original'] = getOriginalTheme,
        ['Strawberry'] = getStrawberryTheme,
        ['Amethyst'] = getAmethystTheme,
        ['Verdant'] = getVerdantTheme,
        ['Transient'] = getTransientTheme,
        ['Incognito'] = getIncognitoTheme,
        ['Incognito + RGB'] = getIncognitoRGBTheme,
        ['otingocnI'] = getInvertedIncognitoTheme,
        ['BGR + otingocnI'] = getInvertedIncognitoRGBTheme,
        ['Glass'] = getGlassTheme,
        ['Glass + RGB'] = getGlassRGBTheme,
        ['RGB Gamer Mode'] = getRGBGamerTheme,
        ['edom remag BGR'] = getInvertedRGBGamerTheme,
        ["7xbi's Glass"] = get7xbiGlassTheme,
        ["7xbi's RGB Glass"] = get7xbiRGBGlassTheme,
        ["aster's catppuccin"] = getAsterCatppuccinTheme,
        ["plum's purple palace"] = getPlumPurplePalaceTheme,
    }

    local themeData
    if themeName and themeName:sub(1, 7) == 'custom_' then
        themeData = getCustomTheme(themeName)
    else
        local themeFunction = THEMES[themeName] or THEMES['Original']
        themeData = themeFunction(globalVars.rgbPeriod)
    end

    local outputData = applyTheme(themeData)

    imgui.PushStyleColor(imgui_col.TableHeaderBg, imgui.GetColorU32(imgui_col.Button, 0.3))

    if disableBorderOverwrite then return end
    local originalTheme = getOriginalTheme()

    cache.set('border/base_color', themeData.border or originalTheme.border)
    cache.set('border/pulse_color', themeData.pulse or themeData.border or originalTheme.pulse)
end
