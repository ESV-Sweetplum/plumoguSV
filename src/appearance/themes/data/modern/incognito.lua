function getIncognitoTheme()
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local gray = vector.New(0.20, 0.20, 0.20, 1.00)
    local transparentGray = color.alterOpacity(gray, -0.5)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.40)
    local red = vector.New(1.00, 0.00, 0.00, 1.00)
    return {
        border = whiteTint,
        pulse = white,
        imguiData = {
            Button = gray,
            ButtonActive = whiteTint,
            ButtonHovered = whiteTint,
            CheckMark = white,
            FrameBg = gray,
            FrameBgActive = whiteTint,
            FrameBgHovered = whiteTint,
            Header = gray,
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
            Tab = gray,
            TabActive = whiteTint,
            TabHovered = whiteTint,
            TableBorderLight = whiteTint,
            TableBorderStrong = whiteTint,
            Text = white,
            TextSelectedBg = whiteTint,
            TitleBg = gray,
            TitleBgActive = gray,
            TitleBgCollapsed = black,
            WindowBg = black,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = vector.New(1.00, 1.00, 1.00, 1.00),
            PulseTextColorRight = vector.New(1.00, 1.00, 1.00, 1.00),
            BgTl = vector.New(0.00, 0.00, 0.00, 0.39),
            BgTr = transparentGray,
            BgBl = transparentGray,
            BgBr = whiteTint,
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
        border = black,
        pulse = white,
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

function getIncognitoRGBTheme(rgbPeriod)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local gray = vector.New(0.20, 0.20, 0.20, 1.00)
    local transparentGray = color.alterOpacity(gray, -0.5)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.40)
    local rgbColor = getCurrentRGBColors(rgbPeriod, 0.8)
    return {
        border = rgbColor,
        pulse = black,
        imguiData = {
            Button = gray,
            ButtonActive = rgbColor,
            ButtonHovered = whiteTint,
            CheckMark = white,
            FrameBg = gray,
            FrameBgActive = rgbColor,
            FrameBgHovered = whiteTint,
            Header = gray,
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
            SliderGrab = gray,
            SliderGrabActive = rgbColor,
            Tab = gray,
            TabActive = rgbColor,
            TabHovered = whiteTint,
            TableBorderLight = rgbColor,
            TableBorderStrong = rgbColor,
            Text = white,
            TextSelectedBg = rgbColor,
            TitleBg = gray,
            TitleBgActive = gray,
            TitleBgCollapsed = black,
            WindowBg = black,
        },
        loadupData = {
            OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00),
            PulseTextColorLeft = rgbColor,
            PulseTextColorRight = rgbColor,
            BgTl = vector.New(0.00, 0, 0.00, 0.39),
            BgTr = transparentGray,
            BgBl = transparentGray,
            BgBr = white,
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
        border = rgbColor,
        pulse = blackTint,
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
