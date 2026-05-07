function kusaColorDisplay(pos, size, segment)
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

    showColorSegment(color.vctr.red, 0, segment == 0)
    showColorSegment(color.vctr.orange, 1, segment == 1)
    showColorSegment(color.vctr.yellow, 2, segment == 2)
    showColorSegment(color.vctr.green, 3, segment == 3)
    showColorSegment(color.vctr.aqua, 4, segment == 4)
    showColorSegment(color.vctr.blue, 5, segment == 5)
    showColorSegment(color.vctr.purple, 6, segment == 6)
    showColorSegment(color.vctr.pink, 7, segment == 7)
    showColorSegment(color.vctr.white, 8, segment == 8)
end
