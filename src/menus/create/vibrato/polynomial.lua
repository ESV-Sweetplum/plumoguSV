function polynomialVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Bounds##Vibrato", " msx", 0, 0.875)
        _, settingVars.controlPointCount = imgui.InputInt("Control Points", settingVars.controlPointCount)
        settingVars.controlPointCount = math.clamp(settingVars.controlPointCount, 1, 10)
        AddSeparator()

        local size = 220

        PolynomialEditor(size, settingVars, separateWindow)

        local func = function(t)
            return (settingVars.startMsx - settingVars.endMsx) *
                (1 - math.clamp(math.evaluatePolynomial(settingVars.plotCoefficients, t * size) / size, 0, 1)) +
                settingVars.endMsx -- Reversed due to the way imgui draws
        end
        AddSeparator()

        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[8] or nil)
    else
        imgui.TextColored(color.vctr.red, "This mode is not supported.")
    end
end

function PolynomialEditor(size, settingVars, separateWindow)
    local pointList = {}

    local RESOLUTION = 44

    local changedControlCount = false

    while (settingVars.controlPointCount > #settingVars.controlPoints) do
        local points = table.duplicate(settingVars.controlPoints)
        table.insert(points, vector.New(math.random(), math.random()))
        settingVars.controlPoints = table.duplicate(points)
        changedControlCount = true
    end

    while (settingVars.controlPointCount < #settingVars.controlPoints) do
        table.remove(settingVars.controlPoints, #settingVars.controlPoints)
        changedControlCount = true
    end

    for _, point in pairs(settingVars.controlPoints) do
        table.insert(pointList,
            { pos = table.vectorize2(point) * vctr2(size), col = color.int.white, size = 5 })
    end


    imgui.SetCursorPosX(26)
    imgui.BeginChild("Polynomial Vibrato Interactive Window" .. tostring(separateWindow), vctr2(size), 67, 31)
    local ctx, changedPoints = renderGraph("Polynomial Vibrato Menu" .. tostring(separateWindow), vctr2(size),
        pointList, false, 11,
        vector.New(settingVars.startMsx, settingVars.endMsx))

    changedPoints = not truthy(settingVars.plotPoints) or changedPoints

    for i = 1, settingVars.controlPointCount do
        settingVars.controlPoints[i] = vector.Clamp(pointList[i].pos, vctr2(0), vctr2(size)) / vctr2(size)
    end

    if (changedPoints or changedControlCount) then
        plotPoints = {}

        local mtrx = {}
        local vctr = {}
        local pointCount = settingVars.controlPointCount
        for i, point in pairs(settingVars.controlPoints) do
            table.insert(mtrx, 1, {})
            for j = 1, pointCount do
                table.insert(mtrx[1], (point.x * size) ^ (pointCount - j))
            end
            table.insert(vctr, 1, size - point.y * size)
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

        for i = 0, RESOLUTION do
            local x = i / RESOLUTION * size
            local y = size - math.clamp(math.evaluatePolynomial(coefficients, x), 0, size)

            table.insert(plotPoints, vector.New(x, y))
        end

        settingVars.plotPoints = table.duplicate(plotPoints)
        settingVars.plotCoefficients = table.duplicate(coefficients)
    end

    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    for i = 1, #settingVars.plotPoints - 1 do
        local opacityFactor = 0.7 - math.sin(20 * i / #settingVars.plotPoints - clock.getTime() * 5) / 2
        ctx.AddLine(topLeft + settingVars.plotPoints[i],
            vector.Clamp(topLeft + settingVars.plotPoints[i + 1], topLeft, topLeft + dim - vctr2(1)),
            imgui.GetColorU32("PlotLines", opacityFactor), 3)
    end

    imgui.EndChild()
end
