function setPluginAppearance()
    local colorTheme = globalVars.colorThemeName
    local styleTheme = STYLE_THEMES[globalVars.styleThemeIndex]

    setPluginAppearanceStyles(styleTheme)
    setPluginAppearanceColors(colorTheme)
end

function setPluginAppearanceStyles(styleTheme)
    local cornerRoundnessvalue = (styleTheme == 'Boxed' or
        styleTheme == 'Boxed + Border') and 0 or 5 -- up to 12, 14 for WindowRounding and 16 for ChildRounding

    local borderSize = tn(styleTheme == 'Rounded + Border' or
        styleTheme == 'Boxed + Border')

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

function getOriginalTheme()
    local borderColor = vector.New(0.81, 0.88, 1.00, 0.30)
    return {
        borderColor = borderColor,
        imguiData = {
            Button = vector.New(0.31, 0.38, 0.50, 1.00),
            ButtonActive = vector.New(0.51, 0.58, 0.70, 1.00),
            ButtonHovered = vector.New(0.41, 0.48, 0.60, 1.00),
            CheckMark = vector.New(0.81, 0.88, 1.00, 1.00),
            FrameBg = vector.New(0.14, 0.24, 0.28, 1.00),
            FrameBgActive = vector.New(0.29, 0.39, 0.43, 1.00),
            FrameBgHovered = vector.New(0.24, 0.34, 0.38, 1.00),
            Header = vector.New(0.81, 0.88, 1.00, 0.40),
            HeaderActive = vector.New(0.81, 0.88, 1.00, 0.54),
            HeaderHovered = vector.New(0.81, 0.88, 1.00, 0.50),
            PlotHistogram = vector.New(0.90, 0.70, 0.00, 1.00),
            PlotHistogramHovered = vector.New(1.00, 0.60, 0.00, 1.00),
            PlotLines = vector.New(0.61, 0.61, 0.61, 1.00),
            PlotLinesHovered = vector.New(1.00, 0.43, 0.35, 1.00),
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = vector.New(0.31, 0.38, 0.50, 1.00),
            ScrollbarGrabActive = vector.New(0.51, 0.58, 0.70, 1.00),
            ScrollbarGrabHovered = vector.New(0.41, 0.48, 0.60, 1.00),
            Separator = vector.New(0.81, 0.88, 1.00, 0.30),
            SliderGrab = vector.New(0.56, 0.63, 0.75, 1.00),
            SliderGrabActive = vector.New(0.61, 0.68, 0.80, 1.00),
            Tab = vector.New(0.31, 0.38, 0.50, 1.00),
            TabActive = vector.New(0.51, 0.58, 0.75, 1.00),
            TabHovered = vector.New(0.51, 0.58, 0.75, 1.00),
            TableBorderLight = vector.New(0.81, 0.88, 1.00, 0.30),
            TableBorderStrong = vector.New(0.81, 0.88, 1.00, 0.30),
            Text = vector.New(1.00, 1.00, 1.00, 1.00),
            TextSelectedBg = vector.New(0.81, 0.88, 1.00, 0.40),
            TitleBg = vector.New(0.41, 0.48, 0.65, 1.00),
            TitleBgActive = vector.New(0.51, 0.58, 0.75, 1.00),
            TitleBgCollapsed = vector.New(0.51, 0.58, 0.75, 0.50),
            WindowBg = vector.New(0.00, 0.00, 0.00, 1.00),
        },
        loadupData = {
            OpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00),
            PulseTextColorLeft = vector.New(0.00, 0.50, 1.00, 1.00),
            PulseTextColorRight = vector.New(0.00, 0.00, 1.00, 1.00),
            BgTl = vector.New(0.00, 0.00, 0.00, 0.39),
            BgTr = vector.New(0.31, 0.38, 0.50, 0.67),
            BgBl = vector.New(0.31, 0.38, 0.50, 0.67),
            BgBr = vector.New(0.62, 0.76, 1, 1.00),
        },
    }
end

function getStrawberryTheme()
    local borderColor = vector.New(1.00, 0.81, 0.88, 0.30)
    return {
        borderColor = borderColor,
        imguiData = {
            Button = vector.New(0.50, 0.31, 0.38, 1.00),
            ButtonActive = vector.New(0.70, 0.51, 0.58, 1.00),
            ButtonHovered = vector.New(0.60, 0.41, 0.48, 1.00),
            CheckMark = vector.New(1.00, 0.81, 0.88, 1.00),
            FrameBg = vector.New(0.28, 0.14, 0.24, 1.00),
            FrameBgActive = vector.New(0.43, 0.29, 0.39, 1.00),
            FrameBgHovered = vector.New(0.38, 0.24, 0.34, 1.00),
            Header = vector.New(1.00, 0.81, 0.88, 0.40),
            HeaderActive = vector.New(1.00, 0.81, 0.88, 0.54),
            HeaderHovered = vector.New(1.00, 0.81, 0.88, 0.50),
            PlotHistogram = vector.New(0.90, 0.70, 0.00, 1.00),
            PlotHistogramHovered = vector.New(1.00, 0.60, 0.00, 1.00),
            PlotLines = vector.New(0.61, 0.61, 0.61, 1.00),
            PlotLinesHovered = vector.New(1.00, 0.43, 0.35, 1.00),
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = vector.New(0.50, 0.31, 0.38, 1.00),
            ScrollbarGrabActive = vector.New(0.70, 0.51, 0.58, 1.00),
            ScrollbarGrabHovered = vector.New(0.60, 0.41, 0.48, 1.00),
            Separator = vector.New(1.00, 0.81, 0.88, 0.30),
            SliderGrab = vector.New(0.75, 0.56, 0.63, 1.00),
            SliderGrabActive = vector.New(0.80, 0.61, 0.68, 1.00),
            Tab = vector.New(0.50, 0.31, 0.38, 1.00),
            TabActive = vector.New(0.75, 0.51, 0.58, 1.00),
            TabHovered = vector.New(0.75, 0.51, 0.58, 1.00),
            TableBorderLight = vector.New(1.00, 0.81, 0.88, 0.30),
            TableBorderStrong = vector.New(1.00, 0.81, 0.88, 0.30),
            Text = vector.New(1.00, 1.00, 1.00, 1.00),
            TextSelectedBg = vector.New(1.00, 0.81, 0.88, 0.40),
            TitleBg = vector.New(0.65, 0.41, 0.48, 1.00),
            TitleBgActive = vector.New(0.75, 0.51, 0.58, 1.00),
            TitleBgCollapsed = vector.New(0.75, 0.51, 0.58, 0.50),
            WindowBg = vector.New(0.00, 0.00, 0.00, 1.00),
        },
        loadupData = {
            OpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00),
            PulseTextColorLeft = vector.New(1.00, 0.00, 0, 1.00),
            PulseTextColorRight = vector.New(1.00, 0.50, 0.50, 1.00),
            BgTl = vector.New(0.00, 0, 0.00, 0.39),
            BgTr = vector.New(0.50, 0.31, 0.38, 1.00),
            BgBl = vector.New(0.50, 0.31, 0.38, 1.00),
            BgBr = vector.New(1, 0.62, 0.76, 1.00),
        },
    }
