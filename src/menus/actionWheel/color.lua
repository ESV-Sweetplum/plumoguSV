function kusaColorDisplay(pos, size, selectedSegment)
    local ctx = imgui.GetForegroundDrawList()
    local function showColorSegment(col, segment, isHovering)
        ctx.PathLineTo(pos)
        ctx.PathArcTo(pos, size - 10,
            (segment * 2 - 1) * math.pi / 9 - math.pi / 2,
            (segment * 2 + 1) * math.pi / 9 - math.pi / 2, 64)
        ctx.PathLineTo(pos)

        ctx.PathFillConvex(color.vrgbaToUint(col * (isHovering and 1 or 0.5) * vector.New(1, 1, 1, 2)))
        ctx.PathClear()
    end

    showColorSegment(color.vctr.red, 0, selectedSegment == 0)
    showColorSegment(color.vctr.orange, 1, selectedSegment == 1)
    showColorSegment(color.vctr.yellow, 2, selectedSegment == 2)
    showColorSegment(color.vctr.green, 3, selectedSegment == 3)
    showColorSegment(color.vctr.aqua, 4, selectedSegment == 4)
    showColorSegment(color.vctr.blue, 5, selectedSegment == 5)
    showColorSegment(color.vctr.purple, 6, selectedSegment == 6)
    showColorSegment(color.vctr.pink, 7, selectedSegment == 7)
    showColorSegment(color.vctr.white, 8, selectedSegment == 8)
end
