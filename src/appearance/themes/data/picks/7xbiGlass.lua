function get7xbiGlassTheme()
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.70)
    local transparentWhite = vector.New(0.30, 0.30, 0.30, 0.50)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.30)
    local buttonColor = vector.New(0.14, 0.24, 0.28, 0.80)
    local frameColor = vector.New(0.24, 0.34, 0.38, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    return {
        border = frameColor,
        pulse = whiteTint,
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
        border = rgbColor,
        pulse = transparentBlack,
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
