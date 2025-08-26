function polynomialVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Min/Max Msx##Vibrato", " msx", 0, 0.875)
        _, settingVars.controlPointCount = imgui.InputInt("Control Points", settingVars.controlPointCount)
        settingVars.controlPointCount = math.clamp(settingVars.controlPointCount, 1, 10)

        AddSeparator()

        local size = 220

        while (settingVars.controlPointCount > #settingVars.controlPoints) do
            local points = table.duplicate(settingVars.controlPoints)
            table.insert(points, vector.New(math.random(size), math.random(size)))
            settingVars.controlPoints = table.duplicate(points)
        end

        while (settingVars.controlPointCount < #settingVars.controlPoints) do
            table.remove(settingVars.controlPoints, #settingVars.controlPoints)
        end

        local pointList = {}
        for _, point in pairs(settingVars.controlPoints) do
            table.insert(pointList,
                { pos = table.vectorize2(point), col = rgbaToUint(255, 255, 255, 255), size = 5 })
        end

        imgui.SetCursorPosX(26)
        imgui.BeginChild("Polynomial Vibrato Interactive Window", vctr2(size), 67, 31)
        local ctx = renderGraph("Polynomial Vibrato Menu", vctr2(size), pointList, false, 11,
            vector.New(settingVars.startMsx, settingVars.endMsx))
        for i = 1, settingVars.controlPointCount do
            settingVars.controlPoints[i] = vector.Clamp(pointList[i].pos, vctr2(0), vctr2(size))
        end
        local normalizedPoints = {}
        for _, point in pairs(settingVars.controlPoints) do
            table.insert(normalizedPoints, vector.New(point.x, size - point.y))
        end

        local mtrx = {}
        local vctr = {}
        local pointCount = settingVars.controlPointCount
        for i, point in pairs(settingVars.controlPoints) do
            table.insert(mtrx, 1, {})
            for j = 1, pointCount do
                table.insert(mtrx[1], point.x ^ (pointCount - j))
            end
            table.insert(vctr, 1, size - point.y)
        end

        local sorted = false

        while (not sorted) do
            sorted = true
            for i = 1, #mtrx - 1 do
                if (mtrx[i][2] < mtrx[i + 1][2]) then
                    local tempRow = table.duplicate(mtrx[i])
                    mtrx[i] = table.duplicate(mtrx[i + 1])
                    mtrx[i + 1] = tempRow
                    local tempValue = vctr[i]
                    vctr[i] = vctr[i + 1]
                    vctr[i + 1] = tempValue
                    sorted = false
                end
            end
        end

        local coefficients = matrix.solve(mtrx, vctr) ---@cast coefficients number[]
        local RESOLUTION = 50

        local topLeft = imgui.GetWindowPos()

        local function evaluatePolynomial(ceff, x)
            local sum = 0
            local degree = #ceff - 1
            for i, c in ipairs(ceff) do
                sum = sum + c * x ^ (degree - i + 1)
            end
            return math.clamp(sum, 0, size)
        end

        for i = 0, RESOLUTION - 1 do
            local currentX = i / RESOLUTION * size
            local nextX = (i + 1) / RESOLUTION * size

            local currentY = size - evaluatePolynomial(coefficients, currentX)
            local nextY = size - evaluatePolynomial(coefficients, nextX)

            ctx.AddLine(topLeft + vector.New(currentX, currentY), topLeft + vector.New(nextX, nextY),
                imgui.GetColorU32("PlotLines", 0.5), 3)
        end

        imgui.EndChild()
        local func = function(t)
            return (settingVars.startMsx - settingVars.endMsx) * (1 - evaluatePolynomial(coefficients, t * size) / size) +
                settingVars.endMsx -- Reversed due to the way imgui draws
        end
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[8] or nil)
    else

    end
end