end

function getAmethystTheme()
    local borderColor = vector.New(0.90, 0.00, 0.81, 0.30)
    return {
        borderColor = borderColor,
        imguiData = {
            Button = vector.New(0.60, 0.40, 0.60, 1.00),
            ButtonActive = vector.New(0.80, 0.60, 0.80, 1.00),
            ButtonHovered = vector.New(0.70, 0.50, 0.70, 1.00),
            CheckMark = vector.New(1.00, 0.80, 1.00, 1.00),
            FrameBg = vector.New(0.40, 0.20, 0.40, 1.00),
            FrameBgActive = vector.New(0.55, 0.35, 0.55, 1.00),
            FrameBgHovered = vector.New(0.50, 0.30, 0.50, 1.00),
            Header = vector.New(1.00, 0.80, 1.00, 0.40),
            HeaderActive = vector.New(1.00, 0.80, 1.00, 0.54),
            HeaderHovered = vector.New(1.00, 0.80, 1.00, 0.50),
            PlotHistogram = vector.New(1.00, 0.80, 1.00, 1.00),
            PlotHistogramHovered = vector.New(1.00, 0.70, 0.30, 1.00),
            PlotLines = vector.New(1.00, 0.80, 1.00, 1.00),
            PlotLinesHovered = vector.New(1.00, 0.70, 0.30, 1.00),
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = vector.New(0.60, 0.40, 0.60, 1.00),
            ScrollbarGrabActive = vector.New(0.80, 0.60, 0.80, 1.00),
            ScrollbarGrabHovered = vector.New(0.70, 0.50, 0.70, 1.00),
            Separator = vector.New(1.00, 0.80, 1.00, 0.30),
            SliderGrab = vector.New(0.95, 0.75, 0.95, 1.00),
            SliderGrabActive = vector.New(1.00, 0.80, 1.00, 1.00),
            Tab = vector.New(0.50, 0.30, 0.50, 1.00),
            TabActive = vector.New(0.70, 0.50, 0.70, 1.00),
            TabHovered = vector.New(0.70, 0.50, 0.70, 1.00),
            TableBorderLight = vector.New(1.00, 0.80, 1.00, 0.30),
            TableBorderStrong = vector.New(1.00, 0.80, 1.00, 0.30),
            Text = vector.New(1.00, 1.00, 1.00, 1.00),
            TextSelectedBg = vector.New(1.00, 0.80, 1.00, 0.40),
            TitleBg = vector.New(0.31, 0.11, 0.35, 1.00),
            TitleBgActive = vector.New(0.41, 0.21, 0.45, 1.00),
            TitleBgCollapsed = vector.New(0.41, 0.21, 0.45, 0.50),
            WindowBg = vector.New(0.16, 0.00, 0.20, 1.00),
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = vector.New(0.50, 0.00, 0.75, 1.00),
            PulseTextColorRight = vector.New(1.00, 0.00, 0.60, 1.00),
            BgTl = vector.New(0.00, 0, 0.00, 0.39),
            BgTr = vector.New(0.50, 0.30, 0.50, 1.00),
            BgBl = vector.New(0.50, 0.30, 0.50, 1.00),
            BgBr = vector.New(1.00, 0.60, 1.00, 1.00),
        },
    }
end

