function addGradient()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local buttonColor = imgui.GetColorU32("Button")
    local bgColor = imgui.GetColorU32("WindowBg")

    local buttonFactor = 0.3
    local scalingFactor = 2.5
    local tlTr = color.vrgbaToUint(color.uintToRgba(buttonColor) * buttonFactor +
        color.uintToRgba(bgColor) * (1 - buttonFactor))
    local br = color.vrgbaToUint(color.uintToRgba(buttonColor) * buttonFactor * scalingFactor +
        color.uintToRgba(bgColor) * (1 - buttonFactor * scalingFactor))

    ctx.AddRectFilledMultiColor(topLeft, topLeft + dim, bgColor, tlTr, br, tlTr)
end
