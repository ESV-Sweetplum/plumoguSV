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
        border = color.hexaToRgba('00000077'),
        pulse = darkPink,
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