function getVerdantTheme()
    local textColor = color.hexaToRgba('EEEEEE')
    local bgColor = color.hexaToRgba('091413')
    local darkPalette1 = color.hexaToRgba('285A48')
    local darkPalette2 = color.hexaToRgba('408A71')
    local darkPalette3 = color.hexaToRgba('B0E4CC')
    local lightPalette1 = color.hexaToRgba('1F6F5F')
    local lightPalette2 = color.hexaToRgba('2FA084')
    local lightPalette3 = color.hexaToRgba('6FCF97')
    return {
        borderColor = color.hexaToRgba('091413aa'),
        imguiData = {
            Button = darkPalette1,
            ButtonActive = lightPalette2,
            ButtonHovered = lightPalette1,
            CheckMark = lightPalette2,
            FrameBg = darkPalette1,
            FrameBgActive = lightPalette2,
            FrameBgHovered = lightPalette1,
            Header = darkPalette1,
            HeaderActive = lightPalette2,
            HeaderHovered = lightPalette1,
            PlotHistogram = lightPalette2,
            PlotHistogramHovered = lightPalette3,
            PlotLines = lightPalette2,
            PlotLinesHovered = lightPalette3,
            PopupBg = bgColor,
            ScrollbarGrab = darkPalette1,
            ScrollbarGrabActive = lightPalette2,
            ScrollbarGrabHovered = lightPalette1,
            Separator = lightPalette3,
            SliderGrab = lightPalette3,
            SliderGrabActive = darkPalette3,
            Tab = darkPalette1,
            TabActive = lightPalette2,
            TabHovered = lightPalette1,
            TableBorderLight = lightPalette1,
            TableBorderStrong = lightPalette3,
            Text = textColor,
            TextSelectedBg = lightPalette2,
            TitleBg = darkPalette1,
            TitleBgActive = lightPalette2,
            TitleBgCollapsed = bgColor,
            WindowBg = bgColor,
        },
        loadupData = {
            OpeningTextColor = color.hexaToRgba('EEEEEE'),
            PulseTextColorLeft = color.hexaToRgba('6FCF97'),
            PulseTextColorRight = color.hexaToRgba('2FA084'),
            BgTl = color.hexaToRgba('408A71AA'),
            BgTr = color.hexaToRgba('285A48AA'),
            BgBl = color.hexaToRgba('285A48AA'),
            BgBr = color.hexaToRgba('091413AA'),
        },
    }
end

function getTransientTheme()
    local pink = color.hexaToRgba('F5A9B8')
    local pastelPink = color.hexaToRgba('F8C7D1')
    local darkPink = color.hexaToRgba('E5244B')
    local white = color.hexaToRgba('FFFFFF')
    local blue = color.hexaToRgba('5BCEFA')
    local pastelBlue = color.hexaToRgba('96DFFC')
    local darkBlue = color.hexaToRgba('079BD5')
    local fgColor = color.hexaToRgba('000000')
    return {
        borderColor = color.hexaToRgba('00000077'),
        imguiData = {
            Button = pink,
            ButtonActive = darkPink,
            ButtonHovered = pastelPink,
            CheckMark = pink,
            FrameBg = blue,
            FrameBgActive = darkBlue,
            FrameBgHovered = pastelBlue,
            Header = blue,
            HeaderActive = darkBlue,
            HeaderHovered = pastelBlue,
            PlotHistogram = pink,
            PlotHistogramHovered = pastelPink,
            PlotLines = pink,
            PlotLinesHovered = pastelPink,
            PopupBg = white,
            ScrollbarGrab = blue,
            ScrollbarGrabActive = darkBlue,
            ScrollbarGrabHovered = pastelBlue,
            Separator = pink,
            SliderGrab = pink,
            SliderGrabActive = darkPink,
            Tab = pink,
            TabActive = darkPink,
            TabHovered = pastelPink,
            TableBorderLight = pink,
            TableBorderStrong = pastelPink,
            Text = fgColor,
            TextSelectedBg = pink,
            TitleBg = pastelBlue,
            TitleBgActive = blue,
            TitleBgCollapsed = white,
            WindowBg = white,
        },
        loadupData = {
            OpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00),
            PulseTextColorLeft = pink,
            PulseTextColorRight = blue,
            BgTl = vector.New(0.00, 0, 0.00, 0.39),
            BgTr = blue,
            BgBl = blue,
            BgBr = pink,
        },
    }
end

function getIncognitoTheme()
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.20, 0.20, 0.20, 1.00)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.40)
    local red = vector.New(1.00, 0.00, 0.00, 1.00)
    return {
        borderColor = whiteTint,
        imguiData = {
            Button = grey,
            ButtonActive = whiteTint,
            ButtonHovered = whiteTint,
            CheckMark = white,
            FrameBg = grey,
            FrameBgActive = whiteTint,
            FrameBgHovered = whiteTint,
            Header = grey,
            HeaderActive = whiteTint,
            HeaderHovered = whiteTint,
            PlotHistogram = white,
            PlotHistogramHovered = red,
            PlotLines = white,
            PlotLinesHovered = red,
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = whiteTint,
            ScrollbarGrabActive = white,
            ScrollbarGrabHovered = white,
            Separator = whiteTint,
            SliderGrab = whiteTint,
            SliderGrabActive = white,
            Tab = grey,
            TabActive = whiteTint,
            TabHovered = whiteTint,
            TableBorderLight = whiteTint,
            TableBorderStrong = whiteTint,
            Text = white,
            TextSelectedBg = whiteTint,
            TitleBg = grey,
            TitleBgActive = grey,
            TitleBgCollapsed = black,
            WindowBg = black,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = vector.New(1.00, 1.00, 1.00, 1.00),
            PulseTextColorRight = vector.New(1.00, 1.00, 1.00, 1.00),
            BgTl = vector.New(0.00, 0, 0.00, 0.39),
            BgTr = grey,
            BgBl = grey,
            BgBr = white,
        },
    }
end

