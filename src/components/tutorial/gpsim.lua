function gpsim(label, szFactor, distanceFn, colTbl, simulationDuration, forcedOverride, windowScale)
    if (not forcedOverride) then
        imgui.Dummy(vector.New(0, 10))
        imgui.SetCursorPosX((380 - 270 * szFactor.x) / 2)
    end
    imgui.BeginChild(label, vector.New(270, 150) * szFactor, imgui_child_flags.Border)

    local heightFactor = szFactor.y

    local simulationTime = state.UnixTime % simulationDuration
    local progress = simulationTime / simulationDuration
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local colorTable = {
        rgbaToUint(225, 0, 0, 255),
        rgbaToUint(200, 200, 0, 255),
        rgbaToUint(75, 75, 255, 255),
        rgbaToUint(200, 200, 0, 255),
    }

    for i = 1, #colTbl do
        for _, col in ipairs(colTbl[i]) do
            local height = 50 * (#colTbl * distanceFn(math.wrap(progress + 0.25, 0, 1), i) + #colTbl - i)
            if (height > 150) then
                height = height - 50 * #colTbl
            end
            local notePos = vector.New((col - 1) * 60 + 20, height) * szFactor
            local noteSize = vector.New(50, 20) * szFactor

            local uintColor = rgbaToUint(255, 0, 0, 255)

            ctx.AddRectFilledMultiColor(topLeft + notePos, topLeft + notePos + noteSize, colorTable[i], colorTable[i],
                colorTable[i], colorTable[i])
        end
    end
    imgui.EndChild()
    if (not forcedOverride) then
        imgui.Dummy(vector.New(0, 10))
    end
end
