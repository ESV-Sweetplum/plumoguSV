function getGlassTheme()
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.25)
    local transparentWhite = vector.New(1.00, 1.00, 1.00, 0.70)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.30)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    return {
        border = transparentBlack,
        pulse = transparentWhite,
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
    local colorTint = color.alterOpacity(rgbColor, -0.5)
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.25)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    return {
        border = colorTint,
        pulse = white,
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