function getIncognitoRGBTheme(rgbPeriod)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.20, 0.20, 0.20, 1.00)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.40)
    local rgbColor = getCurrentRGBColors(rgbPeriod, 0.8)
    return {
        borderColor = rgbColor,
        imguiData = {
            Button = grey,
            ButtonActive = rgbColor,
            ButtonHovered = whiteTint,
            CheckMark = white,
            FrameBg = grey,
            FrameBgActive = rgbColor,
            FrameBgHovered = whiteTint,
            Header = grey,
            HeaderActive = rgbColor,
            HeaderHovered = whiteTint,
            PlotHistogram = white,
            PlotHistogramHovered = rgbColor,
            PlotLines = white,
            PlotLinesHovered = rgbColor,
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = whiteTint,
            ScrollbarGrabActive = rgbColor,
            ScrollbarGrabHovered = white,
            Separator = rgbColor,
            SliderGrab = grey,
            SliderGrabActive = rgbColor,
            Tab = grey,
            TabActive = rgbColor,
            TabHovered = whiteTint,
            TableBorderLight = rgbColor,
            TableBorderStrong = rgbColor,
            Text = white,
            TextSelectedBg = rgbColor,
            TitleBg = grey,
            TitleBgActive = grey,
            TitleBgCollapsed = black,
            WindowBg = black,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = rgbColor,
            PulseTextColorRight = rgbColor,
            BgTl = vector.New(0.00, 0, 0.00, 0.39),
            BgTr = grey,
            BgBl = grey,
            BgBr = white,
        },
    }
end

function get7xbiGlassTheme()
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.70)
    local transparentWhite = vector.New(0.30, 0.30, 0.30, 0.50)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.30)
    local buttonColor = vector.New(0.14, 0.24, 0.28, 0.80)
    local frameColor = vector.New(0.24, 0.34, 0.38, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    return {
        borderColor = frameColor,
        imguiData = {
            Button = buttonColor,
            ButtonActive = whiteTint,
            ButtonHovered = whiteTint,
            CheckMark = white,
            FrameBg = buttonColor,
            FrameBgActive = whiteTint,
            FrameBgHovered = whiteTint,
            Header = transparentBlack,
            HeaderActive = whiteTint,
            HeaderHovered = whiteTint,
            PlotHistogram = whiteTint,
            PlotHistogramHovered = transparentWhite,
            PlotLines = whiteTint,
            PlotLinesHovered = transparentWhite,
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = whiteTint,
            ScrollbarGrabActive = transparentWhite,
            ScrollbarGrabHovered = transparentWhite,
            Separator = whiteTint,
            SliderGrab = frameColor,
            SliderGrabActive = buttonColor,
            Tab = transparentBlack,
            TabActive = whiteTint,
            TabHovered = whiteTint,
            TableBorderLight = whiteTint,
            TableBorderStrong = whiteTint,
            Text = white,
            TextSelectedBg = whiteTint,
            TitleBg = transparentBlack,
            TitleBgActive = transparentBlack,
            TitleBgCollapsed = transparentBlack,
            WindowBg = transparentBlack,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = buttonColor / 2 + color.vctr.white / 2,
            PulseTextColorRight = buttonColor / 2 + color.vctr.white / 2,
            BgTl = transparentBlack,
            BgTr = buttonColor / 2 + color.vctr.black / 2,
            BgBl = buttonColor / 2 + color.vctr.black / 2,
            BgBr = buttonColor / 2 + color.vctr.white / 2,
        },
    }
end

function get7xbiRGBGlassTheme(rgbPeriod)
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.85)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local rgbColor = getCurrentRGBColors(rgbPeriod, 0.8)
    local colorTint = rgbColor - vector.New(0, 0, 0, 0.5)
    local buttonColor = vector.New(0.10, 0.18, 0.21, 0.80)
    return {
        borderColor = rgbColor,
        imguiData = {
            Button = buttonColor,
            ButtonActive = colorTint,
            ButtonHovered = colorTint,
            CheckMark = rgbColor,
            FrameBg = transparentBlack,
            FrameBgActive = colorTint,
            FrameBgHovered = colorTint,
            Header = transparentBlack,
            HeaderActive = colorTint,
            HeaderHovered = colorTint,
            PlotHistogram = rgbColor,
            PlotHistogramHovered = colorTint,
            PlotLines = rgbColor,
            PlotLinesHovered = colorTint,
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = colorTint,
            ScrollbarGrabActive = rgbColor,
            ScrollbarGrabHovered = rgbColor,
            Separator = colorTint,
            SliderGrab = colorTint,
            SliderGrabActive = rgbColor,
            Tab = transparentBlack,
            TabActive = colorTint,
            TabHovered = colorTint,
            TableBorderLight = colorTint,
            TableBorderStrong = colorTint,
            Text = white,
            TextSelectedBg = colorTint,
            TitleBg = transparentBlack,
            TitleBgActive = transparentBlack,
            TitleBgCollapsed = transparentBlack,
            WindowBg = transparentBlack,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = rgbColor,
            PulseTextColorRight = rgbColor,
            BgTl = transparentBlack,
            BgTr = color.vctr.white / 5 + 4 * color.vctr.black / 5,
            BgBl = color.vctr.white / 5 + 4 * color.vctr.black / 5,
            BgBr = color.vctr.blue / 12 + color.vctr.white / 4 + 2 * color.vctr.black / 3,
        },
    }
end

