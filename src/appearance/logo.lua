local function l(p1, p2, p3, p4)
    local logoLength = 3
    local ctx = imgui.GetForegroundDrawList()
    local windowSize = table.vectorize2(state.WindowSize)
    local scale = 4
    local thickness = 4
    local pulseCol = { loadup.PulseTextColorLeft or DEFAULT_STYLE.loadupPulseTextColorLeft, loadup.PulseTextColorRight or
    DEFAULT_STYLE.loadupPulseTextColorRight }
    local location = windowSize / 2
    local timeProgress = (cache.trueTime % logoLength / logoLength)

    local curvature1 = 0.4
    local curvature2 = 0.25

    local progress = math.clamp(timeProgress, 0, 1) * 2

    if progress <= 1 then
        progress = (1 - (1 - progress) ^ (1 / curvature1))
    else
        progress = (progress - 1) ^ (1 / curvature2) + 1
    end

    progress = progress * 0.5

    local textStrength = math.min(1, progress * 2, (1 - progress) * 2)

    local textCol = loadup.OpeningTextColor or
        DEFAULT_STYLE.loadupOpeningTextColor - (1 - textStrength) * color.vctr.black

    local t0, t1
    local trueProgress = progress * 2

    if trueProgress < 1 then
        t0 = 10 * (trueProgress - 1)
        t1 = (1 - trueProgress / 2) * t0 + trueProgress
    else
        trueProgress = trueProgress - 1
        t0 = trueProgress * 20
        t1 = 1 - trueProgress + t0
    end

    local center = vector.New(267, 48) * scale / 2
    location = location - center

    partialBezierCubic(ctx, t0, t1, location, scale * p1, scale * p2, scale * p3, scale * p4, textCol, thickness,
        pulseCol, scale * 264.77, timeProgress)
end

function logoThread()
    if (kbm.executedKeyCombo('Alt+L')) then
        cache.logoStartTime = 10
    end

    curTime = state.UnixTime or 0
    -- If state.DeltaTime is significantly off of the computed delta time, that means that the computed delta time was delayed in some way. This is used to detect when the plugin is turned off and on (not rapidly).
    if (math.abs(curTime - (prevTime or 0) - state.DeltaTime) > 60000) then
        cache.logoStartTime = clock.getTime()
        if (cache.logoStartTime < 2.5) then
            cache.logoStartTime = cache.logoStartTime + 0.75
        end
    end
    prevTime = state.UnixTime

    local currentTime = clock.getTime() - cache.logoStartTime
    local logoLength = 3

    if ((cache.logoStartTime < 3 or loaded) and not globalVars.disableLoadup) then
        if (currentTime >= 0 and currentTime <= logoLength) then
            drawLogo(currentTime, logoLength, imgui.GetForegroundDrawList(), table.vectorize2(state.WindowSize), 4,
                loadup.OpeningTextColor or DEFAULT_STYLE.loadupOpeningTextColor, 4,
                { loadup.PulseTextColorLeft or DEFAULT_STYLE.loadupPulseTextColorLeft, loadup.PulseTextColorRight or
                DEFAULT_STYLE.loadupPulseTextColorRight })
        end
    else
        cache.logoStartTime = clock.getTime() - 5
    end

    loaded = true
end

