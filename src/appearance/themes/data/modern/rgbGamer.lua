function getRGBGamerTheme(rgbPeriod)
    local rgbColor = getCurrentRGBColors(rgbPeriod, 0.8)
    local inactiveColor = rgbColor - vector.New(0, 0, 0, 0.3)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local clearWhite = vector.New(1.00, 1.00, 1.00, 0.40)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    return {
        border = inactiveColor,
        pulse = black,
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
        border = inactiveColor,
        pulse = black,
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