function getGlassTheme()
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.25)
    local transparentWhite = vector.New(1.00, 1.00, 1.00, 0.70)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.30)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    return {
        borderColor = transparentWhite,
        imguiData = {
            Button = transparentBlack,
            ButtonActive = whiteTint,
            ButtonHovered = whiteTint,
            CheckMark = transparentWhite,
            FrameBg = transparentBlack,
            FrameBgActive = whiteTint,
            FrameBgHovered = whiteTint,
            Header = transparentBlack,
            HeaderActive = whiteTint,
            HeaderHovered = whiteTint,
            PlotHistogram = whiteTint,
            PlotHistogramHovered = transparentWhite,
            PlotLines = whiteTint,
            PlotLinesHovered = transparentWhite,
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = whiteTint,
            ScrollbarGrabActive = transparentWhite,
            ScrollbarGrabHovered = transparentWhite,
            Separator = whiteTint,
            SliderGrab = whiteTint,
            SliderGrabActive = transparentWhite,
            Tab = transparentBlack,
            TabActive = whiteTint,
            TabHovered = whiteTint,
            TableBorderLight = whiteTint,
            TableBorderStrong = whiteTint,
            Text = white,
            TextSelectedBg = whiteTint,
            TitleBg = transparentBlack,
            TitleBgActive = transparentBlack,
            TitleBgCollapsed = transparentBlack,
            WindowBg = transparentBlack,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = transparentBlack / 2 + color.vctr.white / 2,
            PulseTextColorRight = color.vctr.white,
            BgTl = transparentBlack,
            BgTr = transparentBlack / 2 + color.vctr.black / 2,
            BgBl = transparentBlack / 2 + color.vctr.black / 2,
            BgBr = transparentBlack / 2 + color.vctr.white / 2,
        },
    }
end

function getGlassRGBTheme(rgbPeriod)
    local rgbColor = getCurrentRGBColors(rgbPeriod, 0.8)
    local colorTint = rgbColor - vector.New(0, 0, 0, 0.5)
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.25)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    return {
        borderColor = rgbColor,
        imguiData = {
            Button = transparentBlack,
            ButtonActive = colorTint,
            ButtonHovered = colorTint,
            CheckMark = rgbColor,
            FrameBg = transparentBlack,
            FrameBgActive = colorTint,
            FrameBgHovered = colorTint,
            Header = transparentBlack,
            HeaderActive = colorTint,
            HeaderHovered = colorTint,
            PlotHistogram = rgbColor,
            PlotHistogramHovered = colorTint,
            PlotLines = rgbColor,
            PlotLinesHovered = colorTint,
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = colorTint,
            ScrollbarGrabActive = rgbColor,
            ScrollbarGrabHovered = rgbColor,
            Separator = colorTint,
            SliderGrab = colorTint,
            SliderGrabActive = rgbColor,
            Tab = transparentBlack,
            TabActive = colorTint,
            TabHovered = colorTint,
            TableBorderLight = colorTint,
            TableBorderStrong = colorTint,
            Text = white,
            TextSelectedBg = colorTint,
            TitleBg = transparentBlack,
            TitleBgActive = transparentBlack,
            TitleBgCollapsed = transparentBlack,
            WindowBg = transparentBlack,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = rgbColor,
            PulseTextColorRight = rgbColor,
            BgTl = transparentBlack,
            BgTr = color.vctr.white / 4 + 3 * color.vctr.black / 4,
            BgBl = color.vctr.white / 4 + 3 * color.vctr.black / 4,
            BgBr = color.vctr.white / 2 + color.vctr.black / 2,
        },
    }
end

function getRGBGamerTheme(rgbPeriod)
    local rgbColor = getCurrentRGBColors(rgbPeriod, 0.8)
    local inactiveColor = rgbColor - vector.New(0, 0, 0, 0.3)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local clearWhite = vector.New(1.00, 1.00, 1.00, 0.40)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    return {
        borderColor = inactiveColor,
        imguiData = {
            Button = inactiveColor,
            ButtonActive = rgbColor,
            ButtonHovered = rgbColor,
            CheckMark = white,
            FrameBg = inactiveColor,
            FrameBgActive = rgbColor,
            FrameBgHovered = rgbColor,
            Header = inactiveColor,
            HeaderActive = rgbColor,
            HeaderHovered = inactiveColor,
            PlotHistogram = vector.New(0.90, 0.70, 0.00, 1.00),
            PlotHistogramHovered = vector.New(1.00, 0.60, 0.00, 1.00),
            PlotLines = vector.New(0.61, 0.61, 0.61, 1.00),
            PlotLinesHovered = vector.New(1.00, 0.43, 0.35, 1.00),
            PopupBg = vector.New(0.08, 0.08, 0.08, 0.94),
            ScrollbarGrab = inactiveColor,
            ScrollbarGrabActive = rgbColor,
            ScrollbarGrabHovered = rgbColor,
            Separator = inactiveColor,
            SliderGrab = rgbColor,
            SliderGrabActive = white,
            Tab = inactiveColor,
            TabActive = rgbColor,
            TabHovered = rgbColor,
            TableBorderLight = inactiveColor,
            TableBorderStrong = inactiveColor,
            Text = white,
            TextSelectedBg = clearWhite,
            TitleBg = inactiveColor,
            TitleBgActive = rgbColor,
            TitleBgCollapsed = inactiveColor,
            WindowBg = black,
        },
        loadupData = {
            OpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00),
            PulseTextColorLeft = inactiveColor,
            PulseTextColorRight = rgbColor,
            BgTl = black,
            BgTr = inactiveColor / 2 + vctr4(0),
            BgBl = inactiveColor / 2 + vctr4(0),
            BgBr = rgbColor / 2 + vctr4(0),
        },
    }
end