---Draws logo, where dim = scale * (267, 48).
---@param currentTime number
---@param logoLength number
---@param ctx ImDrawListPtr
---@param windowSize Vector2
---@param scale number
---@param textCol Vector4
---@param thickness integer
---@param pulseCol [Vector4, Vector4]
function drawLogo(currentTime, logoLength, ctx, windowSize, scale, textCol, thickness, pulseCol)
    if currentTime < 0 then return end
    if currentTime > logoLength then return end

    local location = windowSize / 2
    local timeProgress = (currentTime % logoLength / logoLength)

    local curvature1 = 0.4
    local curvature2 = 0.25

    local progress = math.clamp(timeProgress, 0, 1) * 2

    if progress <= 1 then
        progress = (1 - (1 - progress) ^ (1 / curvature1))
    else
        progress = (progress - 1) ^ (1 / curvature2) + 1
    end

    progress = progress * 0.5
    cache.trueTime = clock.getTime() - cache.logoStartTime

    local bgStrength = 4 * (progress - progress * progress)
    local alphaStrengthFactor = vector.New(1, 1, 1, bgStrength)
    local colTl = color.vrgbaToUint((loadup.BgTl or DEFAULT_STYLE.loadupBgTl) * alphaStrengthFactor)
    local colTr = color.vrgbaToUint((loadup.BgTr or DEFAULT_STYLE.loadupBgTr) * alphaStrengthFactor)
    local colBl = color.vrgbaToUint((loadup.BgBl or DEFAULT_STYLE.loadupBgBl) * alphaStrengthFactor)
    local colBr = color.vrgbaToUint((loadup.BgBr or DEFAULT_STYLE.loadupBgBr) * alphaStrengthFactor)

    local textStrength = math.min(1, progress * 2, (1 - progress) * 2)

    textCol = textCol - (1 - textStrength) * color.vctr.black

    ctx.AddRectFilledMultiColor(vctr2(0), windowSize, colTl, colTr, colBr, colBl)

    local t0, t1
    local trueProgress = progress * 2

    if trueProgress < 1 then
        t0 = 10 * (trueProgress - 1)
        t1 = (1 - trueProgress / 2) * t0 + trueProgress
    else
        trueProgress = trueProgress - 1
        t0 = trueProgress * 20
        t1 = 1 - trueProgress + t0
    end

    local center = vector.New(267, 48) * scale / 2
    location = location - center
    l(vector.New(0, 58.66), vector.New(0, 58.66),
        vector.New(0, 21.16),
        vector.New(0, 21.16))
    l(vector.New(0, 21.16), vector.New(0, 21.16), vector.New(4.05, 21.16), vector.New(4.05, 21.16))
    l(vector.New(4.05, 21.16), vector.New(4.05, 21.16), vector.New(4.05, 25.5), vector.New(4.05, 25.5))
    l(vector.New(4.05, 25.5), vector.New(4.05, 25.5), vector.New(4.55, 25.5), vector.New(4.55, 25.5))
    l(vector.New(4.55, 25.5), vector.New(4.86, 25.03), vector.New(5.28, 24.42), vector.New(5.83, 23.68))
    l(vector.New(5.83, 23.68), vector.New(6.38, 22.94), vector.New(7.18, 22.28), vector.New(8.21, 21.69))
    l(vector.New(8.21, 21.69), vector.New(9.25, 21.10), vector.New(10.66, 20.81), vector.New(12.43, 20.81))
    l(vector.New(12.43, 20.81), vector.New(14.72, 20.81), vector.New(16.75, 21.38), vector.New(18.5, 22.53))
    l(vector.New(18.5, 22.53), vector.New(20.25, 23.68), vector.New(21.62, 25.30), vector.New(22.6, 27.41))
    l(vector.New(22.6, 27.41), vector.New(23.59, 29.52), vector.New(24.08, 32.01), vector.New(24.08, 34.87))
    l(vector.New(24.08, 34.87), vector.New(24.08, 37.76), vector.New(23.59, 40.26), vector.New(22.6, 42.37))
    l(vector.New(22.6, 42.37), vector.New(21.62, 44.48), vector.New(20.26, 46.12), vector.New(18.52, 47.27))
    l(vector.New(18.52, 47.27), vector.New(16.78, 48.43), vector.New(14.77, 49.01), vector.New(12.5, 49.01))
    l(vector.New(12.5, 49.01), vector.New(10.75, 49.01), vector.New(9.34, 48.72), vector.New(8.29, 48.13))
    l(vector.New(8.29, 48.13), vector.New(7.245, 47.54), vector.New(6.43, 46.87), vector.New(5.86, 46.12))
    l(vector.New(5.86, 46.12), vector.New(5.29, 45.37), vector.New(4.86, 44.74), vector.New(4.55, 44.25))
    l(vector.New(4.55, 44.25), vector.New(4.55, 44.25), vector.New(4.19, 44.25), vector.New(4.19, 44.25))
    l(vector.New(4.19, 44.25), vector.New(4.19, 44.25), vector.New(4.19, 58.66), vector.New(4.19, 58.66))
    l(vector.New(4.19, 58.66), vector.New(4.19, 58.66), vector.New(0, 58.66), vector.New(0, 58.66))
    l(vector.New(4.12, 34.8), vector.New(4.12, 36.86), vector.New(4.42, 38.67), vector.New(5.02, 40.24))
    l(vector.New(5.02, 40.24), vector.New(5.63, 41.81), vector.New(6.51, 43.04), vector.New(7.67, 43.92))
    l(vector.New(7.67, 43.92), vector.New(8.83, 44.8), vector.New(10.25, 45.24), vector.New(11.93, 45.24))
    l(vector.New(11.93, 45.24), vector.New(13.68, 45.24), vector.New(15.15, 44.78), vector.New(16.33, 43.85))
    l(vector.New(16.33, 43.85), vector.New(17.50, 42.92), vector.New(18.39, 41.66), vector.New(18.99, 40.08))
    l(vector.New(18.99, 40.08), vector.New(19.59, 38.5), vector.New(19.89, 36.74), vector.New(19.89, 34.8))
    l(vector.New(19.89, 34.8), vector.New(19.89, 32.88), vector.New(19.6, 31.15), vector.New(19.01, 29.61))
    l(vector.New(19.01, 29.61), vector.New(18.42, 28.06), vector.New(17.54, 26.84), vector.New(16.36, 25.93))
    l(vector.New(16.36, 25.93), vector.New(15.19, 25.02), vector.New(13.71, 24.57), vector.New(11.93, 24.57))
    l(vector.New(11.93, 24.57), vector.New(10.23, 24.57), vector.New(8.8, 25), vector.New(7.63, 25.86))
    l(vector.New(7.63, 25.86), vector.New(6.47, 26.72), vector.New(5.6, 27.92), vector.New(5.01, 29.45))
    l(vector.New(5.01, 29.45), vector.New(4.42, 30.98), vector.New(4.12, 32.77), vector.New(4.12, 34.8))
    l(vector.New(34.66, 12.07), vector.New(34.66, 12.07), vector.New(34.66, 48.44), vector.New(34.66, 48.44))
    l(vector.New(34.66, 48.44), vector.New(34.66, 48.44), vector.New(30.47, 48.44), vector.New(30.47, 48.44))
    l(vector.New(30.47, 48.44), vector.New(30.47, 48.44), vector.New(30.47, 12.07), vector.New(30.47, 12.07))
    l(vector.New(30.47, 12.07), vector.New(30.47, 12.07), vector.New(34.66, 12.07), vector.New(34.66, 12.07))
    l(vector.New(59.52, 37.29), vector.New(59.52, 37.29), vector.New(59.52, 21.16), vector.New(59.52, 21.16))
    l(vector.New(59.52, 21.16), vector.New(59.52, 21.16), vector.New(63.71, 21.16), vector.New(63.71, 21.16))
    l(vector.New(63.71, 21.16), vector.New(63.71, 21.16), vector.New(63.71, 48.44), vector.New(63.71, 48.44))
    l(vector.New(63.71, 48.44), vector.New(63.71, 48.44), vector.New(59.52, 48.44), vector.New(59.52, 48.44))
    l(vector.New(59.52, 48.44), vector.New(59.52, 48.44), vector.New(59.52, 43.82), vector.New(59.52, 43.82))
    l(vector.New(59.52, 43.82), vector.New(59.52, 43.82), vector.New(59.23, 43.82), vector.New(59.23, 43.82))
    l(vector.New(59.23, 43.82), vector.New(58.59, 45.21), vector.New(57.6, 46.38), vector.New(56.25, 47.35))
    l(vector.New(56.25, 47.35), vector.New(54.90, 48.31), vector.New(53.26, 48.79), vector.New(51.14, 48.79))
    l(vector.New(51.14, 48.79), vector.New(49.43, 48.79), vector.New(47.92, 48.42), vector.New(46.59, 47.67))
    l(vector.New(46.59, 47.67), vector.New(45.26, 46.92), vector.New(44.22, 45.78), vector.New(43.47, 44.26))
    l(vector.New(43.47, 44.26), vector.New(42.71, 42.73), vector.New(42.33, 40.81), vector.New(42.33, 38.49))
    l(vector.New(42.33, 38.49), vector.New(42.33, 38.49), vector.New(42.33, 21.16), vector.New(42.33, 21.16))
    l(vector.New(42.33, 21.16), vector.New(42.33, 21.16), vector.New(46.52, 21.16), vector.New(46.52, 21.16))
    l(vector.New(46.52, 21.16), vector.New(46.52, 21.16), vector.New(46.52, 38.21), vector.New(46.52, 38.21))
    l(vector.New(46.52, 38.21), vector.New(46.52, 40.2), vector.New(47.08, 41.78), vector.New(48.2, 42.97))
    l(vector.New(48.2, 42.97), vector.New(49.32, 44.15), vector.New(50.75, 44.74), vector.New(52.49, 44.74))
    l(vector.New(52.49, 44.74), vector.New(53.53, 44.74), vector.New(54.59, 44.48), vector.New(55.67, 43.95))
    l(vector.New(55.67, 43.95), vector.New(56.76, 43.42), vector.New(57.67, 42.6), vector.New(58.41, 41.5))
    l(vector.New(58.41, 41.5), vector.New(59.15, 40.39), vector.New(59.52, 38.99), vector.New(59.52, 37.29))
    l(vector.New(71.38, 48.44), vector.New(71.38, 48.44), vector.New(71.38, 21.16), vector.New(71.38, 21.16))
    l(vector.New(71.38, 21.16), vector.New(71.38, 21.16), vector.New(75.43, 21.16), vector.New(75.43, 21.16))
    l(vector.New(75.43, 21.16), vector.New(75.43, 21.16), vector.New(75.43, 25.43), vector.New(75.43, 25.43))
    l(vector.New(75.43, 25.43), vector.New(75.43, 25.43), vector.New(75.78, 25.43), vector.New(75.78, 25.43))
    l(vector.New(75.78, 25.43), vector.New(76.35, 23.97), vector.New(77.26, 22.84), vector.New(78.53, 22.03))
    l(vector.New(78.53, 22.03), vector.New(79.8, 21.22), vector.New(81.32, 20.81), vector.New(83.1, 20.81))
    l(vector.New(83.1, 20.81), vector.New(84.9, 20.81), vector.New(86.4, 21.22), vector.New(87.6, 22.03))
    l(vector.New(87.6, 22.03), vector.New(88.8, 22.84), vector.New(89.74, 23.97), vector.New(90.41, 25.43))
    l(vector.New(90.41, 25.43), vector.New(90.41, 25.43), vector.New(90.7, 25.43), vector.New(90.7, 25.43))
    l(vector.New(90.7, 25.43), vector.New(91.39, 24.02), vector.New(92.44, 22.89), vector.New(93.84, 22.06))
    l(vector.New(93.84, 22.06), vector.New(95.23, 21.23), vector.New(96.91, 20.81), vector.New(98.86, 20.81))
    l(vector.New(98.86, 20.81), vector.New(101.3, 20.81), vector.New(103.3, 21.57), vector.New(104.85, 23.09))
    l(vector.New(104.85, 23.09), vector.New(106.4, 24.61), vector.New(107.17, 26.97), vector.New(107.17, 30.18))
    l(vector.New(107.17, 30.18), vector.New(107.17, 30.18), vector.New(107.17, 48.44), vector.New(107.17, 48.44))
    l(vector.New(107.17, 48.44), vector.New(107.17, 48.44), vector.New(102.98, 48.44), vector.New(102.98, 48.44))
    l(vector.New(102.98, 48.44), vector.New(102.98, 48.44), vector.New(102.98, 30.18), vector.New(102.98, 30.18))
    l(vector.New(102.98, 30.18), vector.New(102.98, 28.17), vector.New(102.43, 26.74), vector.New(101.33, 25.87))
    l(vector.New(101.33, 25.87), vector.New(100.23, 25.00), vector.New(98.93, 24.57), vector.New(97.44, 24.57))
    l(vector.New(97.44, 24.57), vector.New(95.53, 24.57), vector.New(94.04, 25.15), vector.New(92.99, 26.31))
    l(vector.New(92.99, 26.31), vector.New(91.94, 27.46), vector.New(91.41, 28.92), vector.New(91.41, 30.68))
    l(vector.New(91.41, 30.68), vector.New(91.41, 30.68), vector.New(91.41, 48.44), vector.New(91.41, 48.44))
    l(vector.New(91.41, 48.44), vector.New(91.41, 48.44), vector.New(87.14, 48.44), vector.New(87.14, 48.44))
    l(vector.New(87.14, 48.44), vector.New(87.14, 48.44), vector.New(87.14, 29.76), vector.New(87.14, 29.76))
    l(vector.New(87.14, 29.76), vector.New(87.14, 28.21), vector.New(86.64, 26.95), vector.New(85.64, 26))
    l(vector.New(85.64, 26), vector.New(84.63, 25.05), vector.New(83.34, 24.57), vector.New(81.75, 24.57))
    l(vector.New(81.75, 24.57), vector.New(80.66, 24.57), vector.New(79.64, 24.86), vector.New(78.7, 25.44))
    l(vector.New(78.7, 25.44), vector.New(77.76, 26.02), vector.New(77.00, 26.82), vector.New(76.43, 27.85))
    l(vector.New(76.43, 27.85), vector.New(75.86, 28.88), vector.New(75.57, 30.06), vector.New(75.57, 31.39))
    l(vector.New(75.57, 31.39), vector.New(75.57, 31.39), vector.New(75.57, 48.44), vector.New(75.57, 48.44))
    l(vector.New(75.57, 48.44), vector.New(75.57, 48.44), vector.New(71.38, 48.44), vector.New(71.38, 48.44))
    l(vector.New(125.92, 49.01), vector.New(123.46, 49.01), vector.New(121.30, 48.42), vector.New(119.45, 47.25))
    l(vector.New(119.45, 47.25), vector.New(117.6, 46.08), vector.New(116.15, 44.44), vector.New(115.12, 42.33))
    l(vector.New(115.12, 42.33), vector.New(114.09, 40.22), vector.New(113.57, 37.76), vector.New(113.57, 34.94))
    l(vector.New(113.57, 34.94), vector.New(113.57, 32.1), vector.New(114.09, 29.62), vector.New(115.12, 27.5))
    l(vector.New(115.12, 27.5), vector.New(116.15, 25.39), vector.New(117.6, 23.74), vector.New(119.45, 22.57))
    l(vector.New(119.45, 22.57), vector.New(121.30, 21.4), vector.New(123.46, 20.81), vector.New(125.92, 20.81))
    l(vector.New(125.92, 20.81), vector.New(128.39, 20.81), vector.New(130.55, 21.4), vector.New(132.4, 22.57))
    l(vector.New(132.4, 22.57), vector.New(134.25, 23.74), vector.New(135.69, 25.39), vector.New(136.73, 27.5))
    l(vector.New(136.73, 27.5), vector.New(137.76, 29.62), vector.New(138.28, 32.1), vector.New(138.28, 34.94))
    l(vector.New(138.28, 34.94), vector.New(138.28, 37.76), vector.New(137.76, 40.22), vector.New(136.73, 42.33))
    l(vector.New(136.73, 42.33), vector.New(135.69, 44.44), vector.New(134.25, 46.08), vector.New(132.4, 47.25))
    l(vector.New(132.4, 47.25), vector.New(130.55, 48.42), vector.New(128.39, 49.01), vector.New(125.92, 49.01))
    l(vector.New(125.92, 45.24), vector.New(127.79, 45.24), vector.New(129.33, 44.76), vector.New(130.54, 43.8))
    l(vector.New(130.54, 43.8), vector.New(131.75, 42.85), vector.New(132.64, 41.59), vector.New(133.22, 40.02))
    l(vector.New(133.22, 40.02), vector.New(133.8, 38.46), vector.New(134.09, 36.77), vector.New(134.09, 34.94))
    l(vector.New(134.09, 34.94), vector.New(134.09, 33.12), vector.New(133.8, 31.42), vector.New(133.22, 29.85))
    l(vector.New(133.22, 29.85), vector.New(132.64, 28.28), vector.New(131.75, 27.00), vector.New(130.54, 26.03))
    l(vector.New(130.54, 26.03), vector.New(129.33, 25.06), vector.New(127.79, 24.57), vector.New(125.92, 24.57))
    l(vector.New(125.92, 24.57), vector.New(124.05, 24.57), vector.New(122.52, 25.06), vector.New(121.31, 26.03))
    l(vector.New(121.31, 26.03), vector.New(120.10, 27.00), vector.New(119.21, 28.28), vector.New(118.63, 29.85))
    l(vector.New(118.63, 29.85), vector.New(118.05, 31.42), vector.New(117.76, 33.12), vector.New(117.76, 34.94))
    l(vector.New(117.76, 34.94), vector.New(117.76, 36.77), vector.New(118.05, 38.46), vector.New(118.63, 40.02))
    l(vector.New(118.63, 40.02), vector.New(119.21, 41.59), vector.New(120.10, 42.85), vector.New(121.31, 43.8))
    l(vector.New(121.31, 43.8), vector.New(122.52, 44.76), vector.New(124.05, 45.24), vector.New(125.92, 45.24))
    l(vector.New(155.68, 59.23), vector.New(153.66, 59.23), vector.New(151.92, 58.97), vector.New(150.46, 58.46))
    l(vector.New(150.46, 58.46), vector.New(149.01, 57.95), vector.New(147.8, 57.276), vector.New(146.83, 56.44))
    l(vector.New(146.83, 56.44), vector.New(145.86, 55.6), vector.New(145.1, 54.71), vector.New(144.53, 53.76))
    l(vector.New(144.53, 53.76), vector.New(144.53, 53.76), vector.New(147.87, 51.42), vector.New(147.87, 51.42))
    l(vector.New(147.87, 51.42), vector.New(148.25, 51.92), vector.New(148.73, 52.49), vector.New(149.31, 53.13))
    l(vector.New(149.31, 53.13), vector.New(149.89, 53.78), vector.New(150.69, 54.34), vector.New(151.7, 54.82))
    l(vector.New(151.7, 54.82), vector.New(152.71, 55.3), vector.New(154.03, 55.54), vector.New(155.68, 55.54))
    l(vector.New(155.68, 55.54), vector.New(157.88, 55.54), vector.New(159.7, 55.01), vector.New(161.13, 53.94))
    l(vector.New(161.13, 53.94), vector.New(162.56, 52.87), vector.New(163.28, 51.20), vector.New(163.28, 48.93))
    l(vector.New(163.28, 48.93), vector.New(163.28, 48.93), vector.New(163.28, 43.39), vector.New(163.28, 43.39))
    l(vector.New(163.28, 43.39), vector.New(163.28, 43.39), vector.New(162.93, 43.39), vector.New(162.93, 43.39))
    l(vector.New(162.93, 43.39), vector.New(162.62, 43.89), vector.New(162.18, 44.50), vector.New(161.62, 45.23))
    l(vector.New(161.62, 45.23), vector.New(161.06, 45.96), vector.New(160.26, 46.60), vector.New(159.21, 47.17))
    l(vector.New(159.21, 47.17), vector.New(158.16, 47.73), vector.New(156.74, 48.01), vector.New(154.97, 48.01))
    l(vector.New(154.97, 48.01), vector.New(152.77, 48.01), vector.New(150.8, 47.49), vector.New(149.05, 46.45))
    l(vector.New(149.05, 46.45), vector.New(147.30, 45.41), vector.New(145.92, 43.89), vector.New(144.91, 41.9))
    l(vector.New(144.91, 41.9), vector.New(143.9, 39.91), vector.New(143.39, 37.5), vector.New(143.39, 34.66))
    l(vector.New(143.39, 34.66), vector.New(143.39, 31.87), vector.New(143.88, 29.43), vector.New(144.87, 27.35))
    l(vector.New(144.87, 27.35), vector.New(145.85, 25.28), vector.New(147.22, 23.67), vector.New(148.97, 22.52))
    l(vector.New(148.97, 22.52), vector.New(150.72, 21.38), vector.New(152.75, 20.81), vector.New(155.04, 20.81))
    l(vector.New(155.04, 20.81), vector.New(156.82, 20.81), vector.New(158.23, 21.10), vector.New(159.28, 21.69))
    l(vector.New(159.28, 21.69), vector.New(160.33, 22.28), vector.New(161.13, 22.94), vector.New(161.69, 23.68))
    l(vector.New(161.69, 23.68), vector.New(162.26, 24.42), vector.New(162.69, 25.03), vector.New(163, 25.5))
    l(vector.New(163, 25.5), vector.New(163, 25.5), vector.New(163.42, 25.5), vector.New(163.42, 25.5))
    l(vector.New(163.42, 25.5), vector.New(163.42, 25.5), vector.New(163.42, 21.16), vector.New(163.42, 21.16))
    l(vector.New(163.42, 21.16), vector.New(163.42, 21.16), vector.New(167.47, 21.16), vector.New(167.47, 21.16))
    l(vector.New(167.47, 21.16), vector.New(167.47, 21.16), vector.New(167.47, 49.22), vector.New(167.47, 49.22))
    l(vector.New(167.47, 49.22), vector.New(167.47, 51.56), vector.New(166.94, 53.47), vector.New(165.88, 54.94))
    l(vector.New(165.88, 54.94), vector.New(164.82, 56.42), vector.New(163.4, 57.50), vector.New(161.62, 58.19))
    l(vector.New(161.62, 58.19), vector.New(159.84, 58.886), vector.New(157.86, 59.23), vector.New(155.68, 59.23))
    l(vector.New(155.54, 44.25), vector.New(157.22, 44.25), vector.New(158.64, 43.86), vector.New(159.8, 43.09))
    l(vector.New(159.8, 43.09), vector.New(160.96, 42.32), vector.New(161.84, 41.22), vector.New(162.45, 39.77))
    l(vector.New(162.45, 39.77), vector.New(163.05, 38.33), vector.New(163.35, 36.60), vector.New(163.35, 34.59))
    l(vector.New(163.35, 34.59), vector.New(163.35, 32.62), vector.New(163.05, 30.89), vector.New(162.46, 29.39))
    l(vector.New(162.46, 29.39), vector.New(161.87, 27.88), vector.New(161, 26.70), vector.New(159.84, 25.85))
    l(vector.New(159.84, 25.85), vector.New(158.68, 25), vector.New(157.25, 24.57), vector.New(155.54, 24.57))
    l(vector.New(155.54, 24.57), vector.New(153.77, 24.57), vector.New(152.29, 25.02), vector.New(151.11, 25.92))
    l(vector.New(151.11, 25.92), vector.New(149.93, 26.82), vector.New(149.05, 28.03), vector.New(148.46, 29.55))
    l(vector.New(148.46, 29.55), vector.New(147.88, 31.06), vector.New(147.59, 32.74), vector.New(147.59, 34.59))
    l(vector.New(147.59, 34.59), vector.New(147.59, 36.48), vector.New(147.89, 38.15), vector.New(148.48, 39.6))
    l(vector.New(148.48, 39.6), vector.New(149.08, 41.05), vector.New(149.97, 42.19), vector.New(151.15, 43.01))
    l(vector.New(151.15, 43.01), vector.New(152.32, 43.84), vector.New(153.79, 44.25), vector.New(155.54, 44.25))
    l(vector.New(192.33, 37.29), vector.New(192.33, 37.29), vector.New(192.33, 21.16), vector.New(192.33, 21.16))
    l(vector.New(192.33, 21.16), vector.New(192.33, 21.16), vector.New(196.52, 21.16), vector.New(196.52, 21.16))
    l(vector.New(196.52, 21.16), vector.New(196.52, 21.16), vector.New(196.52, 48.44), vector.New(196.52, 48.44))
    l(vector.New(196.52, 48.44), vector.New(196.52, 48.44), vector.New(192.33, 48.44), vector.New(192.33, 48.44))
    l(vector.New(192.33, 48.44), vector.New(192.33, 48.44), vector.New(192.33, 43.82), vector.New(192.33, 43.82))
    l(vector.New(192.33, 43.82), vector.New(192.33, 43.82), vector.New(192.05, 43.82), vector.New(192.05, 43.82))
    l(vector.New(192.05, 43.82), vector.New(191.41, 45.21), vector.New(190.41, 46.38), vector.New(189.06, 47.35))
    l(vector.New(189.06, 47.35), vector.New(187.71, 48.31), vector.New(186.01, 48.79), vector.New(183.95, 48.79))
    l(vector.New(183.95, 48.79), vector.New(182.24, 48.79), vector.New(180.73, 48.42), vector.New(179.4, 47.67))
    l(vector.New(179.4, 47.67), vector.New(178.07, 46.92), vector.New(177.03, 45.78), vector.New(176.28, 44.26))
    l(vector.New(176.28, 44.26), vector.New(175.52, 42.73), vector.New(175.14, 40.81), vector.New(175.14, 38.49))
    l(vector.New(175.14, 38.49), vector.New(175.14, 38.49), vector.New(175.14, 21.16), vector.New(175.14, 21.16))
    l(vector.New(175.14, 21.16), vector.New(175.14, 21.16), vector.New(179.33, 21.16), vector.New(179.33, 21.16))
    l(vector.New(179.33, 21.16), vector.New(179.33, 21.16), vector.New(179.33, 38.21), vector.New(179.33, 38.21))
    l(vector.New(179.33, 38.21), vector.New(179.33, 40.2), vector.New(179.89, 41.78), vector.New(181.01, 42.97))
    l(vector.New(181.01, 42.97), vector.New(182.13, 44.15), vector.New(183.56, 44.74), vector.New(185.3, 44.74))
    l(vector.New(185.3, 44.74), vector.New(186.34, 44.74), vector.New(187.40, 44.48), vector.New(188.49, 43.95))
    l(vector.New(188.49, 43.95), vector.New(189.57, 43.42), vector.New(190.48, 42.6), vector.New(191.22, 41.5))
    l(vector.New(191.22, 41.5), vector.New(191.96, 40.39), vector.New(192.33, 38.99), vector.New(192.33, 37.29))
    l(vector.New(224.64, 21.16), vector.New(224.43, 19.37), vector.New(223.57, 17.97), vector.New(222.05, 16.97))
    l(vector.New(222.05, 16.97), vector.New(220.54, 15.98), vector.New(218.68, 15.48), vector.New(216.48, 15.48))
    l(vector.New(216.48, 15.48), vector.New(214.87, 15.48), vector.New(213.46, 15.74), vector.New(212.26, 16.26))
    l(vector.New(212.26, 16.26), vector.New(211.06, 16.79), vector.New(210.12, 17.50), vector.New(209.45, 18.41))
    l(vector.New(209.45, 18.41), vector.New(208.78, 19.32), vector.New(208.45, 20.36), vector.New(208.45, 21.52))
    l(vector.New(208.45, 21.52), vector.New(208.45, 22.49), vector.New(208.68, 23.32), vector.New(209.15, 24.01))
    l(vector.New(209.15, 24.01), vector.New(209.62, 24.70), vector.New(210.22, 25.28), vector.New(210.96, 25.74))
    l(vector.New(210.96, 25.74), vector.New(211.69, 26.19), vector.New(212.46, 26.57), vector.New(213.26, 26.86))
    l(vector.New(213.26, 26.86), vector.New(214.07, 27.15), vector.New(214.81, 27.38), vector.New(215.48, 27.56))
    l(vector.New(215.48, 27.56), vector.New(215.48, 27.56), vector.New(219.18, 28.55), vector.New(219.18, 28.55))
    l(vector.New(219.18, 28.55), vector.New(220.13, 28.8), vector.New(221.18, 29.14), vector.New(222.35, 29.58))
    l(vector.New(222.35, 29.58), vector.New(223.51, 30.02), vector.New(224.63, 30.62), vector.New(225.7, 31.37))
    l(vector.New(225.7, 31.37), vector.New(226.77, 32.12), vector.New(227.66, 33.08), vector.New(228.36, 34.25))
    l(vector.New(228.36, 34.25), vector.New(229.05, 35.42), vector.New(229.4, 36.86), vector.New(229.4, 38.57))
    l(vector.New(229.4, 38.57), vector.New(229.4, 40.53), vector.New(228.89, 42.30), vector.New(227.87, 43.89))
    l(vector.New(227.87, 43.89), vector.New(226.84, 45.48), vector.New(225.35, 46.74), vector.New(223.39, 47.67))
    l(vector.New(223.39, 47.67), vector.New(221.43, 48.61), vector.New(219.058, 49.08), vector.New(216.26, 49.08))
    l(vector.New(216.26, 49.08), vector.New(213.66, 49.08), vector.New(211.41, 48.66), vector.New(209.51, 47.82))
    l(vector.New(209.51, 47.82), vector.New(207.61, 46.98), vector.New(206.12, 45.81), vector.New(205.03, 44.3))
    l(vector.New(205.03, 44.3), vector.New(203.95, 42.8), vector.New(203.34, 41.05), vector.New(203.2, 39.06))
    l(vector.New(203.2, 39.06), vector.New(203.2, 39.06), vector.New(207.74, 39.06), vector.New(207.74, 39.06))
    l(vector.New(207.74, 39.06), vector.New(207.86, 40.43), vector.New(208.33, 41.57), vector.New(209.14, 42.46))
    l(vector.New(209.14, 42.46), vector.New(209.95, 43.355), vector.New(210.97, 44.02), vector.New(212.22, 44.45))
    l(vector.New(212.22, 44.45), vector.New(213.47, 44.88), vector.New(214.82, 45.1), vector.New(216.26, 45.1))
    l(vector.New(216.26, 45.1), vector.New(217.95, 45.1), vector.New(219.46, 44.82), vector.New(220.79, 44.27))
    l(vector.New(220.79, 44.27), vector.New(222.13, 43.72), vector.New(223.19, 42.96), vector.New(223.97, 41.97))
    l(vector.New(223.97, 41.97), vector.New(224.75, 40.98), vector.New(225.14, 39.82), vector.New(225.14, 38.49))
    l(vector.New(225.14, 38.49), vector.New(225.14, 37.28), vector.New(224.808, 36.30), vector.New(224.13, 35.55))
    l(vector.New(224.13, 35.55), vector.New(223.46, 34.79), vector.New(222.57, 34.17), vector.New(221.47, 33.7))
    l(vector.New(221.47, 33.7), vector.New(220.37, 33.23), vector.New(219.18, 32.81), vector.New(217.9, 32.46))
    l(vector.New(217.9, 32.46), vector.New(217.9, 32.46), vector.New(213.42, 31.18), vector.New(213.42, 31.18))
    l(vector.New(213.42, 31.18), vector.New(210.58, 30.36), vector.New(208.33, 29.19), vector.New(206.68, 27.68))
    l(vector.New(206.68, 27.68), vector.New(205.02, 26.17), vector.New(204.19, 24.18), vector.New(204.19, 21.73))
    l(vector.New(204.19, 21.73), vector.New(204.19, 19.7), vector.New(204.74, 17.92), vector.New(205.85, 16.4))
    l(vector.New(205.85, 16.4), vector.New(206.96, 14.88), vector.New(208.45, 13.7), vector.New(210.32, 12.85))
    l(vector.New(210.32, 12.85), vector.New(212.2, 12.00), vector.New(214.3, 11.58), vector.New(216.62, 11.58))
    l(vector.New(216.62, 11.58), vector.New(218.96, 11.58), vector.New(221.04, 12), vector.New(222.87, 12.83))
    l(vector.New(222.87, 12.83), vector.New(224.69, 13.66), vector.New(226.14, 14.80), vector.New(227.21, 16.25))
    l(vector.New(227.21, 16.25), vector.New(228.28, 17.69), vector.New(228.85, 19.33), vector.New(228.91, 21.16))
    l(vector.New(228.91, 21.16), vector.New(228.91, 21.16), vector.New(224.64, 21.16), vector.New(224.64, 21.16))
    l(vector.New(238.14, 12.07), vector.New(238.14, 12.07), vector.New(248.93, 42.68), vector.New(248.93, 42.68))
    l(vector.New(248.93, 42.68), vector.New(248.93, 42.68), vector.New(249.36, 42.68), vector.New(249.36, 42.68))
    l(vector.New(249.36, 42.68), vector.New(249.36, 42.68), vector.New(260.16, 12.07), vector.New(260.16, 12.07))
    l(vector.New(260.16, 12.07), vector.New(260.16, 12.07), vector.New(264.77, 12.07), vector.New(264.77, 12.07))
    l(vector.New(264.77, 12.07), vector.New(264.77, 12.07), vector.New(251.42, 48.44), vector.New(251.42, 48.44))
    l(vector.New(251.42, 48.44), vector.New(251.42, 48.44), vector.New(246.88, 48.44), vector.New(246.88, 48.44))
    l(vector.New(246.88, 48.44), vector.New(246.88, 48.44), vector.New(233.52, 12.07), vector.New(233.52, 12.07))
    l(vector.New(233.52, 12.07), vector.New(233.52, 12.07), vector.New(238.14, 12.07), vector.New(238.14, 12.07))
