function showPatchNotesV211(lc, rc)
    local bugFixes = {
        'Fixed the x2 and /2 buttons not working.',
    }

    local newFeatures = {
        'Added a new dynamic background, the SV Spectrogram.',
        'Added the "none" type to the final SV selector.',
        'Reworked the DELETE menu, now having multiple buttons. An option was added\nto switch back to the checkbox mode seen in previous versions.',
    }

    showPatchNotesElement('v2.1.1', drawV211, 135, lc, bugFixes, newFeatures)
end

---Draws v211 on screen, with dimensions = scale * [124,37].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV211(ctx, location, scale, col, thickness)
    location = location - vector.New(62, 18.5) * scale
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.90, 48.44),
        location + scale * vector.New(29.90, 48.44),
        location + scale * vector.New(29.90, 45.24),
        location + scale * vector.New(29.90, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.90, 45.24),
        location + scale * vector.New(29.90, 45.24), location + scale * vector.New(41.9, 32.1),
        location + scale * vector.New(41.9, 32.1), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.9, 32.1),
        location + scale * vector.New(43.31, 30.56), location + scale * vector.New(44.47, 29.22),
        location + scale * vector.New(45.38, 28.08), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(45.38, 28.08),
        location + scale * vector.New(46.29, 26.94), location + scale * vector.New(46.97, 25.86),
        location + scale * vector.New(47.42, 24.85), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.42, 24.85), location + scale * vector.New(47.86, 23.84),
        location + scale * vector.New(48.08, 22.77), location + scale * vector.New(48.08, 21.66), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(48.08, 21.66), location + scale * vector.New(48.08, 20.38),
        location + scale * vector.New(47.78, 19.27), location + scale * vector.New(47.17, 18.34), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.17, 18.34), location + scale * vector.New(46.56, 17.41),
        location + scale * vector.New(45.72, 16.69), location + scale * vector.New(44.67, 16.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.67, 16.18), location + scale * vector.New(43.62, 15.67),
        location + scale * vector.New(42.43, 15.41), location + scale * vector.New(41.12, 15.41), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.12, 15.41),
        location + scale * vector.New(39.73, 15.41),
        location + scale * vector.New(38.51, 15.70), location + scale * vector.New(37.47, 16.27), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(37.47, 16.27), location + scale * vector.New(36.44, 16.84),
        location + scale * vector.New(35.64, 17.65), location + scale * vector.New(35.08, 18.68), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.08, 18.68), location + scale * vector.New(34.51, 19.71),
        location + scale * vector.New(34.23, 20.91), location + scale * vector.New(34.23, 22.3),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(34.23, 22.3),
        location + scale * vector.New(34.23, 22.3), location + scale * vector.New(30.04, 22.3),
        location + scale * vector.New(30.04, 22.3), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(30.04, 22.3), location + scale * vector.New(30.04, 20.17),
        location + scale * vector.New(30.53, 18.3), location + scale * vector.New(31.52, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(31.52, 16.69), location + scale * vector.New(32.5, 15.08),
        location + scale * vector.New(33.84, 13.83), location + scale * vector.New(35.54, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.54, 12.93),
        location + scale * vector.New(37.24, 12.03), location + scale * vector.New(39.15, 11.58),
        location + scale * vector.New(41.26, 11.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.26, 11.58), location + scale * vector.New(43.39, 11.58),
        location + scale * vector.New(45.28, 12.03), location + scale * vector.New(46.93, 12.93), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(46.93, 12.93), location + scale * vector.New(48.58, 13.83),
        location + scale * vector.New(49.87, 15.04),
        location + scale * vector.New(50.80, 16.57), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(50.80, 16.57),
        location + scale * vector.New(51.73, 18.1), location + scale * vector.New(52.2, 19.79),
        location + scale * vector.New(52.2, 21.66), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.2, 21.66), location + scale * vector.New(52.2, 23),
        location + scale * vector.New(51.96, 24.31),
        location + scale * vector.New(51.48, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(51.48, 25.58),
        location + scale * vector.New(51, 26.85), location + scale * vector.New(50.17, 28.27),
        location + scale * vector.New(49, 29.82), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(49, 29.82), location + scale * vector.New(47.82, 31.38),
        location + scale * vector.New(46.19, 33.28), location + scale * vector.New(44.11, 35.51), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.11, 35.51), location + scale * vector.New(44.11, 35.51),
        location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25),
        location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53),
        location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53),
        location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44),
        location + scale * vector.New(29.90, 48.44),
        location + scale * vector.New(29.90, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 48.72),
        location + scale * vector.New(62.41, 48.72),
        location + scale * vector.New(61.66, 48.41),
        location + scale * vector.New(61.03, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 47.78), location + scale * vector.New(60.4, 47.15),
        location + scale * vector.New(60.09, 46.4), location + scale * vector.New(60.09, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(60.09, 45.53), location + scale * vector.New(60.09, 44.65),
        location + scale * vector.New(60.4, 43.9), location + scale * vector.New(61.03, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 43.27),
        location + scale * vector.New(61.66, 42.64),
        location + scale * vector.New(62.41, 42.33), location + scale * vector.New(63.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 42.33), location + scale * vector.New(64.16, 42.33),
        location + scale * vector.New(64.91, 42.64), location + scale * vector.New(65.54, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(65.54, 43.27), location + scale * vector.New(66.17, 43.9),
        location + scale * vector.New(66.48, 44.65), location + scale * vector.New(66.48, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.48, 45.53), location + scale * vector.New(66.48, 46.11),
        location + scale * vector.New(66.33, 46.64), location + scale * vector.New(66.04, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.04, 47.12), location + scale * vector.New(65.75, 47.61),
        location + scale * vector.New(65.37, 48), location + scale * vector.New(64.89, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(64.89, 48.29), location + scale * vector.New(64.41, 48.58),
        location + scale * vector.New(63.87, 48.72), location + scale * vector.New(63.28, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.72, 12.07), location + scale * vector.New(86.72, 12.07),
        location + scale * vector.New(86.72, 48.44), location + scale * vector.New(86.72, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.72, 48.44), location + scale * vector.New(86.72, 48.44),
        location + scale * vector.New(82.32, 48.44), location + scale * vector.New(82.32, 48.44),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(82.32, 48.44),
        location + scale * vector.New(82.32, 48.44), location + scale * vector.New(82.32, 16.69),
        location + scale * vector.New(82.32, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(82.32, 16.69),
        location + scale * vector.New(82.32, 16.69), location + scale * vector.New(82.1, 16.69),
        location + scale * vector.New(82.1, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(82.1, 16.69),
        location + scale * vector.New(82.1, 16.69), location + scale * vector.New(73.22, 22.59),
        location + scale * vector.New(73.22, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.22, 22.59), location + scale * vector.New(73.22, 22.59),
        location + scale * vector.New(73.22, 18.11), location + scale * vector.New(73.22, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.22, 18.11), location + scale * vector.New(73.22, 18.11),
        location + scale * vector.New(82.32, 12.07), location + scale * vector.New(82.32, 12.07),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(82.32, 12.07),
        location + scale * vector.New(82.32, 12.07), location + scale * vector.New(86.72, 12.07),
        location + scale * vector.New(86.72, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(100.28, 48.72), location + scale * vector.New(99.41, 48.72),
        location + scale * vector.New(98.66, 48.41), location + scale * vector.New(98.03, 47.78), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.03, 47.78), location + scale * vector.New(97.4, 47.15),
        location + scale * vector.New(97.09, 46.4), location + scale * vector.New(97.09, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(97.09, 45.53), location + scale * vector.New(97.09, 44.65),
        location + scale * vector.New(97.4, 43.9), location + scale * vector.New(98.03, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.03, 43.27), location + scale * vector.New(98.66, 42.64),
        location + scale * vector.New(99.41, 42.33), location + scale * vector.New(100.28, 42.33), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(100.28, 42.33), location + scale * vector.New(101.16, 42.33),
        location + scale * vector.New(101.91, 42.64), location + scale * vector.New(102.54, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(102.54, 43.27), location + scale * vector.New(103.17, 43.9),
        location + scale * vector.New(103.48, 44.65), location + scale * vector.New(103.48, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.48, 45.53), location + scale * vector.New(103.48, 46.11),
        location + scale * vector.New(103.34, 46.64), location + scale * vector.New(103.05, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.05, 47.12), location + scale * vector.New(102.76, 47.61),
        location + scale * vector.New(102.37, 48), location + scale * vector.New(101.89, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.89, 48.29), location + scale * vector.New(101.41, 48.58),
        location + scale * vector.New(100.87, 48.72), location + scale * vector.New(100.28, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.72, 12.07), location + scale * vector.New(123.72, 12.07),
        location + scale * vector.New(123.72, 48.44), location + scale * vector.New(123.72, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.72, 48.44), location + scale * vector.New(123.72, 48.44),
        location + scale * vector.New(119.32, 48.44),
        location + scale * vector.New(119.32, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.32, 48.44),
        location + scale * vector.New(119.32, 48.44),
        location + scale * vector.New(119.32, 16.69),
        location + scale * vector.New(119.32, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.32, 16.69),
        location + scale * vector.New(119.32, 16.69), location + scale * vector.New(119.11, 16.69),
        location + scale * vector.New(119.11, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.11, 16.69), location + scale * vector.New(119.11, 16.69),
        location + scale * vector.New(110.23, 22.59), location + scale * vector.New(110.23, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.23, 22.59), location + scale * vector.New(110.23, 22.59),
        location + scale * vector.New(110.23, 18.11), location + scale * vector.New(110.23, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.23, 18.11), location + scale * vector.New(110.23, 18.11),
        location + scale * vector.New(119.32, 12.07),
        location + scale * vector.New(119.32, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.32, 12.07),
        location + scale * vector.New(119.32, 12.07), location + scale * vector.New(123.72, 12.07),
        location + scale * vector.New(123.72, 12.07), col, thickness)
end