function getInvertedRGBGamerTheme(rgbPeriod)
    local rgbColor = getCurrentRGBColors(rgbPeriod, 0.8)
    local inactiveColor = rgbColor - vector.New(0, 0, 0, 0.3)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local clearBlack = vector.New(0.00, 0.00, 0.00, 0.40)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    return {
        borderColor = inactiveColor,
        imguiData = {
            Button = inactiveColor,
            ButtonActive = rgbColor,
            ButtonHovered = rgbColor,
            CheckMark = black,
            FrameBg = inactiveColor,
            FrameBgActive = rgbColor,
            FrameBgHovered = rgbColor,
            Header = inactiveColor,
            HeaderActive = rgbColor,
            HeaderHovered = inactiveColor,
            PlotHistogram = vector.New(0.10, 0.30, 1.00, 1.00),
            PlotHistogramHovered = vector.New(0.00, 0.40, 1.00, 1.00),
            PlotLines = vector.New(0.39, 0.39, 0.39, 1.00),
            PlotLinesHovered = vector.New(0.00, 0.57, 0.65, 1.00),
            PopupBg = vector.New(0.92, 0.92, 0.92, 0.94),
            ScrollbarGrab = inactiveColor,
            ScrollbarGrabActive = rgbColor,
            ScrollbarGrabHovered = rgbColor,
            Separator = inactiveColor,
            SliderGrab = rgbColor,
            SliderGrabActive = black,
            Tab = inactiveColor,
            TabActive = rgbColor,
            TabHovered = rgbColor,
            TableBorderLight = inactiveColor,
            TableBorderStrong = inactiveColor,
            Text = black,
            TextSelectedBg = clearBlack,
            TitleBg = inactiveColor,
            TitleBgActive = rgbColor,
            TitleBgCollapsed = inactiveColor,
            WindowBg = white,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = inactiveColor,
            PulseTextColorRight = rgbColor,
            BgTl = black,
            BgTr = inactiveColor / 2 + vctr4(1) / 2,
            BgBl = inactiveColor / 2 + vctr4(1) / 2,
            BgBr = rgbColor / 2 + vctr4(1) / 2,
        },
    }
end

function getInvertedIncognitoTheme()
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.80, 0.80, 0.80, 1.00)
    local blackTint = vector.New(0.00, 0.00, 0.00, 0.40)
    local notRed = vector.New(0.00, 1.00, 1.00, 1.00)
    return {
        borderColor = blackTint,
        imguiData = {
            Button = grey,
            ButtonActive = blackTint,
            ButtonHovered = blackTint,
            CheckMark = black,
            FrameBg = grey,
            FrameBgActive = blackTint,
            FrameBgHovered = blackTint,
            Header = grey,
            HeaderActive = blackTint,
            HeaderHovered = blackTint,
            PlotHistogram = black,
            PlotHistogramHovered = notRed,
            PlotLines = black,
            PlotLinesHovered = notRed,
            PopupBg = vector.New(0.92, 0.92, 0.92, 0.94),
            ScrollbarGrab = blackTint,
            ScrollbarGrabActive = black,
            ScrollbarGrabHovered = black,
            Separator = blackTint,
            SliderGrab = grey,
            SliderGrabActive = blackTint,
            Tab = grey,
            TabActive = blackTint,
            TabHovered = blackTint,
            TableBorderLight = blackTint,
            TableBorderStrong = blackTint,
            Text = black,
            TextSelectedBg = blackTint,
            TitleBg = grey,
            TitleBgActive = grey,
            TitleBgCollapsed = white,
            WindowBg = white,
        },
        loadupData = {
            OpeningTextColor = white,
            PulseTextColorLeft = black,
            PulseTextColorRight = black,
            BgTl = white / 2 + vctr4(0),
            BgTr = grey,
            BgBl = grey,
            BgBr = black,
        },
    }
end

function getInvertedIncognitoRGBTheme(rgbPeriod)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.80, 0.80, 0.80, 1.00)
    local blackTint = vector.New(0.00, 0.00, 0.00, 0.40)
    local rgbColor = getCurrentRGBColors(rgbPeriod, 0.8)
    return {
        borderColor = rgbColor,
        imguiData = {
            Button = grey,
            ButtonActive = rgbColor,
            ButtonHovered = blackTint,
            CheckMark = black,
            FrameBg = grey,
            FrameBgActive = rgbColor,
            FrameBgHovered = blackTint,
            Header = grey,
            HeaderActive = rgbColor,
            HeaderHovered = blackTint,
            PlotHistogram = black,
            PlotHistogramHovered = rgbColor,
            PlotLines = black,
            PlotLinesHovered = rgbColor,
            PopupBg = vector.New(0.92, 0.92, 0.92, 0.94),
            ScrollbarGrab = blackTint,
            ScrollbarGrabActive = rgbColor,
            ScrollbarGrabHovered = black,
            Separator = rgbColor,
            SliderGrab = grey,
            SliderGrabActive = rgbColor,
            Tab = grey,
            TabActive = rgbColor,
            TabHovered = blackTint,
            TableBorderLight = rgbColor,
            TableBorderStrong = rgbColor,
            Text = black,
            TextSelectedBg = rgbColor,
            TitleBg = grey,
            TitleBgActive = grey,
            TitleBgCollapsed = white,
            WindowBg = white,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = rgbColor,
            PulseTextColorRight = rgbColor,
            BgTl = vector.New(0.00, 0, 0.00, 0.39),
            BgTr = grey,
            BgBl = grey,
            BgBr = white,
        },
    }
end

