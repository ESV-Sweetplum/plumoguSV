function kusaMovementDisplay(pos, size, selectedSegment)
    local ctx = imgui.GetForegroundDrawList()
    local topCenter = pos - vector.New(0, size / 1.75)
    local rightCenter = pos + vector.New(size / 1.75, 0)
    local bottomCenter = pos + vector.New(0, size / 1.75)
    local leftCenter = pos - vector.New(size / 1.75, 0)
    local lineThickness = size / 35
    local upDownScalingFactor = 0.8
    local leftRightScalingFactor = 1.2

    local topColor = selectedSegment == 0 and color.int.black or color.int.white
    local rightColor = selectedSegment == 1 and color.int.black or color.int.white
    local bottomColor = selectedSegment == 2 and color.int.black or color.int.white
    local leftColor = selectedSegment == 3 and color.int.black or color.int.white

    -- Top Display

    ctx.AddLine(
        topCenter - vector.New(size / 18, 0) * upDownScalingFactor,
        topCenter - vector.New(5 * size / 18, 0) * upDownScalingFactor,
        topColor,
        lineThickness
    )
    ctx.AddLine(
        topCenter - vector.New(size / 6, size / 9) * upDownScalingFactor,
        topCenter - vector.New(size / 6, -size / 9) * upDownScalingFactor,
        topColor,
        lineThickness
    )

    ctx.AddLine(
        topCenter + vector.New(size / 6, -size / 6) * upDownScalingFactor,
        topCenter + vector.New(size / 6, size / 6) * upDownScalingFactor,
        topColor,
        lineThickness
    )
    ctx.AddLine(
        topCenter + vector.New(size / 18, size / 6) * upDownScalingFactor,
        topCenter + vector.New(5 * size / 18, size / 6) * upDownScalingFactor,
        topColor,
        lineThickness
    )
    ctx.AddLine(
        topCenter + vector.New(size / 18, -size / 12) * upDownScalingFactor,
        topCenter + vector.New(size / 6, -size / 12) * upDownScalingFactor,
        topColor,
        lineThickness
    )

    -- Right Display

    ctx.AddLine(
        rightCenter + vector.New(0, size / 8) * leftRightScalingFactor,
        rightCenter + vector.New(size / 8, 0) * leftRightScalingFactor,
        rightColor,
        lineThickness
    )
    ctx.AddLine(
        rightCenter - vector.New(0, size / 8) * leftRightScalingFactor,
        rightCenter + vector.New(size / 8, 0) * leftRightScalingFactor,
        rightColor,
        lineThickness
    )

    -- Bottom Display

    ctx.AddLine(
        bottomCenter - vector.New(size / 18, 0) * upDownScalingFactor,
        bottomCenter - vector.New(5 * size / 18, 0) * upDownScalingFactor,
        bottomColor,
        lineThickness
    )
    ctx.AddLine(
        bottomCenter + vector.New(size / 6, -size / 6) * upDownScalingFactor,
        bottomCenter + vector.New(size / 6, size / 6) * upDownScalingFactor,
        bottomColor,
        lineThickness
    )
    ctx.AddLine(
        bottomCenter + vector.New(size / 18, size / 6) * upDownScalingFactor,
        bottomCenter + vector.New(5 * size / 18, size / 6) * upDownScalingFactor,
        bottomColor,
        lineThickness
    )
    ctx.AddLine(
        bottomCenter + vector.New(size / 18, -size / 12) * upDownScalingFactor,
        bottomCenter + vector.New(size / 6, -size / 12) * upDownScalingFactor,
        bottomColor,
        lineThickness
    )

    -- Left Display

    ctx.AddLine(
        leftCenter + vector.New(0, size / 8) * leftRightScalingFactor,
        leftCenter - vector.New(size / 8, 0) * leftRightScalingFactor,
        leftColor,
        lineThickness
    )
    ctx.AddLine(
        leftCenter - vector.New(0, size / 8) * leftRightScalingFactor,
        leftCenter - vector.New(size / 8, 0) * leftRightScalingFactor,
        leftColor,
        lineThickness
    )
end
