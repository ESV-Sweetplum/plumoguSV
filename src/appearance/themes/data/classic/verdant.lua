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
        border = color.hexaToRgba('091413aa'),
        pulse = lightPalette2,
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