function getAsterCatppuccinTheme()
    return {
        borderColor = vector.New(0.42, 0.44, 0.53, 1),
        imguiData = {
            Button = vector.New(0.19, 0.2, 0.27, 1),
            ButtonActive = vector.New(0.8, 0.65, 0.97, 1),
            ButtonHovered = vector.New(0.35, 0.36, 0.44, 1),
            CheckMark = vector.New(0.8, 0.65, 0.97, 1),
            FrameBg = vector.New(0.12, 0.12, 0.18, 1),
            FrameBgActive = vector.New(0.19, 0.2, 0.27, 1),
            FrameBgHovered = vector.New(0.35, 0.36, 0.44, 1),
            Header = vector.New(0.8, 0.65, 0.97, 1),
            HeaderActive = vector.New(0.8, 0.65, 0.97, 1),
            HeaderHovered = vector.New(0.8, 0.65, 0.97, 1),
            PlotHistogram = vector.New(0.8, 0.65, 0.97, 1),
            PlotHistogramHovered = vector.New(0.53, 0.22, 0.94, 1),
            PlotLines = vector.New(0.95, 0.55, 0.66, 1),
            PlotLinesHovered = vector.New(0.82, 0.06, 0.22, 1),
            PopupBg = vector.New(0.12, 0.12, 0.18, 1),
            ScrollbarGrabHovered = vector.New(0.19, 0.2, 0.27, 1),
            Separator = vector.New(0.35, 0.36, 0.44, 1),
            SliderGrab = vector.New(0.12, 0.12, 0.18, 1),
            SliderGrabActive = vector.New(0.35, 0.36, 0.44, 1),
            Tab = vector.New(0.19, 0.2, 0.27, 1),
            TabActive = vector.New(0.8, 0.65, 0.97, 1),
            TabHovered = vector.New(0.35, 0.36, 0.44, 1),
            TableBorderLight = vector.New(0.35, 0.36, 0.44, 1),
            TableBorderStrong = vector.New(0.35, 0.36, 0.44, 1),
            Text = vector.New(0.8, 0.84, 0.96, 1),
            TextSelectedBg = vector.New(0.8, 0.65, 0.97, 0.4),
            TitleBg = vector.New(0.12, 0.12, 0.18, 1),
            TitleBgActive = vector.New(0.07, 0.07, 0.11, 1),
            TitleBgCollapsed = vector.New(0.12, 0.12, 0.18, 0.4),
            WindowBg = vector.New(0.07, 0.07, 0.11, 1),
        },
        loadupData = {
            OpeningTextColor = vector.New(0.19, 0.2, 0.27, 1),
            PulseTextColorLeft = vector.New(0.8, 0.65, 0.97, 1),
            PulseTextColorRight = vector.New(0.96, 0.76, 0.91, 1),
            BgTl = vector.New(0.07, 0.07, 0.11, 0.6),
            BgTr = vector.New(0.11, 0.05, 0.2, 0.6),
            BgBl = vector.New(0.2, 0.1, 0.17, 0.6),
            BgBr = vector.New(0.12, 0.12, 0.18, 0.6),
        },
    }
end

function getPlumPurplePalaceTheme()
    return {
        borderColor = vector.New(0, 0, 0, 1),
        imguiData = {
            Button = vector.New(0.18, 0.03, 0.37, 0.8),
            ButtonActive = vector.New(0.49, 0.2, 0.82, 1),
            ButtonHovered = vector.New(0.24, 0.02, 0.4, 1),
            CheckMark = vector.New(0.89, 0, 1, 0.65),
            FrameBg = vector.New(0.16, 0.03, 0.27, 0.51),
            FrameBgActive = vector.New(0.69, 0.5, 0.94, 1),
            FrameBgHovered = vector.New(0.3, 0.07, 0.49, 0.52),
            Header = vector.New(0.69, 0.44, 1, 0.4),
            HeaderActive = vector.New(0.69, 0.44, 1, 0.4),
            HeaderHovered = vector.New(0.69, 0.44, 1, 0.4),
            PlotHistogram = vector.New(0.28, 0, 0.9, 1),
            PlotHistogramHovered = vector.New(0.58, 0, 1, 1),
            PlotLines = vector.New(1, 0.44, 0.44, 1),
            PlotLinesHovered = vector.New(1, 0.12, 0, 1),
            PopupBg = vector.New(0.17, 0.11, 0.24, 0.69),
            ScrollbarGrabHovered = vector.New(0.41, 0.48, 0.6, 1),
            Separator = vector.New(0.53, 0, 1, 0.3),
            SliderGrab = vector.New(0.31, 0.38, 0.5, 1),
            SliderGrabActive = vector.New(0.51, 0.58, 0.7, 1),
            Tab = vector.New(0.39, 0.12, 0.73, 0.39),
            TabActive = vector.New(0.4, 0, 0.69, 1),
            TabHovered = vector.New(0.25, 0.02, 0.41, 1),
            TableBorderLight = vector.New(0.53, 0, 1, 0.3),
            TableBorderStrong = vector.New(0.53, 0, 1, 0.3),
            Text = vector.New(1, 1, 1, 1),
            TextSelectedBg = vector.New(0.96, 0.51, 1, 0.4),
            TitleBg = vector.New(0, 0, 0, 0.76),
            TitleBgActive = vector.New(0.12, 0.02, 0.27, 1),
            TitleBgCollapsed = vector.New(0.6, 0.51, 0.75, 0.39),
            WindowBg = vector.New(0, 0, 0, 0.52),
        },
        loadupData = {
            OpeningTextColor = vector.New(0, 0, 0, 1),
            PulseTextColorLeft = vector.New(0.5, 0, 1, 1),
            PulseTextColorRight = vector.New(0.75, 0.25, 1, 1),
            BgTl = vector.New(0.08, 0, 0.08, 0.39),
            BgTr = vector.New(0.16, 0, 0.16, 0.67),
            BgBl = vector.New(0.16, 0, 0.16, 0.67),
            BgBr = vector.New(0.25, 0, 0.25, 1),
        },
    }
end

