function setPluginAppearance()
    local colorTheme = COLOR_THEMES[globalVars.colorThemeIndex]
    local styleTheme = STYLE_THEMES[globalVars.styleThemeIndex]

    setPluginAppearanceStyles(styleTheme)
    setPluginAppearanceColors(colorTheme)
end

function setPluginAppearanceStyles(styleTheme)
    local cornerRoundnessValue = (styleTheme == "Boxed" or
        styleTheme == "Boxed + Border") and 0 or 5 -- up to 12, 14 for WindowRounding and 16 for ChildRounding

    local borderSize = tn(styleTheme == "Rounded + Border" or
        styleTheme == "Boxed + Border")

    imgui.PushStyleVar(imgui_style_var.FrameBorderSize, borderSize)
    imgui.PushStyleVar(imgui_style_var.WindowPadding, vector.New(PADDING_WIDTH, 8))
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushStyleVar(imgui_style_var.ItemSpacing, vector.New(DEFAULT_WIDGET_HEIGHT * 0.5 - 1, 4))
    imgui.PushStyleVar(imgui_style_var.ItemInnerSpacing, vector.New(SAMELINE_SPACING, 6))
    imgui.PushStyleVar(imgui_style_var.WindowRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.ChildRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.FrameRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.GrabRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.ScrollbarRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.TabRounding, cornerRoundnessValue)

    -- Doesn't work even though TabBorderSize is changeable in the style editor demo
    -- imgui.PushStyleVar( imgui_style_var.TabBorderSize,      borderSize           )

    -- https://github.com/ocornut/imgui/issues/7297
    -- Apparently TabBorderSize doesn't have a imgui_style_var, so it can only be changed with
    -- imgui.GetStyle() which hasn't worked from my testing in Quaver plugins
end

function setPluginAppearanceColors(colorTheme)
    local borderColor = vctr4(1)

    if colorTheme == "Classic" or not colorTheme then borderColor = setClassicColors() end
    if colorTheme == "Strawberry" then borderColor = setStrawberryColors() end
    if colorTheme == "Amethyst" then borderColor = setAmethystColors() end
    if colorTheme == "Tree" then borderColor = setTreeColors() end
    if colorTheme == "Barbie" then borderColor = setBarbieColors() end
    if colorTheme == "Incognito" then borderColor = setIncognitoColors() end
    if colorTheme == "Incognito + RGB" then borderColor = setIncognitoRGBColors(globalVars.rgbPeriod) end
    if colorTheme == "Tobi's Glass" then borderColor = setTobiGlassColors() end
    if colorTheme == "Tobi's RGB Glass" then borderColor = setTobiRGBGlassColors(globalVars.rgbPeriod) end
    if colorTheme == "Glass" then borderColor = setGlassColors() end
    if colorTheme == "Glass + RGB" then borderColor = setGlassRGBColors(globalVars.rgbPeriod) end
    if colorTheme == "RGB Gamer Mode" then borderColor = setRGBGamerColors(globalVars.rgbPeriod) end
    if colorTheme == "edom remag BGR" then borderColor = setInvertedRGBGamerColors(globalVars.rgbPeriod) end
    if colorTheme == "BGR + otingocnI" then borderColor = setInvertedIncognitoRGBColors(globalVars.rgbPeriod) end
    if colorTheme == "otingocnI" then borderColor = setInvertedIncognitoColors() end
    if colorTheme == "CUSTOM" then borderColor = setCustomColors() end

    cache.borderColor = borderColor
end