end

---Simplified version of de Casteljau's algorithm from [Stack Overflow](https://stackoverflow.com/questions/878862/drawing-part-of-a-bézier-curve-by-reusing-a-basic-bézier-curve-function).
---@param ctx ImDrawListPtr
---@param t0 number
---@param t1 number
---@param location Vector2
---@param p1 Vector2
---@param p2 Vector2
---@param p3 Vector2
---@param p4 Vector2
---@param col Vector4
---@param thickness number
---@param pulseCol [Vector4, Vector4]
---@param timeProgress number
function partialBezierCubic(ctx, t0, t1, location, p1, p2, p3, p4, col, thickness, pulseCol, maxValue, timeProgress)
    local u0 = 1.0 - t0
    local u1 = 1.0 - t1

    local avgX = (p1.x + p4.x) / 2
    local xProgress = avgX / maxValue
    local xCol = (1 - xProgress) * pulseCol[1] + pulseCol[2] * xProgress
    local pulseStrength = 2 ^ (-50 * (timeProgress - 1 / 3 - xProgress / 3) ^ 2)
    local bezierCol = xCol * pulseStrength + col * (1 - pulseStrength)

    local qa = p1 * u0 * u0 + p2 * 2 * t0 * u0 + p3 * t0 * t0
    local qb = p1 * u1 * u1 + p2 * 2 * t1 * u1 + p3 * t1 * t1
    local qc = p2 * u0 * u0 + p2 * 2 * t0 * u0 + p4 * t0 * t0
    local qd = p2 * u1 * u1 + p2 * 2 * t1 * u1 + p4 * t1 * t1

    local np1 = qa * u0 + qc * t0
    local np2 = qa * u1 + qc * t1
    local np3 = qb * u0 + qd * t0
    local np4 = qb * u1 + qd * t1

    ctx.AddBezierCubic(location + np1, location + np2, location + np3, location + np4, color.vrgbaToUint(bezierCol),
        thickness)
end