function getCustomTheme()
    if globalCustomStyle == nil then
        return getOriginalTheme()
    end
    local borderColor = globalCustomStyle.border or vector.New(0.81, 0.88, 1.00, 0.30)
    return {
        borderColor = borderColor,
        imguiData = {
            WindowBg = globalCustomStyle.windowBg or vector.New(0.00, 0.00, 0.00, 1.00),
            PopupBg = globalCustomStyle.popupBg or vector.New(0.08, 0.08, 0.08, 0.94),
            FrameBg = globalCustomStyle.frameBg or vector.New(0.14, 0.24, 0.28, 1.00),
            TitleBg = globalCustomStyle.titleBg or vector.New(0.41, 0.48, 0.65, 1.00),
            CheckMark = globalCustomStyle.checkMark or vector.New(0.81, 0.88, 1.00, 1.00),
            SliderGrab = globalCustomStyle.sliderGrab or vector.New(0.56, 0.63, 0.75, 1.00),
            Button = globalCustomStyle.button or vector.New(0.31, 0.38, 0.50, 1.00),
            Tab = globalCustomStyle.tab or vector.New(0.31, 0.38, 0.50, 1.00),
            TabHovered = globalCustomStyle.tabHovered or vector.New(0.51, 0.58, 0.75, 1.00),
            TabActive = globalCustomStyle.tabActive or vector.New(0.51, 0.58, 0.75, 1.00),
            Header = globalCustomStyle.header or vector.New(0.81, 0.88, 1.00, 0.40),
            Separator = globalCustomStyle.separator or vector.New(0.81, 0.88, 1.00, 0.30),
            Text = globalCustomStyle.text or vector.New(1.00, 1.00, 1.00, 1.00),
            PlotLines = globalCustomStyle.plotLines or vector.New(0.61, 0.61, 0.61, 1.00),
            FrameBgHovered = globalCustomStyle.frameBgHovered or vector.New(0.24, 0.34, 0.38, 1.00),
            FrameBgActive = globalCustomStyle.frameBgActive or vector.New(0.29, 0.39, 0.43, 1.00),
            TitleBgActive = globalCustomStyle.titleBgActive or vector.New(0.51, 0.58, 0.75, 1.00),
            TitleBgCollapsed = globalCustomStyle.titleBgCollapsed or vector.New(0.51, 0.58, 0.75, 0.50),
            SliderGrabActive = globalCustomStyle.sliderGrabActive or vector.New(0.61, 0.68, 0.80, 1.00),
            ButtonHovered = globalCustomStyle.buttonHovered or vector.New(0.41, 0.48, 0.60, 1.00),
            ButtonActive = globalCustomStyle.buttonActive or vector.New(0.51, 0.58, 0.70, 1.00),
            HeaderHovered = globalCustomStyle.headerHovered or vector.New(0.81, 0.88, 1.00, 0.50),
            HeaderActive = globalCustomStyle.headerActive or vector.New(0.81, 0.88, 1.00, 0.54),
            TableBorderLight = globalCustomStyle.tableBorderLight or vector.New(0.81, 0.88, 1.00, 0.30),
            TableBorderStrong = globalCustomStyle.tableBorderStrong or vector.New(0.81, 0.88, 1.00, 0.30),
            TextSelectedBg = globalCustomStyle.textSelectedBg or vector.New(0.81, 0.88, 1.00, 0.40),
            ScrollbarGrab = globalCustomStyle.scrollbarGrab or vector.New(0.31, 0.38, 0.50, 1.00),
            ScrollbarGrabHovered = globalCustomStyle.scrollbarGrabHovered or vector.New(0.41, 0.48, 0.60, 1.00),
            ScrollbarGrabActive = globalCustomStyle.scrollbarGrabActive or vector.New(0.51, 0.58, 0.70, 1.00),
            PlotLinesHovered = globalCustomStyle.plotLinesHovered or vector.New(1.00, 0.43, 0.35, 1.00),
            PlotHistogram = globalCustomStyle.plotHistogram or vector.New(0.90, 0.70, 0.00, 1.00),
            PlotHistogramHovered = globalCustomStyle.plotHistogramHovered or vector.New(1.00, 0.60, 0.00, 1.00),
        },
        loadupData = {
            OpeningTextColor = globalCustomStyle.loadupOpeningTextColor,
            PulseTextColorLeft = globalCustomStyle.loadupPulseTextColorLeft,
            PulseTextColorRight = globalCustomStyle.loadupPulseTextColorRight,
            BgTl = globalCustomStyle.loadupBgTl,
            BgTr = globalCustomStyle.loadupBgTr,
            BgBl = globalCustomStyle.loadupBgBl,
            BgBr = globalCustomStyle.loadupBgBr,
        },
    }
end

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

function applyTheme(themeData)
    if themeData.imguiData then
        for styleKey, colorObj in pairs(themeData.imguiData) do
            local imguiId = imgui_col[styleKey]
            if imguiId then
                imgui.PushStyleColor(imguiId, colorObj)
            end
        end
    end

    if themeData.loadupData then
        for varName, colorObj in pairs(themeData.loadupData) do
            loadup[varName] = colorObj
        end
    end

    return themeData.borderColor
end

function setPluginAppearanceColors(colorTheme, hideBorder)
    local themeData
    if colorTheme and colorTheme:sub(1, 7) == 'custom_' then
        themeData = getCustomTheme()
    else
        local themeFunction = THEMES[colorTheme] or THEMES['Original']
        themeData = themeFunction(globalVars.rgbPeriod)
    end

    local borderColor = applyTheme(themeData)

    imgui.PushStyleColor(imgui_col.TableHeaderBg, imgui.GetColorU32(imgui_col.Button, 0.3))

    if hideBorder then return end

    cache.borderColor = borderColor or getOriginalTheme().borderColor
end

function getCurrentRGBColors(rgbPeriod, alpha)
    local currentTime = clock.getTime()
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
    return vector.New(red, green, blue, alpha or 1)
end