function setClassicColors()
    local borderColor = vector.New(0.81, 0.88, 1.00, 0.30)
    imgui.PushStyleColor(imgui_col.WindowBg, vector.New(0.00, 0.00, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, vector.New(0.14, 0.24, 0.28, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered, vector.New(0.24, 0.34, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive, vector.New(0.29, 0.39, 0.43, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, vector.New(0.41, 0.48, 0.65, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive, vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, vector.New(0.51, 0.58, 0.75, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, vector.New(0.81, 0.88, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, vector.New(0.56, 0.63, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive, vector.New(0.61, 0.68, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.Button, vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered, vector.New(0.41, 0.48, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive, vector.New(0.51, 0.58, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.Header, vector.New(0.81, 0.88, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered, vector.New(0.81, 0.88, 1.00, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive, vector.New(0.81, 0.88, 1.00, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, vector.New(0.81, 0.88, 1.00, 0.30))
    imgui.PushStyleColor(imgui_col.Text, vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg, vector.New(0.81, 0.88, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, vector.New(0.41, 0.48, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, vector.New(0.51, 0.58, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.61, 0.61, 0.61, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(1.00, 0.43, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.90, 0.70, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(1.00, 0.60, 0.00, 1.00))

    return borderColor
end

function setStrawberryColors()
    local borderColor = vector.New(1.00, 0.81, 0.88, 0.30)
    imgui.PushStyleColor(imgui_col.WindowBg, vector.New(0.00, 0.00, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, vector.New(0.28, 0.14, 0.24, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered, vector.New(0.38, 0.24, 0.34, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive, vector.New(0.43, 0.29, 0.39, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, vector.New(0.65, 0.41, 0.48, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive, vector.New(0.75, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, vector.New(0.75, 0.51, 0.58, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, vector.New(1.00, 0.81, 0.88, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, vector.New(0.75, 0.56, 0.63, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive, vector.New(0.80, 0.61, 0.68, 1.00))
    imgui.PushStyleColor(imgui_col.Button, vector.New(0.50, 0.31, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered, vector.New(0.60, 0.41, 0.48, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive, vector.New(0.70, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, vector.New(0.50, 0.31, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, vector.New(0.75, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, vector.New(0.75, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.Header, vector.New(1.00, 0.81, 0.88, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered, vector.New(1.00, 0.81, 0.88, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive, vector.New(1.00, 0.81, 0.88, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, vector.New(1.00, 0.81, 0.88, 0.30))
    imgui.PushStyleColor(imgui_col.Text, vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg, vector.New(1.00, 0.81, 0.88, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, vector.New(0.50, 0.31, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, vector.New(0.60, 0.41, 0.48, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, vector.New(0.70, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.61, 0.61, 0.61, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(1.00, 0.43, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.90, 0.70, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(1.00, 0.60, 0.00, 1.00))

    return borderColor
end

function setAmethystColors()
    local borderColor = vector.New(0.90, 0.00, 0.81, 0.30)

    imgui.PushStyleColor(imgui_col.WindowBg, vector.New(0.16, 0.00, 0.20, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, vector.New(0.40, 0.20, 0.40, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered, vector.New(0.50, 0.30, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive, vector.New(0.55, 0.35, 0.55, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, vector.New(0.31, 0.11, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive, vector.New(0.41, 0.21, 0.45, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, vector.New(0.41, 0.21, 0.45, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, vector.New(1.00, 0.80, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, vector.New(0.95, 0.75, 0.95, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive, vector.New(1.00, 0.80, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.Button, vector.New(0.60, 0.40, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered, vector.New(0.70, 0.50, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive, vector.New(0.80, 0.60, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, vector.New(0.50, 0.30, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, vector.New(0.70, 0.50, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, vector.New(0.70, 0.50, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.Header, vector.New(1.00, 0.80, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered, vector.New(1.00, 0.80, 1.00, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive, vector.New(1.00, 0.80, 1.00, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, vector.New(1.00, 0.80, 1.00, 0.30))
    imgui.PushStyleColor(imgui_col.Text, vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg, vector.New(1.00, 0.80, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, vector.New(0.60, 0.40, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, vector.New(0.70, 0.50, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, vector.New(0.80, 0.60, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(1.00, 0.80, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(1.00, 0.70, 0.30, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(1.00, 0.80, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(1.00, 0.70, 0.30, 1.00))

    return borderColor
end

function setTreeColors()
    local borderColor = vector.New(0.81, 0.90, 0.00, 0.30)

    imgui.PushStyleColor(imgui_col.WindowBg, vector.New(0.20, 0.16, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, vector.New(0.40, 0.40, 0.20, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered, vector.New(0.50, 0.50, 0.30, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive, vector.New(0.55, 0.55, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, vector.New(0.35, 0.31, 0.11, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive, vector.New(0.45, 0.41, 0.21, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, vector.New(0.45, 0.41, 0.21, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, vector.New(1.00, 1.00, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, vector.New(0.95, 0.95, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive, vector.New(1.00, 1.00, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.Button, vector.New(0.60, 0.60, 0.40, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered, vector.New(0.70, 0.70, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive, vector.New(0.80, 0.80, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, vector.New(0.50, 0.50, 0.30, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, vector.New(0.70, 0.70, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, vector.New(0.70, 0.70, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.Header, vector.New(1.00, 1.00, 0.80, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered, vector.New(1.00, 1.00, 0.80, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive, vector.New(1.00, 1.00, 0.80, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, vector.New(1.00, 1.00, 0.80, 0.30))
    imgui.PushStyleColor(imgui_col.Text, vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg, vector.New(1.00, 1.00, 0.80, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, vector.New(0.60, 0.60, 0.40, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, vector.New(0.70, 0.70, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, vector.New(0.80, 0.80, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(1.00, 1.00, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(0.30, 1.00, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(1.00, 1.00, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(0.30, 1.00, 0.70, 1.00))

    return borderColor
end

function setBarbieColors()
    local pink = vector.New(0.79, 0.31, 0.55, 1.00)
    local white = vector.New(0.95, 0.85, 0.87, 1.00)
    local blue = vector.New(0.37, 0.64, 0.84, 1.00)
    local pinkTint = vector.New(1.00, 0.86, 0.86, 0.40)

    imgui.PushStyleColor(imgui_col.WindowBg, pink)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, blue)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, pinkTint)
    imgui.PushStyleColor(imgui_col.TitleBg, blue)
    imgui.PushStyleColor(imgui_col.TitleBgActive, blue)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, pink)
    imgui.PushStyleColor(imgui_col.CheckMark, blue)
    imgui.PushStyleColor(imgui_col.SliderGrab, blue)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, pinkTint)
    imgui.PushStyleColor(imgui_col.Button, blue)
    imgui.PushStyleColor(imgui_col.ButtonHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, pinkTint)
    imgui.PushStyleColor(imgui_col.Tab, blue)
    imgui.PushStyleColor(imgui_col.TabHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.TabActive, pinkTint)
    imgui.PushStyleColor(imgui_col.Header, blue)
    imgui.PushStyleColor(imgui_col.HeaderHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, pinkTint)
    imgui.PushStyleColor(imgui_col.Separator, pinkTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, pinkTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, pinkTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, white)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, white)
    imgui.PushStyleColor(imgui_col.PlotLines, pink)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.PlotHistogram, pink)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, pinkTint)

    return pinkTint
end

function setIncognitoColors()
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.20, 0.20, 0.20, 1.00)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.40)
    local red = vector.New(1.00, 0.00, 0.00, 1.00)

    imgui.PushStyleColor(imgui_col.WindowBg, black)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, grey)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, whiteTint)
    imgui.PushStyleColor(imgui_col.TitleBg, grey)
    imgui.PushStyleColor(imgui_col.TitleBgActive, grey)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, black)
    imgui.PushStyleColor(imgui_col.CheckMark, white)
    imgui.PushStyleColor(imgui_col.SliderGrab, grey)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Button, grey)
    imgui.PushStyleColor(imgui_col.ButtonHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Tab, grey)
    imgui.PushStyleColor(imgui_col.TabHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.TabActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Header, grey)
    imgui.PushStyleColor(imgui_col.HeaderHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Separator, whiteTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, white)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, white)
    imgui.PushStyleColor(imgui_col.PlotLines, white)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, red)
    imgui.PushStyleColor(imgui_col.PlotHistogram, white)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, red)

    return whiteTint
end

-- Sets plugin colors to the "Incognito + RGB" theme
-- Parameters
--    rgbPeriod : length in seconds of one RGB color cycle [Int/Float]
function setIncognitoRGBColors(rgbPeriod)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.20, 0.20, 0.20, 1.00)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.40)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local rgbColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)

    imgui.PushStyleColor(imgui_col.WindowBg, black)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, grey)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, rgbColor)
    imgui.PushStyleColor(imgui_col.TitleBg, grey)
    imgui.PushStyleColor(imgui_col.TitleBgActive, grey)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, black)
    imgui.PushStyleColor(imgui_col.CheckMark, white)
    imgui.PushStyleColor(imgui_col.SliderGrab, grey)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Button, grey)
    imgui.PushStyleColor(imgui_col.ButtonHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Tab, grey)
    imgui.PushStyleColor(imgui_col.TabHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.TabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Header, grey)
    imgui.PushStyleColor(imgui_col.HeaderHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Separator, rgbColor)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, rgbColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, white)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLines, white)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotHistogram, white)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, rgbColor)

    return rgbColor
end

function setTobiGlassColors()
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.70)
    local transparentWhite = vector.New(0.30, 0.30, 0.30, 0.50)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.30)
    local buttonColor = vector.New(0.14, 0.24, 0.28, 0.80)
    local frameColor = vector.New(0.24, 0.34, 0.38, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)

    imgui.PushStyleColor(imgui_col.WindowBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, buttonColor)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, whiteTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparentBlack)
    imgui.PushStyleColor(imgui_col.CheckMark, white)
    imgui.PushStyleColor(imgui_col.SliderGrab, frameColor)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, buttonColor)
    imgui.PushStyleColor(imgui_col.Button, buttonColor)
    imgui.PushStyleColor(imgui_col.ButtonHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Tab, transparentBlack)
    imgui.PushStyleColor(imgui_col.TabHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.TabActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Header, transparentBlack)
    imgui.PushStyleColor(imgui_col.HeaderHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Separator, whiteTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, transparentWhite)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, transparentWhite)
    imgui.PushStyleColor(imgui_col.PlotLines, whiteTint)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, transparentWhite)
    imgui.PushStyleColor(imgui_col.PlotHistogram, whiteTint)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, transparentWhite)

    return frameColor
end

-- Sets plugin colors to the "Tobi's RGB Glass" theme
-- Parameters
--    rgbPeriod : length in seconds of one RGB color cycle [Int/Float]
function setTobiRGBGlassColors(rgbPeriod)
    local transparent = vector.New(0.00, 0.00, 0.00, 0.85)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local activeColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local colorTint = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.3)

    imgui.PushStyleColor(imgui_col.WindowBg, transparent)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, transparent)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, colorTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, colorTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparent)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparent)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparent)
    imgui.PushStyleColor(imgui_col.CheckMark, activeColor)
    imgui.PushStyleColor(imgui_col.SliderGrab, colorTint)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.Button, transparent)
    imgui.PushStyleColor(imgui_col.ButtonHovered, colorTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, colorTint)
    imgui.PushStyleColor(imgui_col.Tab, transparent)
    imgui.PushStyleColor(imgui_col.TabHovered, colorTint)
    imgui.PushStyleColor(imgui_col.TabActive, colorTint)
    imgui.PushStyleColor(imgui_col.Header, transparent)
    imgui.PushStyleColor(imgui_col.HeaderHovered, colorTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, colorTint)
    imgui.PushStyleColor(imgui_col.Separator, colorTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLines, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, colorTint)
    imgui.PushStyleColor(imgui_col.PlotHistogram, activeColor)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, colorTint)

    return activeColor
end

function setGlassColors()
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.25)
    local transparentWhite = vector.New(1.00, 1.00, 1.00, 0.70)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.30)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)

    imgui.PushStyleColor(imgui_col.WindowBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, whiteTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparentBlack)
    imgui.PushStyleColor(imgui_col.CheckMark, transparentWhite)
    imgui.PushStyleColor(imgui_col.SliderGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, transparentWhite)
    imgui.PushStyleColor(imgui_col.Button, transparentBlack)
    imgui.PushStyleColor(imgui_col.ButtonHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Tab, transparentBlack)
    imgui.PushStyleColor(imgui_col.TabHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.TabActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Header, transparentBlack)
    imgui.PushStyleColor(imgui_col.HeaderHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Separator, whiteTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, transparentWhite)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, transparentWhite)
    imgui.PushStyleColor(imgui_col.PlotLines, whiteTint)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, transparentWhite)
    imgui.PushStyleColor(imgui_col.PlotHistogram, whiteTint)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, transparentWhite)

    return transparentWhite
end

-- Sets plugin colors to the "Glass + RGB" theme
-- Parameters
--    rgbPeriod : length in seconds of one RGB color cycle [Int/Float]
function setGlassRGBColors(rgbPeriod)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local activeColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local colorTint = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.3)
    local transparent = vector.New(0.00, 0.00, 0.00, 0.25)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)

    imgui.PushStyleColor(imgui_col.WindowBg, transparent)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, transparent)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, colorTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, colorTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparent)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparent)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparent)
    imgui.PushStyleColor(imgui_col.CheckMark, activeColor)
    imgui.PushStyleColor(imgui_col.SliderGrab, colorTint)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.Button, transparent)
    imgui.PushStyleColor(imgui_col.ButtonHovered, colorTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, colorTint)
    imgui.PushStyleColor(imgui_col.Tab, transparent)
    imgui.PushStyleColor(imgui_col.TabHovered, colorTint)
    imgui.PushStyleColor(imgui_col.TabActive, colorTint)
    imgui.PushStyleColor(imgui_col.Header, transparent)
    imgui.PushStyleColor(imgui_col.HeaderHovered, colorTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, colorTint)
    imgui.PushStyleColor(imgui_col.Separator, colorTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLines, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, colorTint)
    imgui.PushStyleColor(imgui_col.PlotHistogram, activeColor)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, colorTint)

    return activeColor
end

-- Sets plugin colors to the "RGB Gamer Mode" theme
-- Parameters
--    rgbPeriod : length in seconds of one RGB color cycle [Int/Float]
function setRGBGamerColors(rgbPeriod)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local activeColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local inactiveColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.5)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local clearWhite = vector.New(1.00, 1.00, 1.00, 0.40)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)

    imgui.PushStyleColor(imgui_col.WindowBg, black)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, activeColor)
    imgui.PushStyleColor(imgui_col.FrameBgActive, activeColor)
    imgui.PushStyleColor(imgui_col.TitleBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.TitleBgActive, activeColor)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, inactiveColor)
    imgui.PushStyleColor(imgui_col.CheckMark, white)
    imgui.PushStyleColor(imgui_col.SliderGrab, activeColor)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, white)
    imgui.PushStyleColor(imgui_col.Button, inactiveColor)
    imgui.PushStyleColor(imgui_col.ButtonHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ButtonActive, activeColor)
    imgui.PushStyleColor(imgui_col.Tab, inactiveColor)
    imgui.PushStyleColor(imgui_col.TabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.TabActive, activeColor)
    imgui.PushStyleColor(imgui_col.Header, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderHovered, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderActive, activeColor)
    imgui.PushStyleColor(imgui_col.Separator, inactiveColor)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, clearWhite)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, inactiveColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.61, 0.61, 0.61, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(1.00, 0.43, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.90, 0.70, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(1.00, 0.60, 0.00, 1.00))

    return inactiveColor
end

-- Sets plugin colors to the "edom remag BGR" theme
-- Parameters
--    rgbPeriod : length in seconds of one RGB color cycle [Int/Float]
function setInvertedRGBGamerColors(rgbPeriod)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local activeColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local inactiveColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.5)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local clearBlack = vector.New(0.00, 0.00, 0.00, 0.40)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)

    imgui.PushStyleColor(imgui_col.WindowBg, white)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.92, 0.92, 0.92, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, activeColor)
    imgui.PushStyleColor(imgui_col.FrameBgActive, activeColor)
    imgui.PushStyleColor(imgui_col.TitleBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.TitleBgActive, activeColor)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, inactiveColor)
    imgui.PushStyleColor(imgui_col.CheckMark, black)
    imgui.PushStyleColor(imgui_col.SliderGrab, activeColor)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, black)
    imgui.PushStyleColor(imgui_col.Button, inactiveColor)
    imgui.PushStyleColor(imgui_col.ButtonHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ButtonActive, activeColor)
    imgui.PushStyleColor(imgui_col.Tab, inactiveColor)
    imgui.PushStyleColor(imgui_col.TabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.TabActive, activeColor)
    imgui.PushStyleColor(imgui_col.Header, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderHovered, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderActive, activeColor)
    imgui.PushStyleColor(imgui_col.Separator, inactiveColor)
    imgui.PushStyleColor(imgui_col.Text, black)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, clearBlack)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, inactiveColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.39, 0.39, 0.39, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(0.00, 0.57, 0.65, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.10, 0.30, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(0.00, 0.40, 1.00, 1.00))

    return inactiveColor
end

-- Sets plugin colors to the "BGR + otingocnI" theme
-- Parameters
--    rgbPeriod : length in seconds of one RGB color cycle [Int/Float]
function setInvertedIncognitoRGBColors(rgbPeriod)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.80, 0.80, 0.80, 1.00)
    local blackTint = vector.New(0.00, 0.00, 0.00, 0.40)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local rgbColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)

    imgui.PushStyleColor(imgui_col.WindowBg, white)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.92, 0.92, 0.92, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, grey)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, blackTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, rgbColor)
    imgui.PushStyleColor(imgui_col.TitleBg, grey)
    imgui.PushStyleColor(imgui_col.TitleBgActive, grey)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, white)
    imgui.PushStyleColor(imgui_col.CheckMark, black)
    imgui.PushStyleColor(imgui_col.SliderGrab, grey)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Button, grey)
    imgui.PushStyleColor(imgui_col.ButtonHovered, blackTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Tab, grey)
    imgui.PushStyleColor(imgui_col.TabHovered, blackTint)
    imgui.PushStyleColor(imgui_col.TabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Header, grey)
    imgui.PushStyleColor(imgui_col.HeaderHovered, blackTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Separator, rgbColor)
    imgui.PushStyleColor(imgui_col.Text, black)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, rgbColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, blackTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, black)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLines, black)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotHistogram, black)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, rgbColor)

    return rgbColor
end

function setInvertedIncognitoColors()
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.80, 0.80, 0.80, 1.00)
    local blackTint = vector.New(0.00, 0.00, 0.00, 0.40)
    local notRed = vector.New(0.00, 1.00, 1.00, 1.00)

    imgui.PushStyleColor(imgui_col.WindowBg, white)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.92, 0.92, 0.92, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, grey)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, blackTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, blackTint)
    imgui.PushStyleColor(imgui_col.TitleBg, grey)
    imgui.PushStyleColor(imgui_col.TitleBgActive, grey)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, white)
    imgui.PushStyleColor(imgui_col.CheckMark, black)
    imgui.PushStyleColor(imgui_col.SliderGrab, grey)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, blackTint)
    imgui.PushStyleColor(imgui_col.Button, grey)
    imgui.PushStyleColor(imgui_col.ButtonHovered, blackTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, blackTint)
    imgui.PushStyleColor(imgui_col.Tab, grey)
    imgui.PushStyleColor(imgui_col.TabHovered, blackTint)
    imgui.PushStyleColor(imgui_col.TabActive, blackTint)
    imgui.PushStyleColor(imgui_col.Header, grey)
    imgui.PushStyleColor(imgui_col.HeaderHovered, blackTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, blackTint)
    imgui.PushStyleColor(imgui_col.Separator, blackTint)
    imgui.PushStyleColor(imgui_col.Text, black)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, blackTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, blackTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, black)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, black)
    imgui.PushStyleColor(imgui_col.PlotLines, black)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, notRed)
    imgui.PushStyleColor(imgui_col.PlotHistogram, black)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, notRed)

    return blackTint
end

function setCustomColors()
    if (globalVars.customStyle == nil) then
        return setClassicColors()
    end
    local borderColor = globalVars.customStyle.border or vector.New(0.81, 0.88, 1.00, 0.30)
    imgui.PushStyleColor(imgui_col.WindowBg, globalVars.customStyle.windowBg or vector.New(0.00, 0.00, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, globalVars.customStyle.popupBg or vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, globalVars.customStyle.frameBg or vector.New(0.14, 0.24, 0.28, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered,
        globalVars.customStyle.frameBgHovered or vector.New(0.24, 0.34, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive,
        globalVars.customStyle.frameBgActive or vector.New(0.29, 0.39, 0.43, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, globalVars.customStyle.titleBg or vector.New(0.41, 0.48, 0.65, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive,
        globalVars.customStyle.titleBgActive or vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed,
        globalVars.customStyle.titleBgCollapsed or vector.New(0.51, 0.58, 0.75, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, globalVars.customStyle.checkMark or vector.New(0.81, 0.88, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, globalVars.customStyle.sliderGrab or vector.New(0.56, 0.63, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive,
        globalVars.customStyle.sliderGrabActive or vector.New(0.61, 0.68, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.Button, globalVars.customStyle.button or vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered,
        globalVars.customStyle.buttonHovered or vector.New(0.41, 0.48, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive,
        globalVars.customStyle.buttonActive or vector.New(0.51, 0.58, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, globalVars.customStyle.tab or vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, globalVars.customStyle.tabHovered or vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, globalVars.customStyle.tabActive or vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.Header, globalVars.customStyle.header or vector.New(0.81, 0.88, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered,
        globalVars.customStyle.headerHovered or vector.New(0.81, 0.88, 1.00, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive,
        globalVars.customStyle.headerActive or vector.New(0.81, 0.88, 1.00, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, globalVars.customStyle.separator or vector.New(0.81, 0.88, 1.00, 0.30))
    imgui.PushStyleColor(imgui_col.Text, globalVars.customStyle.text or vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg,
        globalVars.customStyle.textSelectedBg or vector.New(0.81, 0.88, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab,
        globalVars.customStyle.scrollbarGrab or vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered,
        globalVars.customStyle.scrollbarGrabHovered or vector.New(0.41, 0.48, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive,
        globalVars.customStyle.scrollbarGrabActive or vector.New(0.51, 0.58, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, globalVars.customStyle.plotLines or vector.New(0.61, 0.61, 0.61, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered,
        globalVars.customStyle.plotLinesHovered or vector.New(1.00, 0.43, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram,
        globalVars.customStyle.plotHistogram or vector.New(0.90, 0.70, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered,
        globalVars.customStyle.plotHistogramHovered or vector.New(1.00, 0.60, 0.00, 1.00))

    return borderColor
end

-- Returns the RGB colors based on the current time [Table]
-- Parameters
--    rgbPeriod : length in seconds for one complete RGB cycle (i.e. period) [Int/Float]
function getCurrentRGBColors(rgbPeriod)
    local currentTime = imgui.GetTime()
    local percentIntoRGBCycle = (currentTime % rgbPeriod) / rgbPeriod
    local stagesElapsed = 6 * percentIntoRGBCycle
    local currentStageNumber = math.floor(stagesElapsed)
    local percentIntoStage = math.clamp(stagesElapsed - currentStageNumber, 0, 1)

    local red = 0
    local green = 0
    local blue = 0
    if currentStageNumber == 0 then
        green = 1 - percentIntoStage
        blue = 1
    elseif currentStageNumber == 1 then
        blue = 1
        red = percentIntoStage
    elseif currentStageNumber == 2 then
        blue = 1 - percentIntoStage
        red = 1
    elseif currentStageNumber == 3 then
        green = percentIntoStage
        red = 1
    elseif currentStageNumber == 4 then
        green = 1
        red = 1 - percentIntoStage
    else
        blue = percentIntoStage
        green = 1
    end
    return { red = red, green = green, blue = blue }
end
