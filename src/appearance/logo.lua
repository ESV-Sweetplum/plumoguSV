function logoThread()
    curTime = state.UnixTime or 0
    -- If state.DeltaTime is significantly off of the computed delta time, that means that the computed delta time was delayed in some way. This is used to detect when the plugin is turned off and on (not rapidly).
    if (math.abs(curTime - (prevTime or 0) - state.DeltaTime) > 5000) then
        cache_logoStartTime = clock.getTime()
        if (cache_logoStartTime < 2.5) then
            cache_logoStartTime = cache_logoStartTime + 0.75
        end
    end
    prevTime = state.UnixTime

    local currentTime = clock.getTime() - cache_logoStartTime
    local logoLength = 2

    if ((cache_logoStartTime < 3 and not globalVars.disableLoadup) or loaded) then
        if (currentTime >= 0 and currentTime <= logoLength) then
            drawLogo(currentTime, logoLength, imgui.GetForegroundDrawList(), table.vectorize2(state.WindowSize), 4,
                color.int.white, 4)
        end
    else
        cache_logoStartTime = clock.getTime() - 5
    end

    loaded = true
end

---Draws logo, where dim = scale * (267, 48).
---@param currentTime number
---@param logoLength number
---@param ctx ImDrawListPtr
---@param windowSize Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawLogo(currentTime, logoLength, ctx, windowSize, scale, col, thickness)
    if (currentTime < 0) then return end
    if (currentTime > logoLength) then return end
    local location = windowSize / 2
    local progress = (currentTime % logoLength / logoLength)

    local curvature = 0.5

    progress = math.clamp(progress, 0, 1) * 2

    if (progress <= 1) then
        progress = (1 - (1 - progress) ^ (1 / curvature))
    else
        progress = (progress - 1) ^ (1 / curvature) + 1
    end

    progress = progress * 0.5

    local bgStrength = 4 * (progress - progress * progress)
    local colTl = color.rgbaToUint(20, 0, 20, 100 * bgStrength)
    local colTrBl = color.rgbaToUint(40, 0, 40, 200 * bgStrength)
    local colBr = color.rgbaToUint(60, 0, 60, 255 * bgStrength)

    ctx.AddRectFilledMultiColor(vctr2(0), windowSize, colTl, colTrBl, colBr, colTrBl)

    local t0 = math.max(progress * 2, 1) - 1
    local t1 = math.min(progress * 2, 1)

    local center = vector.New(267, 48) * scale / 2
    location = location - center
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(0, 58.66)), location + scale * (vector.New(0, 58.66)),
        location + scale * (vector.New(0, 21.16)),
        location + scale * (vector.New(0, 21.16)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(0, 21.16)), location + scale * (vector.New(0, 21.16)),
        location + scale * (vector.New(4.05, 21.16)), location + scale * (vector.New(4.05, 21.16)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(4.05, 21.16)),
        location + scale * (vector.New(4.05, 21.16)),
        location + scale * (vector.New(4.05, 25.5)), location + scale * (vector.New(4.05, 25.5)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(4.05, 25.5)),
        location + scale * (vector.New(4.05, 25.5)),
        location + scale * (vector.New(4.55, 25.5)), location + scale * (vector.New(4.55, 25.5)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(4.55, 25.5)),
        location + scale * (vector.New(4.8566666666666665, 25.026666666666664)),
        location + scale * (vector.New(5.283333333333333, 24.419999999999995)),
        location + scale * (vector.New(5.83, 23.68)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(5.83, 23.68)),
        location + scale * (vector.New(6.383333333333333, 22.939999999999998)),
        location + scale * (vector.New(7.176666666666666, 22.276666666666667)),
        location + scale * (vector.New(8.21, 21.69)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(8.21, 21.69)),
        location + scale * (vector.New(9.25, 21.10333333333333)),
        location + scale * (vector.New(10.656666666666666, 20.809999999999995)),
        location + scale * (vector.New(12.43, 20.81)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(12.43, 20.81)),
        location + scale * (vector.New(14.723333333333331, 20.809999999999995)),
        location + scale * (vector.New(16.746666666666663, 21.383333333333333)),
        location + scale * (vector.New(18.5, 22.53)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(18.5, 22.53)),
        location + scale * (vector.New(20.25333333333333, 23.676666666666662)),
        location + scale * (vector.New(21.619999999999997, 25.30333333333333)),
        location + scale * (vector.New(22.6, 27.41)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(22.6, 27.41)),
        location + scale * (vector.New(23.586666666666666, 29.52333333333333)),
        location + scale * (vector.New(24.08, 32.00999999999999)), location + scale * (vector.New(24.08, 34.87)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(24.08, 34.87)),
        location + scale * (vector.New(24.08, 37.75666666666666)),
        location + scale * (vector.New(23.586666666666666, 40.25666666666666)),
        location + scale * (vector.New(22.6, 42.37)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(22.6, 42.37)),
        location + scale * (vector.New(21.619999999999997, 44.483333333333334)),
        location + scale * (vector.New(20.259999999999998, 46.11666666666667)),
        location + scale * (vector.New(18.52, 47.27)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(18.52, 47.27)),
        location + scale * (vector.New(16.779999999999998, 48.43)),
        location + scale * (vector.New(14.773333333333332, 49.01)), location + scale * (vector.New(12.5, 49.01)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(12.5, 49.01)),
        location + scale * (vector.New(10.746666666666666, 49.01)),
        location + scale * (vector.New(9.343333333333332, 48.71666666666667)),
        location + scale * (vector.New(8.29, 48.13)), col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(8.29, 48.13)),
        location + scale * (vector.New(7.2366666666666655, 47.54333333333334)),
        location + scale * (vector.New(6.426666666666666, 46.873333333333335)),
        location + scale * (vector.New(5.86, 46.12)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(5.86, 46.12)),
        location + scale * (vector.New(5.293333333333333, 45.36666666666666)),
        location + scale * (vector.New(4.8566666666666665, 44.74333333333333)),
        location + scale * (vector.New(4.55, 44.25)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(4.55, 44.25)),
        location + scale * (vector.New(4.55, 44.25)),
        location + scale * (vector.New(4.19, 44.25)), location + scale * (vector.New(4.19, 44.25)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(4.19, 44.25)),
        location + scale * (vector.New(4.19, 44.25)),
        location + scale * (vector.New(4.19, 58.66)), location + scale * (vector.New(4.19, 58.66)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(4.19, 58.66)),
        location + scale * (vector.New(4.19, 58.66)),
        location + scale * (vector.New(0, 58.66)),
        location + scale * (vector.New(0, 58.66)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(4.12, 34.8)),
        location + scale * (vector.New(4.12, 36.86)),
        location + scale * (vector.New(4.42, 38.67333333333333)),
        location + scale * (vector.New(5.02, 40.24)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(5.02, 40.24)),
        location + scale * (vector.New(5.626666666666666, 41.81333333333333)),
        location + scale * (vector.New(6.51, 43.04)),
        location + scale * (vector.New(7.67, 43.92)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(7.67, 43.92)),
        location + scale * (vector.New(8.83, 44.8)),
        location + scale * (vector.New(10.25, 45.24)),
        location + scale * (vector.New(11.93, 45.24)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(11.93, 45.24)),
        location + scale * (vector.New(13.683333333333334, 45.24)),
        location + scale * (vector.New(15.149999999999999, 44.77666666666667)),
        location + scale * (vector.New(16.33, 43.85)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(16.33, 43.85)),
        location + scale * (vector.New(17.50333333333333, 42.91666666666667)),
        location + scale * (vector.New(18.389999999999997, 41.66)), location + scale * (vector.New(18.99, 40.08)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(18.99, 40.08)),
        location + scale * (vector.New(19.59, 38.5)),
        location + scale * (vector.New(19.89, 36.739999999999995)),
        location + scale * (vector.New(19.89, 34.8)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(19.89, 34.8)),
        location + scale * (vector.New(19.89, 32.879999999999995)),
        location + scale * (vector.New(19.596666666666668, 31.15)), location + scale * (vector.New(19.01, 29.61)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(19.01, 29.61)),
        location + scale * (vector.New(18.423333333333332, 28.063333333333333)),
        location + scale * (vector.New(17.54, 26.836666666666666)), location + scale * (vector.New(16.36, 25.93)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(16.36, 25.93)),
        location + scale * (vector.New(15.186666666666666, 25.023333333333333)),
        location + scale * (vector.New(13.709999999999999, 24.57)), location + scale * (vector.New(11.93, 24.57)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(11.93, 24.57)),
        location + scale * (vector.New(10.23, 24.57)),
        location + scale * (vector.New(8.796666666666667, 25)),
        location + scale * (vector.New(7.63, 25.86)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(7.63, 25.86)),
        location + scale * (vector.New(6.469999999999999, 26.72)),
        location + scale * (vector.New(5.596666666666666, 27.916666666666664)),
        location + scale * (vector.New(5.01, 29.45)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(5.01, 29.45)),
        location + scale * (vector.New(4.416666666666666, 30.98333333333333)),
        location + scale * (vector.New(4.12, 32.766666666666666)), location + scale * (vector.New(4.12, 34.8)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(34.66, 12.07)),
        location + scale * (vector.New(34.66, 12.07)),
        location + scale * (vector.New(34.66, 48.44)),
        location + scale * (vector.New(34.66, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(34.66, 48.44)),
        location + scale * (vector.New(34.66, 48.44)),
        location + scale * (vector.New(30.47, 48.44)),
        location + scale * (vector.New(30.47, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(30.47, 48.44)),
        location + scale * (vector.New(30.47, 48.44)),
        location + scale * (vector.New(30.47, 12.07)),
        location + scale * (vector.New(30.47, 12.07)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(30.47, 12.07)),
        location + scale * (vector.New(30.47, 12.07)),
        location + scale * (vector.New(34.66, 12.07)),
        location + scale * (vector.New(34.66, 12.07)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(59.52, 37.29)),
        location + scale * (vector.New(59.52, 37.29)),
        location + scale * (vector.New(59.52, 21.16)),
        location + scale * (vector.New(59.52, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(59.52, 21.16)),
        location + scale * (vector.New(59.52, 21.16)),
        location + scale * (vector.New(63.71, 21.16)),
        location + scale * (vector.New(63.71, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(63.71, 21.16)),
        location + scale * (vector.New(63.71, 21.16)),
        location + scale * (vector.New(63.71, 48.44)),
        location + scale * (vector.New(63.71, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(63.71, 48.44)),
        location + scale * (vector.New(63.71, 48.44)),
        location + scale * (vector.New(59.52, 48.44)),
        location + scale * (vector.New(59.52, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(59.52, 48.44)),
        location + scale * (vector.New(59.52, 48.44)),
        location + scale * (vector.New(59.52, 43.82)),
        location + scale * (vector.New(59.52, 43.82)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(59.52, 43.82)),
        location + scale * (vector.New(59.52, 43.82)),
        location + scale * (vector.New(59.23, 43.82)),
        location + scale * (vector.New(59.23, 43.82)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(59.23, 43.82)),
        location + scale * (vector.New(58.589999999999996, 45.20666666666666)),
        location + scale * (vector.New(57.596666666666664, 46.38333333333333)),
        location + scale * (vector.New(56.25, 47.35)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(56.25, 47.35)),
        location + scale * (vector.New(54.90333333333333, 48.309999999999995)),
        location + scale * (vector.New(53.199999999999996, 48.78999999999999)),
        location + scale * (vector.New(51.14, 48.79)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(51.14, 48.79)),
        location + scale * (vector.New(49.43333333333333, 48.78999999999999)),
        location + scale * (vector.New(47.916666666666664, 48.416666666666664)),
        location + scale * (vector.New(46.59, 47.67)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(46.59, 47.67)),
        location + scale * (vector.New(45.263333333333335, 46.916666666666664)),
        location + scale * (vector.New(44.22333333333333, 45.779999999999994)),
        location + scale * (vector.New(43.47, 44.26)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(43.47, 44.26)),
        location + scale * (vector.New(42.709999999999994, 42.73333333333333)),
        location + scale * (vector.New(42.33, 40.809999999999995)), location + scale * (vector.New(42.33, 38.49)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(42.33, 38.49)),
        location + scale * (vector.New(42.33, 38.49)),
        location + scale * (vector.New(42.33, 21.16)),
        location + scale * (vector.New(42.33, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(42.33, 21.16)),
        location + scale * (vector.New(42.33, 21.16)),
        location + scale * (vector.New(46.52, 21.16)),
        location + scale * (vector.New(46.52, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(46.52, 21.16)),
        location + scale * (vector.New(46.52, 21.16)),
        location + scale * (vector.New(46.52, 38.21)),
        location + scale * (vector.New(46.52, 38.21)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(46.52, 38.21)),
        location + scale * (vector.New(46.52, 40.196666666666665)),
        location + scale * (vector.New(47.08, 41.78333333333333)), location + scale * (vector.New(48.2, 42.97)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(48.2, 42.97)),
        location + scale * (vector.New(49.31999999999999, 44.15)),
        location + scale * (vector.New(50.75, 44.74)),
        location + scale * (vector.New(52.49, 44.74)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(52.49, 44.74)),
        location + scale * (vector.New(53.53, 44.74)),
        location + scale * (vector.New(54.589999999999996, 44.47666666666667)),
        location + scale * (vector.New(55.67, 43.95)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(55.67, 43.95)),
        location + scale * (vector.New(56.75666666666666, 43.416666666666664)),
        location + scale * (vector.New(57.669999999999995, 42.599999999999994)),
        location + scale * (vector.New(58.41, 41.5)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(58.41, 41.5)),
        location + scale * (vector.New(59.15, 40.39333333333333)),
        location + scale * (vector.New(59.519999999999996, 38.99)), location + scale * (vector.New(59.52, 37.29)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(71.38, 48.44)),
        location + scale * (vector.New(71.38, 48.44)),
        location + scale * (vector.New(71.38, 21.16)),
        location + scale * (vector.New(71.38, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(71.38, 21.16)),
        location + scale * (vector.New(71.38, 21.16)),
        location + scale * (vector.New(75.43, 21.16)),
        location + scale * (vector.New(75.43, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(75.43, 21.16)),
        location + scale * (vector.New(75.43, 21.16)),
        location + scale * (vector.New(75.43, 25.43)),
        location + scale * (vector.New(75.43, 25.43)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(75.43, 25.43)),
        location + scale * (vector.New(75.43, 25.43)),
        location + scale * (vector.New(75.78, 25.43)),
        location + scale * (vector.New(75.78, 25.43)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(75.78, 25.43)),
        location + scale * (vector.New(76.34666666666666, 23.97)),
        location + scale * (vector.New(77.26333333333332, 22.836666666666666)),
        location + scale * (vector.New(78.53, 22.03)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(78.53, 22.03)),
        location + scale * (vector.New(79.79666666666667, 21.216666666666665)),
        location + scale * (vector.New(81.32, 20.809999999999995)), location + scale * (vector.New(83.1, 20.81)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(83.1, 20.81)),
        location + scale * (vector.New(84.89999999999999, 20.809999999999995)),
        location + scale * (vector.New(86.39999999999999, 21.216666666666665)),
        location + scale * (vector.New(87.6, 22.03)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(87.6, 22.03)),
        location + scale * (vector.New(88.8, 22.836666666666666)),
        location + scale * (vector.New(89.73666666666666, 23.97)), location + scale * (vector.New(90.41, 25.43)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(90.41, 25.43)),
        location + scale * (vector.New(90.41, 25.43)),
        location + scale * (vector.New(90.7, 25.43)),
        location + scale * (vector.New(90.7, 25.43)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(90.7, 25.43)),
        location + scale * (vector.New(91.39333333333333, 24.016666666666666)),
        location + scale * (vector.New(92.44, 22.89333333333333)), location + scale * (vector.New(93.84, 22.06)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(93.84, 22.06)),
        location + scale * (vector.New(95.23333333333333, 21.226666666666663)),
        location + scale * (vector.New(96.90666666666667, 20.809999999999995)),
        location + scale * (vector.New(98.86, 20.81)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(98.86, 20.81)),
        location + scale * (vector.New(101.3, 20.809999999999995)),
        location + scale * (vector.New(103.29666666666665, 21.569999999999997)),
        location + scale * (vector.New(104.85, 23.09)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(104.85, 23.09)),
        location + scale * (vector.New(106.39666666666665, 24.61)),
        location + scale * (vector.New(107.16999999999999, 26.973333333333333)),
        location + scale * (vector.New(107.17, 30.18)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(107.17, 30.18)),
        location + scale * (vector.New(107.17, 30.18)),
        location + scale * (vector.New(107.17, 48.44)),
        location + scale * (vector.New(107.17, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(107.17, 48.44)),
        location + scale * (vector.New(107.17, 48.44)),
        location + scale * (vector.New(102.98, 48.44)),
        location + scale * (vector.New(102.98, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(102.98, 48.44)),
        location + scale * (vector.New(102.98, 48.44)),
        location + scale * (vector.New(102.98, 30.18)),
        location + scale * (vector.New(102.98, 30.18)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(102.98, 30.18)),
        location + scale * (vector.New(102.98, 28.173333333333332)),
        location + scale * (vector.New(102.43, 26.736666666666665)), location + scale * (vector.New(101.33, 25.87)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(101.33, 25.87)),
        location + scale * (vector.New(100.22999999999999, 25.00333333333333)),
        location + scale * (vector.New(98.93333333333334, 24.57)), location + scale * (vector.New(97.44, 24.57)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(97.44, 24.57)),
        location + scale * (vector.New(95.52666666666666, 24.57)),
        location + scale * (vector.New(94.04333333333332, 25.15)), location + scale * (vector.New(92.99, 26.31)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(92.99, 26.31)),
        location + scale * (vector.New(91.93666666666667, 27.46333333333333)),
        location + scale * (vector.New(91.41, 28.919999999999998)), location + scale * (vector.New(91.41, 30.68)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(91.41, 30.68)),
        location + scale * (vector.New(91.41, 30.68)),
        location + scale * (vector.New(91.41, 48.44)),
        location + scale * (vector.New(91.41, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(91.41, 48.44)),
        location + scale * (vector.New(91.41, 48.44)),
        location + scale * (vector.New(87.14, 48.44)),
        location + scale * (vector.New(87.14, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(87.14, 48.44)),
        location + scale * (vector.New(87.14, 48.44)),
        location + scale * (vector.New(87.14, 29.76)),
        location + scale * (vector.New(87.14, 29.76)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(87.14, 29.76)),
        location + scale * (vector.New(87.14, 28.206666666666663)),
        location + scale * (vector.New(86.64, 26.953333333333333)), location + scale * (vector.New(85.64, 26)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(85.64, 26)),
        location + scale * (vector.New(84.63333333333333, 25.046666666666667)),
        location + scale * (vector.New(83.33666666666666, 24.57)), location + scale * (vector.New(81.75, 24.57)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(81.75, 24.57)),
        location + scale * (vector.New(80.65666666666667, 24.57)),
        location + scale * (vector.New(79.64, 24.86)),
        location + scale * (vector.New(78.7, 25.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(78.7, 25.44)),
        location + scale * (vector.New(77.76, 26.02)),
        location + scale * (vector.New(77.00333333333333, 26.82333333333333)),
        location + scale * (vector.New(76.43, 27.85)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(76.43, 27.85)),
        location + scale * (vector.New(75.85666666666665, 28.876666666666665)),
        location + scale * (vector.New(75.57, 30.056666666666665)), location + scale * (vector.New(75.57, 31.39)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(75.57, 31.39)),
        location + scale * (vector.New(75.57, 31.39)),
        location + scale * (vector.New(75.57, 48.44)),
        location + scale * (vector.New(75.57, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(75.57, 48.44)),
        location + scale * (vector.New(75.57, 48.44)),
        location + scale * (vector.New(71.38, 48.44)),
        location + scale * (vector.New(71.38, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(125.92, 49.01)),
        location + scale * (vector.New(123.46, 49.01)),
        location + scale * (vector.New(121.30333333333333, 48.42333333333333)),
        location + scale * (vector.New(119.45, 47.25)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(119.45, 47.25)),
        location + scale * (vector.New(117.59666666666666, 46.07666666666667)),
        location + scale * (vector.New(116.15333333333334, 44.43666666666667)),
        location + scale * (vector.New(115.12, 42.33)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(115.12, 42.33)),
        location + scale * (vector.New(114.08666666666666, 40.22333333333333)),
        location + scale * (vector.New(113.57, 37.76)), location + scale * (vector.New(113.57, 34.94)), col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(113.57, 34.94)),
        location + scale * (vector.New(113.57, 32.099999999999994)),
        location + scale * (vector.New(114.08666666666666, 29.619999999999997)),
        location + scale * (vector.New(115.12, 27.5)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(115.12, 27.5)),
        location + scale * (vector.New(116.15333333333334, 25.386666666666663)),
        location + scale * (vector.New(117.59666666666666, 23.743333333333332)),
        location + scale * (vector.New(119.45, 22.57)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(119.45, 22.57)),
        location + scale * (vector.New(121.30333333333333, 21.396666666666665)),
        location + scale * (vector.New(123.46, 20.809999999999995)), location + scale * (vector.New(125.92, 20.81)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(125.92, 20.81)),
        location + scale * (vector.New(128.38666666666666, 20.809999999999995)),
        location + scale * (vector.New(130.54666666666665, 21.396666666666665)),
        location + scale * (vector.New(132.4, 22.57)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(132.4, 22.57)),
        location + scale * (vector.New(134.24666666666664, 23.743333333333332)),
        location + scale * (vector.New(135.68999999999997, 25.386666666666663)),
        location + scale * (vector.New(136.73, 27.5)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(136.73, 27.5)),
        location + scale * (vector.New(137.76333333333332, 29.619999999999997)),
        location + scale * (vector.New(138.28, 32.099999999999994)), location + scale * (vector.New(138.28, 34.94)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(138.28, 34.94)),
        location + scale * (vector.New(138.28, 37.76)),
        location + scale * (vector.New(137.76333333333332, 40.22333333333333)),
        location + scale * (vector.New(136.73, 42.33)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(136.73, 42.33)),
        location + scale * (vector.New(135.68999999999997, 44.43666666666667)),
        location + scale * (vector.New(134.24666666666664, 46.07666666666667)),
        location + scale * (vector.New(132.4, 47.25)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(132.4, 47.25)),
        location + scale * (vector.New(130.54666666666665, 48.42333333333333)),
        location + scale * (vector.New(128.38666666666666, 49.01)),
        location + scale * (vector.New(125.92, 49.01)), col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(125.92, 45.24)),
        location + scale * (vector.New(127.79333333333332, 45.24)),
        location + scale * (vector.New(129.33333333333331, 44.76)), location + scale * (vector.New(130.54, 43.8)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(130.54, 43.8)),
        location + scale * (vector.New(131.74666666666664, 42.846666666666664)),
        location + scale * (vector.New(132.64, 41.58666666666666)), location + scale * (vector.New(133.22, 40.02)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(133.22, 40.02)),
        location + scale * (vector.New(133.8, 38.459999999999994)),
        location + scale * (vector.New(134.09, 36.766666666666666)), location + scale * (vector.New(134.09, 34.94)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(134.09, 34.94)),
        location + scale * (vector.New(134.09, 33.12)),
        location + scale * (vector.New(133.8, 31.423333333333332)),
        location + scale * (vector.New(133.22, 29.85)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(133.22, 29.85)),
        location + scale * (vector.New(132.64, 28.276666666666664)),
        location + scale * (vector.New(131.74666666666664, 27.00333333333333)),
        location + scale * (vector.New(130.54, 26.03)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(130.54, 26.03)),
        location + scale * (vector.New(129.33333333333331, 25.056666666666665)),
        location + scale * (vector.New(127.79333333333332, 24.57)), location + scale * (vector.New(125.92, 24.57)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(125.92, 24.57)),
        location + scale * (vector.New(124.05333333333333, 24.57)),
        location + scale * (vector.New(122.51666666666667, 25.056666666666665)),
        location + scale * (vector.New(121.31, 26.03)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(121.31, 26.03)),
        location + scale * (vector.New(120.10333333333332, 27.00333333333333)),
        location + scale * (vector.New(119.20999999999998, 28.276666666666664)),
        location + scale * (vector.New(118.63, 29.85)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(118.63, 29.85)),
        location + scale * (vector.New(118.04999999999998, 31.423333333333332)),
        location + scale * (vector.New(117.75999999999999, 33.12)), location + scale * (vector.New(117.76, 34.94)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(117.76, 34.94)),
        location + scale * (vector.New(117.75999999999999, 36.766666666666666)),
        location + scale * (vector.New(118.04999999999998, 38.459999999999994)),
        location + scale * (vector.New(118.63, 40.02)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(118.63, 40.02)),
        location + scale * (vector.New(119.20999999999998, 41.58666666666666)),
        location + scale * (vector.New(120.10333333333332, 42.846666666666664)),
        location + scale * (vector.New(121.31, 43.8)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(121.31, 43.8)),
        location + scale * (vector.New(122.51666666666667, 44.76)),
        location + scale * (vector.New(124.05333333333333, 45.24)), location + scale * (vector.New(125.92, 45.24)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(155.68, 59.23)),
        location + scale * (vector.New(153.66, 59.23)),
        location + scale * (vector.New(151.92000000000002, 58.97333333333333)),
        location + scale * (vector.New(150.46, 58.46)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(150.46, 58.46)),
        location + scale * (vector.New(149.00666666666666, 57.94666666666666)),
        location + scale * (vector.New(147.79666666666665, 57.273333333333326)),
        location + scale * (vector.New(146.83, 56.44)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(146.83, 56.44)),
        location + scale * (vector.New(145.86333333333332, 55.599999999999994)),
        location + scale * (vector.New(145.09666666666664, 54.70666666666666)),
        location + scale * (vector.New(144.53, 53.76)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(144.53, 53.76)),
        location + scale * (vector.New(144.53, 53.76)),
        location + scale * (vector.New(147.87, 51.42)),
        location + scale * (vector.New(147.87, 51.42)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(147.87, 51.42)),
        location + scale * (vector.New(148.25, 51.92)),
        location + scale * (vector.New(148.73, 52.49)),
        location + scale * (vector.New(149.31, 53.13)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(149.31, 53.13)),
        location + scale * (vector.New(149.89, 53.776666666666664)),
        location + scale * (vector.New(150.68666666666667, 54.339999999999996)),
        location + scale * (vector.New(151.7, 54.82)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(151.7, 54.82)),
        location + scale * (vector.New(152.70666666666665, 55.3)),
        location + scale * (vector.New(154.03333333333333, 55.53999999999999)),
        location + scale * (vector.New(155.68, 55.54)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(155.68, 55.54)),
        location + scale * (vector.New(157.88, 55.53999999999999)),
        location + scale * (vector.New(159.69666666666666, 55.00666666666666)),
        location + scale * (vector.New(161.13, 53.94)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(161.13, 53.94)),
        location + scale * (vector.New(162.56333333333333, 52.87333333333333)),
        location + scale * (vector.New(163.27999999999997, 51.20333333333333)),
        location + scale * (vector.New(163.28, 48.93)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(163.28, 48.93)),
        location + scale * (vector.New(163.28, 48.93)),
        location + scale * (vector.New(163.28, 43.39)),
        location + scale * (vector.New(163.28, 43.39)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(163.28, 43.39)),
        location + scale * (vector.New(163.28, 43.39)),
        location + scale * (vector.New(162.93, 43.39)),
        location + scale * (vector.New(162.93, 43.39)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(162.93, 43.39)),
        location + scale * (vector.New(162.61666666666667, 43.89)),
        location + scale * (vector.New(162.18, 44.50333333333333)), location + scale * (vector.New(161.62, 45.23)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(161.62, 45.23)),
        location + scale * (vector.New(161.06, 45.95666666666666)),
        location + scale * (vector.New(160.25666666666666, 46.60333333333333)),
        location + scale * (vector.New(159.21, 47.17)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(159.21, 47.17)),
        location + scale * (vector.New(158.15666666666667, 47.72999999999999)),
        location + scale * (vector.New(156.74333333333334, 48.00999999999999)),
        location + scale * (vector.New(154.97, 48.01)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(154.97, 48.01)),
        location + scale * (vector.New(152.76999999999998, 48.00999999999999)),
        location + scale * (vector.New(150.79666666666665, 47.489999999999995)),
        location + scale * (vector.New(149.05, 46.45)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(149.05, 46.45)),
        location + scale * (vector.New(147.30333333333334, 45.41)),
        location + scale * (vector.New(145.92333333333335, 43.89333333333333)),
        location + scale * (vector.New(144.91, 41.9)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(144.91, 41.9)),
        location + scale * (vector.New(143.89666666666665, 39.91333333333333)),
        location + scale * (vector.New(143.39, 37.5)), location + scale * (vector.New(143.39, 34.66)), col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(143.39, 34.66)),
        location + scale * (vector.New(143.39, 31.866666666666664)),
        location + scale * (vector.New(143.88333333333333, 29.43)), location + scale * (vector.New(144.87, 27.35)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(144.87, 27.35)),
        location + scale * (vector.New(145.85, 25.276666666666664)),
        location + scale * (vector.New(147.21666666666667, 23.666666666666664)),
        location + scale * (vector.New(148.97, 22.52)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(148.97, 22.52)),
        location + scale * (vector.New(150.72333333333333, 21.379999999999995)),
        location + scale * (vector.New(152.74666666666667, 20.809999999999995)),
        location + scale * (vector.New(155.04, 20.81)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(155.04, 20.81)),
        location + scale * (vector.New(156.82, 20.809999999999995)),
        location + scale * (vector.New(158.23333333333335, 21.10333333333333)),
        location + scale * (vector.New(159.28, 21.69)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(159.28, 21.69)),
        location + scale * (vector.New(160.32666666666665, 22.276666666666667)),
        location + scale * (vector.New(161.13, 22.939999999999998)), location + scale * (vector.New(161.69, 23.68)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(161.69, 23.68)),
        location + scale * (vector.New(162.25666666666666, 24.419999999999995)),
        location + scale * (vector.New(162.69333333333333, 25.026666666666664)),
        location + scale * (vector.New(163, 25.5)), col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(163, 25.5)),
        location + scale * (vector.New(163, 25.5)),
        location + scale * (vector.New(163.42, 25.5)), location + scale * (vector.New(163.42, 25.5)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(163.42, 25.5)),
        location + scale * (vector.New(163.42, 25.5)),
        location + scale * (vector.New(163.42, 21.16)),
        location + scale * (vector.New(163.42, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(163.42, 21.16)),
        location + scale * (vector.New(163.42, 21.16)),
        location + scale * (vector.New(167.47, 21.16)),
        location + scale * (vector.New(167.47, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(167.47, 21.16)),
        location + scale * (vector.New(167.47, 21.16)),
        location + scale * (vector.New(167.47, 49.22)),
        location + scale * (vector.New(167.47, 49.22)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(167.47, 49.22)),
        location + scale * (vector.New(167.47, 51.559999999999995)),
        location + scale * (vector.New(166.94, 53.46666666666666)), location + scale * (vector.New(165.88, 54.94)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(165.88, 54.94)),
        location + scale * (vector.New(164.82, 56.419999999999995)),
        location + scale * (vector.New(163.39999999999998, 57.50333333333333)),
        location + scale * (vector.New(161.62, 58.19)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(161.62, 58.19)),
        location + scale * (vector.New(159.83999999999997, 58.883333333333326)),
        location + scale * (vector.New(157.85999999999999, 59.23)),
        location + scale * (vector.New(155.68, 59.23)), col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(155.54, 44.25)),
        location + scale * (vector.New(157.22, 44.25)),
        location + scale * (vector.New(158.64, 43.86333333333333)),
        location + scale * (vector.New(159.8, 43.09)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(159.8, 43.09)),
        location + scale * (vector.New(160.95999999999998, 42.32333333333333)),
        location + scale * (vector.New(161.8433333333333, 41.21666666666667)),
        location + scale * (vector.New(162.45, 39.77)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(162.45, 39.77)),
        location + scale * (vector.New(163.04999999999998, 38.33)),
        location + scale * (vector.New(163.35, 36.60333333333333)), location + scale * (vector.New(163.35, 34.59)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(163.35, 34.59)),
        location + scale * (vector.New(163.35, 32.623333333333335)),
        location + scale * (vector.New(163.05333333333334, 30.89)), location + scale * (vector.New(162.46, 29.39)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(162.46, 29.39)),
        location + scale * (vector.New(161.87333333333333, 27.883333333333333)),
        location + scale * (vector.New(161, 26.703333333333333)), location + scale * (vector.New(159.84, 25.85)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(159.84, 25.85)),
        location + scale * (vector.New(158.68, 24.996666666666666)),
        location + scale * (vector.New(157.24666666666667, 24.57)), location + scale * (vector.New(155.54, 24.57)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(155.54, 24.57)),
        location + scale * (vector.New(153.76666666666665, 24.57)),
        location + scale * (vector.New(152.29, 25.02)),
        location + scale * (vector.New(151.11, 25.92)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(151.11, 25.92)),
        location + scale * (vector.New(149.93, 26.82)),
        location + scale * (vector.New(149.04666666666668, 28.03)),
        location + scale * (vector.New(148.46, 29.55)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(148.46, 29.55)),
        location + scale * (vector.New(147.88, 31.063333333333333)),
        location + scale * (vector.New(147.59, 32.74333333333333)), location + scale * (vector.New(147.59, 34.59)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(147.59, 34.59)),
        location + scale * (vector.New(147.59, 36.483333333333334)),
        location + scale * (vector.New(147.88666666666666, 38.153333333333336)),
        location + scale * (vector.New(148.48, 39.6)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(148.48, 39.6)),
        location + scale * (vector.New(149.07999999999998, 41.05333333333333)),
        location + scale * (vector.New(149.97, 42.19)), location + scale * (vector.New(151.15, 43.01)), col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(151.15, 43.01)),
        location + scale * (vector.New(152.32333333333332, 43.836666666666666)),
        location + scale * (vector.New(153.78666666666666, 44.25)), location + scale * (vector.New(155.54, 44.25)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(192.33, 37.29)),
        location + scale * (vector.New(192.33, 37.29)),
        location + scale * (vector.New(192.33, 21.16)),
        location + scale * (vector.New(192.33, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(192.33, 21.16)),
        location + scale * (vector.New(192.33, 21.16)),
        location + scale * (vector.New(196.52, 21.16)),
        location + scale * (vector.New(196.52, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(196.52, 21.16)),
        location + scale * (vector.New(196.52, 21.16)),
        location + scale * (vector.New(196.52, 48.44)),
        location + scale * (vector.New(196.52, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(196.52, 48.44)),
        location + scale * (vector.New(196.52, 48.44)),
        location + scale * (vector.New(192.33, 48.44)),
        location + scale * (vector.New(192.33, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(192.33, 48.44)),
        location + scale * (vector.New(192.33, 48.44)),
        location + scale * (vector.New(192.33, 43.82)),
        location + scale * (vector.New(192.33, 43.82)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(192.33, 43.82)),
        location + scale * (vector.New(192.33, 43.82)),
        location + scale * (vector.New(192.05, 43.82)),
        location + scale * (vector.New(192.05, 43.82)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(192.05, 43.82)),
        location + scale * (vector.New(191.41, 45.20666666666666)),
        location + scale * (vector.New(190.41333333333333, 46.38333333333333)),
        location + scale * (vector.New(189.06, 47.35)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(189.06, 47.35)),
        location + scale * (vector.New(187.7133333333333, 48.309999999999995)),
        location + scale * (vector.New(186.01, 48.78999999999999)), location + scale * (vector.New(183.95, 48.79)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(183.95, 48.79)),
        location + scale * (vector.New(182.2433333333333, 48.78999999999999)),
        location + scale * (vector.New(180.72666666666663, 48.416666666666664)),
        location + scale * (vector.New(179.4, 47.67)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(179.4, 47.67)),
        location + scale * (vector.New(178.07333333333332, 46.916666666666664)),
        location + scale * (vector.New(177.03333333333333, 45.779999999999994)),
        location + scale * (vector.New(176.28, 44.26)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(176.28, 44.26)),
        location + scale * (vector.New(175.51999999999998, 42.73333333333333)),
        location + scale * (vector.New(175.14, 40.809999999999995)), location + scale * (vector.New(175.14, 38.49)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(175.14, 38.49)),
        location + scale * (vector.New(175.14, 38.49)),
        location + scale * (vector.New(175.14, 21.16)),
        location + scale * (vector.New(175.14, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(175.14, 21.16)),
        location + scale * (vector.New(175.14, 21.16)),
        location + scale * (vector.New(179.33, 21.16)),
        location + scale * (vector.New(179.33, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(179.33, 21.16)),
        location + scale * (vector.New(179.33, 21.16)),
        location + scale * (vector.New(179.33, 38.21)),
        location + scale * (vector.New(179.33, 38.21)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(179.33, 38.21)),
        location + scale * (vector.New(179.33, 40.196666666666665)),
        location + scale * (vector.New(179.89, 41.78333333333333)), location + scale * (vector.New(181.01, 42.97)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(181.01, 42.97)),
        location + scale * (vector.New(182.13, 44.15)),
        location + scale * (vector.New(183.56, 44.74)),
        location + scale * (vector.New(185.3, 44.74)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(185.3, 44.74)),
        location + scale * (vector.New(186.34, 44.74)),
        location + scale * (vector.New(187.40333333333334, 44.47666666666667)),
        location + scale * (vector.New(188.49, 43.95)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(188.49, 43.95)),
        location + scale * (vector.New(189.57, 43.416666666666664)),
        location + scale * (vector.New(190.48000000000002, 42.599999999999994)),
        location + scale * (vector.New(191.22, 41.5)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(191.22, 41.5)),
        location + scale * (vector.New(191.95999999999998, 40.39333333333333)),
        location + scale * (vector.New(192.32999999999998, 38.99)), location + scale * (vector.New(192.33, 37.29)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(224.64, 21.16)),
        location + scale * (vector.New(224.43333333333334, 19.366666666666667)),
        location + scale * (vector.New(223.57, 17.97)), location + scale * (vector.New(222.05, 16.97)), col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(222.05, 16.97)),
        location + scale * (vector.New(220.53666666666663, 15.976666666666667)),
        location + scale * (vector.New(218.67999999999998, 15.48)), location + scale * (vector.New(216.48, 15.48)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(216.48, 15.48)),
        location + scale * (vector.New(214.86666666666665, 15.48)),
        location + scale * (vector.New(213.45999999999998, 15.74)), location + scale * (vector.New(212.26, 16.26)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(212.26, 16.26)),
        location + scale * (vector.New(211.06, 16.78666666666667)),
        location + scale * (vector.New(210.12333333333333, 17.503333333333334)),
        location + scale * (vector.New(209.45, 18.41)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(209.45, 18.41)),
        location + scale * (vector.New(208.7833333333333, 19.323333333333334)),
        location + scale * (vector.New(208.44999999999996, 20.36)), location + scale * (vector.New(208.45, 21.52)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(208.45, 21.52)),
        location + scale * (vector.New(208.44999999999996, 22.493333333333332)),
        location + scale * (vector.New(208.6833333333333, 23.323333333333334)),
        location + scale * (vector.New(209.15, 24.01)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(209.15, 24.01)),
        location + scale * (vector.New(209.61666666666665, 24.703333333333333)),
        location + scale * (vector.New(210.21999999999997, 25.279999999999998)),
        location + scale * (vector.New(210.96, 25.74)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(210.96, 25.74)),
        location + scale * (vector.New(211.69333333333333, 26.19333333333333)),
        location + scale * (vector.New(212.45999999999998, 26.566666666666666)),
        location + scale * (vector.New(213.26, 26.86)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(213.26, 26.86)),
        location + scale * (vector.New(214.06666666666666, 27.146666666666665)),
        location + scale * (vector.New(214.80666666666664, 27.379999999999995)),
        location + scale * (vector.New(215.48, 27.56)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(215.48, 27.56)),
        location + scale * (vector.New(215.48, 27.56)),
        location + scale * (vector.New(219.18, 28.55)),
        location + scale * (vector.New(219.18, 28.55)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(219.18, 28.55)),
        location + scale * (vector.New(220.12666666666667, 28.796666666666667)),
        location + scale * (vector.New(221.18333333333334, 29.14)), location + scale * (vector.New(222.35, 29.58)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(222.35, 29.58)),
        location + scale * (vector.New(223.51, 30.019999999999996)),
        location + scale * (vector.New(224.62666666666664, 30.616666666666664)),
        location + scale * (vector.New(225.7, 31.37)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(225.7, 31.37)),
        location + scale * (vector.New(226.7733333333333, 32.11666666666667)),
        location + scale * (vector.New(227.66, 33.07666666666667)), location + scale * (vector.New(228.36, 34.25)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(228.36, 34.25)),
        location + scale * (vector.New(229.05333333333334, 35.42333333333333)),
        location + scale * (vector.New(229.4, 36.86333333333333)), location + scale * (vector.New(229.4, 38.57)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(229.4, 38.57)),
        location + scale * (vector.New(229.4, 40.53)),
        location + scale * (vector.New(228.89, 42.30333333333333)),
        location + scale * (vector.New(227.87, 43.89)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(227.87, 43.89)),
        location + scale * (vector.New(226.8433333333333, 45.47666666666667)),
        location + scale * (vector.New(225.34999999999997, 46.736666666666665)),
        location + scale * (vector.New(223.39, 47.67)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(223.39, 47.67)),
        location + scale * (vector.New(221.42999999999995, 48.61)),
        location + scale * (vector.New(219.05333333333328, 49.08)), location + scale * (vector.New(216.26, 49.08)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(216.26, 49.08)),
        location + scale * (vector.New(213.65999999999997, 49.08)),
        location + scale * (vector.New(211.40999999999997, 48.66)), location + scale * (vector.New(209.51, 47.82)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(209.51, 47.82)),
        location + scale * (vector.New(207.60999999999996, 46.98)),
        location + scale * (vector.New(206.11666666666665, 45.806666666666665)),
        location + scale * (vector.New(205.03, 44.3)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(205.03, 44.3)),
        location + scale * (vector.New(203.95, 42.8)),
        location + scale * (vector.New(203.33999999999997, 41.05333333333333)),
        location + scale * (vector.New(203.2, 39.06)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(203.2, 39.06)),
        location + scale * (vector.New(203.2, 39.06)),
        location + scale * (vector.New(207.74, 39.06)),
        location + scale * (vector.New(207.74, 39.06)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(207.74, 39.06)),
        location + scale * (vector.New(207.85999999999999, 40.43333333333333)),
        location + scale * (vector.New(208.32666666666665, 41.56666666666666)),
        location + scale * (vector.New(209.14, 42.46)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(209.14, 42.46)),
        location + scale * (vector.New(209.94666666666666, 43.353333333333325)),
        location + scale * (vector.New(210.9733333333333, 44.016666666666666)),
        location + scale * (vector.New(212.22, 44.45)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(212.22, 44.45)),
        location + scale * (vector.New(213.4733333333333, 44.88333333333333)),
        location + scale * (vector.New(214.82, 45.1)), location + scale * (vector.New(216.26, 45.1)), col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(216.26, 45.1)),
        location + scale * (vector.New(217.94666666666666, 45.1)),
        location + scale * (vector.New(219.45666666666665, 44.82333333333334)),
        location + scale * (vector.New(220.79, 44.27)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(220.79, 44.27)),
        location + scale * (vector.New(222.13, 43.723333333333336)),
        location + scale * (vector.New(223.19, 42.95666666666666)), location + scale * (vector.New(223.97, 41.97)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(223.97, 41.97)),
        location + scale * (vector.New(224.74999999999997, 40.97666666666666)),
        location + scale * (vector.New(225.13999999999996, 39.81666666666666)),
        location + scale * (vector.New(225.14, 38.49)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(225.14, 38.49)),
        location + scale * (vector.New(225.13999999999996, 37.28333333333333)),
        location + scale * (vector.New(224.80333333333328, 36.30333333333333)),
        location + scale * (vector.New(224.13, 35.55)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(224.13, 35.55)),
        location + scale * (vector.New(223.45666666666665, 34.78999999999999)),
        location + scale * (vector.New(222.57, 34.17333333333333)), location + scale * (vector.New(221.47, 33.7)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(221.47, 33.7)),
        location + scale * (vector.New(220.36999999999998, 33.22666666666667)),
        location + scale * (vector.New(219.17999999999998, 32.81333333333333)),
        location + scale * (vector.New(217.9, 32.46)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(217.9, 32.46)),
        location + scale * (vector.New(217.9, 32.46)),
        location + scale * (vector.New(213.42, 31.18)),
        location + scale * (vector.New(213.42, 31.18)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(213.42, 31.18)),
        location + scale * (vector.New(210.57999999999998, 30.36)),
        location + scale * (vector.New(208.33333333333331, 29.19333333333333)),
        location + scale * (vector.New(206.68, 27.68)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(206.68, 27.68)),
        location + scale * (vector.New(205.01999999999998, 26.166666666666664)),
        location + scale * (vector.New(204.19, 24.18333333333333)), location + scale * (vector.New(204.19, 21.73)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(204.19, 21.73)),
        location + scale * (vector.New(204.19, 19.696666666666665)),
        location + scale * (vector.New(204.74333333333334, 17.919999999999998)),
        location + scale * (vector.New(205.85, 16.4)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(205.85, 16.4)),
        location + scale * (vector.New(206.95666666666665, 14.879999999999999)),
        location + scale * (vector.New(208.44666666666663, 13.696666666666665)),
        location + scale * (vector.New(210.32, 12.85)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(210.32, 12.85)),
        location + scale * (vector.New(212.19999999999996, 12.003333333333334)),
        location + scale * (vector.New(214.29999999999995, 11.58)), location + scale * (vector.New(216.62, 11.58)),
        col,
        thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(216.62, 11.58)),
        location + scale * (vector.New(218.95999999999998, 11.58)),
        location + scale * (vector.New(221.04333333333332, 11.996666666666666)),
        location + scale * (vector.New(222.87, 12.83)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(222.87, 12.83)),
        location + scale * (vector.New(224.68999999999997, 13.663333333333334)),
        location + scale * (vector.New(226.13666666666666, 14.803333333333333)),
        location + scale * (vector.New(227.21, 16.25)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(227.21, 16.25)),
        location + scale * (vector.New(228.2833333333333, 17.689999999999998)),
        location + scale * (vector.New(228.84999999999997, 19.326666666666668)),
        location + scale * (vector.New(228.91, 21.16)),
        col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(228.91, 21.16)),
        location + scale * (vector.New(228.91, 21.16)),
        location + scale * (vector.New(224.64, 21.16)),
        location + scale * (vector.New(224.64, 21.16)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(238.14, 12.07)),
        location + scale * (vector.New(238.14, 12.07)),
        location + scale * (vector.New(248.93, 42.68)),
        location + scale * (vector.New(248.93, 42.68)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(248.93, 42.68)),
        location + scale * (vector.New(248.93, 42.68)),
        location + scale * (vector.New(249.36, 42.68)),
        location + scale * (vector.New(249.36, 42.68)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(249.36, 42.68)),
        location + scale * (vector.New(249.36, 42.68)),
        location + scale * (vector.New(260.16, 12.07)),
        location + scale * (vector.New(260.16, 12.07)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(260.16, 12.07)),
        location + scale * (vector.New(260.16, 12.07)),
        location + scale * (vector.New(264.77, 12.07)),
        location + scale * (vector.New(264.77, 12.07)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(264.77, 12.07)),
        location + scale * (vector.New(264.77, 12.07)),
        location + scale * (vector.New(251.42, 48.44)),
        location + scale * (vector.New(251.42, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(251.42, 48.44)),
        location + scale * (vector.New(251.42, 48.44)),
        location + scale * (vector.New(246.88, 48.44)),
        location + scale * (vector.New(246.88, 48.44)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(246.88, 48.44)),
        location + scale * (vector.New(246.88, 48.44)),
        location + scale * (vector.New(233.52, 12.07)),
        location + scale * (vector.New(233.52, 12.07)), col, thickness)
    partialBezierCubic(ctx, t0, t1, location + scale * (vector.New(233.52, 12.07)),
        location + scale * (vector.New(233.52, 12.07)),
        location + scale * (vector.New(238.14, 12.07)),
        location + scale * (vector.New(238.14, 12.07)), col, thickness)
end

---Simplified version of de Casteljau's algorithm from [Stack Overflow](https://stackoverflow.com/questions/878862/drawing-part-of-a-bézier-curve-by-reusing-a-basic-bézier-curve-function).
---@param ctx ImDrawListPtr
---@param t0 number
---@param t1 number
---@param p1 Vector2
---@param p2 Vector2
---@param p3 Vector2
---@param p4 Vector2
---@param col integer
---@param thickness number
function partialBezierCubic(ctx, t0, t1, p1, p2, p3, p4, col, thickness)
    local u0 = 1.0 - t0
    local u1 = 1.0 - t1

    local qa = p1 * u0 * u0 + p2 * 2 * t0 * u0 + p3 * t0 * t0
    local qb = p1 * u1 * u1 + p2 * 2 * t1 * u1 + p3 * t1 * t1
    local qc = p2 * u0 * u0 + p2 * 2 * t0 * u0 + p4 * t0 * t0
    local qd = p2 * u1 * u1 + p2 * 2 * t1 * u1 + p4 * t1 * t1

    local np1 = qa * u0 + qc * t0
    local np2 = qa * u1 + qc * t1
    local np3 = qb * u0 + qd * t0
    local np4 = qb * u1 + qd * t1

    ctx.AddBezierCubic(np1, np2, np3, np4, col, thickness)
end
