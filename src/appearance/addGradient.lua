function addGradient()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local buttonColor = imgui.GetColorU32("Button")
    local bgColor = imgui.GetColorU32("WindowBg")

    local buttonFactor = 0.3
    local tlTr = color.vrgbaToUint(color.uintToRgba(buttonColor) * buttonFactor +
        color.uintToRgba(bgColor) * (1 - buttonFactor))

    ctx.AddRectFilledMultiColor(topLeft, topLeft + dim, bgColor, tlTr, buttonColor, tlTr)
end
