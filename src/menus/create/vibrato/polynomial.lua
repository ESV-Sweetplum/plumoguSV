function polynomialVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 0.875)

        _, settingVars.controlPointCount = imgui.InputInt("Control Points", settingVars.controlPointCount)
        settingVars.controlPointCount = math.clamp(settingVars.controlPointCount, 1, 10)

        while (settingVars.controlPointCount > #settingVars.controlPoints) do
            local points = table.duplicate(settingVars.controlPoints)
            table.insert(points, vector.New(math.random(255), math.random(255)))
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

        imgui.BeginChild("Polynomial Vibrato Interactive Window", vctr2(250), 67, 31)
        local ctx = renderGraph("Polynomial Vibrato Menu", vctr2(250), pointList, false)
        for i = 1, settingVars.controlPointCount do
            settingVars.controlPoints[i] = vector.Clamp(pointList[i].pos, vctr2(0), vctr2(250))
        end
        local normalizedPoints = {}
        for _, point in pairs(settingVars.controlPoints) do
            table.insert(normalizedPoints, vector.New(point.x, 250 - point.y))
        end

        local mtrx = {}
        local vctr = {}
        local pointCount = settingVars.controlPointCount
        for i, point in pairs(settingVars.controlPoints) do
            table.insert(mtrx, 1, {})
            for j = 1, pointCount do
                table.insert(mtrx[1], point.x ^ (pointCount - j))
            end
            table.insert(vctr, 1, 250 - point.y)
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
            return math.clamp(sum, 0, 250)
        end

        for i = 0, RESOLUTION - 1 do
            local currentX = i / RESOLUTION * 250
            local nextX = (i + 1) / RESOLUTION * 250

            local currentY = 250 - evaluatePolynomial(coefficients, currentX)
            local nextY = 250 - evaluatePolynomial(coefficients, nextX)

            ctx.AddLine(topLeft + vector.New(currentX, currentY), topLeft + vector.New(nextX, nextY),
                imgui.GetColorU32("PlotLines", 0.5), 3)
        end

        imgui.EndChild()
        local func = function(t)
            return settingVars.endMsx * t + settingVars.startMsx * (1 - t)
        end
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[8] or nil)
    else

    end
end
