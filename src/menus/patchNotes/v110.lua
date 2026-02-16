function showPatchNotesV110(lc, rc)
    local bugFixes = {
        'Fixed issues where stills would incorrectly displace notes.',
        'Fixed swap/negate buttons not working properly.',
    }

    local newFeatures = {
        'Added Select by Chord Size.',
        'Now allows displace note/flicker to be linearly interpolated.',
        'Stills now only require one undo instead of two.',
        'New Still mode: still per note group, which drastically speeds up still production.',
        'Two new exponential modes: start/end and distance-based algorithms.',
        'Added hotkeys to quickly swap, negate, and reset certain parameters.',
        'Added notifications to all features.',
        'Copy and paste now supports bookmarks and timing lines.',
        'New setting was added to allow you to ignore notes outside the current TG.',
    }

    showPatchNotesElement('v1.1.0', drawV110, 129, { lc, rc }, bugFixes, newFeatures)
end

---Draws v110 on screen, with dimensions = scale * [129,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param thickness integer
function drawV110(ctx, location, scale, thickness)
    location = location - vector.New(64.5, 24) * scale
    local lightnessAdjust = (state.UnixTime % 2400) / 1200 * math.pi
    local colFn = function(x)
        return color.vrgbaToUint(color.hslaToRgba(x + 200, 1, math.sin(lightnessAdjust + x / 20) / 5 + 0.67, 1))
    end
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), colFn(14.35), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), colFn(10.09), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16), colFn(0), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), colFn(4.55), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9), colFn(12.07), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9), colFn(12.36), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), colFn(19.89), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), colFn(24.43), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07),
        location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44), colFn(42.68), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44),
        location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44), colFn(38.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44),
        location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69), colFn(38.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69),
        location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69), colFn(38.07), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69),
        location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59), colFn(29.19), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59),
        location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11), colFn(29.19), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11),
        location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07), colFn(38.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07),
        location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07), colFn(42.68), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 48.72),
        location + scale * vector.New(55.377, 48.72),
        location + scale * vector.New(54.627, 48.407), location + scale * vector.New(54, 47.78),
        colFn(54), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.367, 47.153),
        location + scale * vector.New(53.05, 46.403), location + scale * vector.New(53.05, 45.53),
        colFn(53.05), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.05, 44.65),
        location + scale * vector.New(53.367, 43.897), location + scale * vector.New(54, 43.27),
        colFn(54), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.627, 42.643),
        location + scale * vector.New(55.377, 42.33), location + scale * vector.New(56.25, 42.33),
        colFn(56.25),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123, 42.33),
        location + scale * vector.New(57.873, 42.643), location + scale * vector.New(58.5, 43.27),
        colFn(58.5), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.133, 43.897), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), colFn(59.45), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.303, 46.64), location + scale * vector.New(59.01, 47.12),
        colFn(59.01), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.723, 47.607),
        location + scale * vector.New(58.34, 47.997), location + scale * vector.New(57.86, 48.29),
        colFn(57.86), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.38, 48.577),
        location + scale * vector.New(56.843, 48.72), location + scale * vector.New(56.25, 48.72),
        colFn(56.25),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07),
        location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44), colFn(79.69), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44),
        location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44), colFn(75.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44),
        location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69), colFn(75.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69),
        location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69), colFn(75.07), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69),
        location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59), colFn(66.19), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59),
        location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11), colFn(66.19), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11),
        location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07), colFn(75.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07),
        location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07), colFn(79.69), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 48.72),
        location + scale * vector.New(92.377, 48.72),
        location + scale * vector.New(91.627, 48.407), location + scale * vector.New(91, 47.78),
        colFn(91), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 47.78),
        location + scale * vector.New(90.373, 47.153),
        location + scale * vector.New(90.06, 46.403), location + scale * vector.New(90.06, 45.53),
        colFn(90.06),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.06, 45.53), location + scale * vector.New(90.06, 44.65),
        location + scale * vector.New(90.373, 43.897), location + scale * vector.New(91, 43.27),
        colFn(91), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 43.27),
        location + scale * vector.New(91.627, 42.643),
        location + scale * vector.New(92.377, 42.33), location + scale * vector.New(93.25, 42.33),
        colFn(93.25),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 42.33), location + scale * vector.New(94.13, 42.33),
        location + scale * vector.New(94.883, 42.643), location + scale * vector.New(95.51, 43.27),
        colFn(95.51), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.51, 43.27),
        location + scale * vector.New(96.137, 43.897),
        location + scale * vector.New(96.45, 44.65), location + scale * vector.New(96.45, 45.53),
        colFn(96.45),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.45, 45.53),
        location + scale * vector.New(96.45, 46.11),
        location + scale * vector.New(96.303, 46.64), location + scale * vector.New(96.01, 47.12),
        colFn(96.01), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.01, 47.12),
        location + scale * vector.New(95.723, 47.607),
        location + scale * vector.New(95.34, 47.997), location + scale * vector.New(94.86, 48.29),
        colFn(94.86),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.86, 48.29),
        location + scale * vector.New(94.38, 48.577), location + scale * vector.New(93.843, 48.72),
        location + scale * vector.New(93.25, 48.72), colFn(93.25), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 48.93),
        location + scale * vector.New(113.09, 48.93),
        location + scale * vector.New(110.81, 48.2), location + scale * vector.New(108.93, 46.74),
        colFn(108.93),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.93, 46.74),
        location + scale * vector.New(107.05, 45.28),
        location + scale * vector.New(105.613, 43.157),
        location + scale * vector.New(104.62, 40.37), colFn(104.62), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.62, 40.37),
        location + scale * vector.New(103.627, 37.583),
        location + scale * vector.New(103.13, 34.213), location + scale * vector.New(103.13, 30.26),
        colFn(103.13),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.13, 30.26),
        location + scale * vector.New(103.13, 26.327),
        location + scale * vector.New(103.63, 22.967), location + scale * vector.New(104.63, 20.18),
        colFn(104.63),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.63, 20.18),
        location + scale * vector.New(105.63, 17.393),
        location + scale * vector.New(107.073, 15.263),
        location + scale * vector.New(108.96, 13.79), colFn(108.96), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.96, 13.79),
        location + scale * vector.New(110.847, 12.317),
        location + scale * vector.New(113.117, 11.58), location + scale * vector.New(115.77, 11.58),
        colFn(115.77),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 11.58),
        location + scale * vector.New(118.417, 11.58),
        location + scale * vector.New(120.687, 12.317),
        location + scale * vector.New(122.58, 13.79), colFn(122.58), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.58, 13.79),
        location + scale * vector.New(124.467, 15.263),
        location + scale * vector.New(125.91, 17.393),
        location + scale * vector.New(126.91, 20.18), colFn(126.91), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.91, 20.18),
        location + scale * vector.New(127.91, 22.967),
        location + scale * vector.New(128.41, 26.327),
        location + scale * vector.New(128.41, 30.26), colFn(128.41), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(128.41, 30.26),
        location + scale * vector.New(128.41, 34.213),
        location + scale * vector.New(127.913, 37.583),
        location + scale * vector.New(126.92, 40.37), colFn(126.92), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.92, 40.37),
        location + scale * vector.New(125.927, 43.157),
        location + scale * vector.New(124.487, 45.28),
        location + scale * vector.New(122.6, 46.74), colFn(122.6), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.6, 46.74),
        location + scale * vector.New(120.72, 48.2),
        location + scale * vector.New(118.443, 48.93),
        location + scale * vector.New(115.77, 48.93), colFn(115.77), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 45.03),
        location + scale * vector.New(118.417, 45.03),
        location + scale * vector.New(120.477, 43.75), location + scale * vector.New(121.95, 41.19),
        colFn(121.95),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.95, 41.19),
        location + scale * vector.New(123.417, 38.637),
        location + scale * vector.New(124.15, 34.993), location + scale * vector.New(124.15, 30.26),
        colFn(124.15),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.15, 30.26),
        location + scale * vector.New(124.15, 27.107),
        location + scale * vector.New(123.813, 24.423),
        location + scale * vector.New(123.14, 22.21), colFn(123.14), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.14, 22.21),
        location + scale * vector.New(122.473, 19.997),
        location + scale * vector.New(121.517, 18.31), location + scale * vector.New(120.27, 17.15),
        colFn(120.27),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.27, 17.15),
        location + scale * vector.New(119.017, 15.99),
        location + scale * vector.New(117.517, 15.41), location + scale * vector.New(115.77, 15.41),
        colFn(115.77),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 15.41),
        location + scale * vector.New(113.143, 15.41),
        location + scale * vector.New(111.09, 16.703),
        location + scale * vector.New(109.61, 19.29), colFn(109.61), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.61, 19.29),
        location + scale * vector.New(108.13, 21.877),
        location + scale * vector.New(107.39, 25.533), location + scale * vector.New(107.39, 30.26),
        colFn(107.39),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(107.39, 30.26),
        location + scale * vector.New(107.39, 33.407), location + scale * vector.New(107.72, 36.08),
        location + scale * vector.New(108.38, 38.28), colFn(108.38), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.38, 38.28),
        location + scale * vector.New(109.047, 40.48),
        location + scale * vector.New(110.003, 42.157),
        location + scale * vector.New(111.25, 43.31), colFn(111.25), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.25, 43.31),
        location + scale * vector.New(112.497, 44.457),
        location + scale * vector.New(114.003, 45.03), location + scale * vector.New(115.77, 45.03),
        colFn(115.77),
        thickness)
end
