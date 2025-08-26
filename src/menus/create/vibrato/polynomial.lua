function polynomialVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Bounds##Vibrato", " msx", 0, 0.875)
        _, settingVars.controlPointCount = imgui.InputInt("Control Points", settingVars.controlPointCount)
        settingVars.controlPointCount = math.clamp(settingVars.controlPointCount, 1, 10)
        local pointList = {}

        AddSeparator()

        local size = 220
        local RESOLUTION = 50

        while (settingVars.controlPointCount > #settingVars.controlPoints) do
            local points = table.duplicate(settingVars.controlPoints)
            table.insert(points, vector.New(math.random(size), math.random(size)))
            settingVars.controlPoints = table.duplicate(points)
        end

        while (settingVars.controlPointCount < #settingVars.controlPoints) do
            table.remove(settingVars.controlPoints, #settingVars.controlPoints)
        end

        for _, point in pairs(settingVars.controlPoints) do
            table.insert(pointList,
                { pos = table.vectorize2(point), col = rgbaToUint(255, 255, 255, 255), size = 5 })
        end


        imgui.SetCursorPosX(26)
        imgui.BeginChild("Polynomial Vibrato Interactive Window" .. tostring(separateWindow), vctr2(size), 67, 31)
        local ctx, changedPoints = renderGraph("Polynomial Vibrato Menu" .. tostring(separateWindow), vctr2(size),
            pointList, false, 11,
            vector.New(settingVars.startMsx, settingVars.endMsx))

        for i = 1, settingVars.controlPointCount do
            settingVars.controlPoints[i] = vector.Clamp(pointList[i].pos, vctr2(0), vctr2(size))
        end
        local normalizedPoints = {}
        for _, point in pairs(settingVars.controlPoints) do
            table.insert(normalizedPoints, vector.New(point.x, size - point.y))
        end

        if (changedPoints) then
            plotPoints = {}

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

            for i = 0, RESOLUTION - 1 do
                local x = i / RESOLUTION * size
                local y = size - math.clamp(math.evaluatePolynomial(coefficients, x), 0, size)

                table.insert(plotPoints, vector.New(x, y))
            end

            settingVars.plotPoints = table.duplicate(plotPoints)
            settingVars.plotCoefficients = table.duplicate(coefficients)
        end

        local topLeft = imgui.GetWindowPos()

        for i = 1, #settingVars.plotPoints - 1 do
            ctx.AddLine(topLeft + settingVars.plotPoints[i], topLeft + settingVars.plotPoints[i + 1],
                imgui.GetColorU32("PlotLines", 0.5), 3)
        end

        imgui.EndChild()
        local func = function(t)
            return (settingVars.startMsx - settingVars.endMsx) *
                (1 - math.clamp(math.evaluatePolynomial(settingVars.plotCoefficients, t * size) / size, 0, size)) +
                settingVars.endMsx -- Reversed due to the way imgui draws
        end
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[8] or nil)
    else
        imgui.TextColored(vector.New(1, 0, 0, 1), "This mode is not supported.")
    end
end
