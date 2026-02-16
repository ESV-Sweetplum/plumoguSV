function showPatchNotesV201(c)
    local bugFixes = {
        'Fixed individual combo settings being able to be saved.',
        'Fixed loadup text color not being properly used in the custom theme.',
        'Changed the barbie theme to be less obnoxious.',
        'Fixed themes not exporting loadup parameters correctly.',
        'Changed some backend features to prevent bugs in the future.',
        'Moved some settings to the new "Advanced" section.',
        'Fixed performance mode not delaying HitObject refresh.',
        'Fixed stutter linear interpolation crashing the plugin.',
        'Now successfully hot-reloads menu data.',
        'Fixed Select > Alternating offset bug.',
        'Fixed loadup animation playing after delay even when it was disabled.',
    }

    local newFeatures = {
        'Now allows you to change the default displacement exponential multiplier.',
        'Added a setting which unrestricts sinusoidal period.',
        'Added mines to the Select > Note Type feature (canary only).',
        'Added a small gradient in the background to enhance appearance.',
    }

    showPatchNotesElement('v2.0.1', drawV201, 132, c, bugFixes, newFeatures)
end

---Draws v201 on screen, with dimensions = scale * [132,37].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV201(ctx, location, scale, col, thickness)
    location = location - vector.New(66, 18.5) * scale
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
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44),
        location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24),
        location + scale * vector.New(41.9, 32.1), location + scale * vector.New(41.9, 32.1), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.9, 32.1), location + scale * vector.New(43.313, 30.56),
        location + scale * vector.New(44.473, 29.22), location + scale * vector.New(45.38, 28.08), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(45.38, 28.08),
        location + scale * vector.New(46.293, 26.94),
        location + scale * vector.New(46.973, 25.863), location + scale * vector.New(47.42, 24.85),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.42, 24.85),
        location + scale * vector.New(47.86, 23.837),
        location + scale * vector.New(48.08, 22.773), location + scale * vector.New(48.08, 21.66),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(48.08, 21.66),
        location + scale * vector.New(48.08, 20.38),
        location + scale * vector.New(47.777, 19.273), location + scale * vector.New(47.17, 18.34),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.17, 18.34),
        location + scale * vector.New(46.557, 17.407),
        location + scale * vector.New(45.723, 16.687), location + scale * vector.New(44.67, 16.18),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.67, 16.18),
        location + scale * vector.New(43.617, 15.667),
        location + scale * vector.New(42.433, 15.41), location + scale * vector.New(41.12, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.12, 15.41),
        location + scale * vector.New(39.727, 15.41), location + scale * vector.New(38.51, 15.697),
        location + scale * vector.New(37.47, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(37.47, 16.27),
        location + scale * vector.New(36.437, 16.843),
        location + scale * vector.New(35.64, 17.647), location + scale * vector.New(35.08, 18.68), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.08, 18.68),
        location + scale * vector.New(34.513, 19.707),
        location + scale * vector.New(34.23, 20.913), location + scale * vector.New(34.23, 22.3), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(34.23, 22.3), location + scale * vector.New(34.23, 22.3),
        location + scale * vector.New(30.04, 22.3), location + scale * vector.New(30.04, 22.3), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(30.04, 22.3),
        location + scale * vector.New(30.04, 20.173),
        location + scale * vector.New(30.533, 18.303), location + scale * vector.New(31.52, 16.69),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(31.52, 16.69),
        location + scale * vector.New(32.5, 15.083),
        location + scale * vector.New(33.84, 13.83),
        location + scale * vector.New(35.54, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.54, 12.93), location + scale * vector.New(37.24, 12.03),
        location + scale * vector.New(39.147, 11.58), location + scale * vector.New(41.26, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.26, 11.58),
        location + scale * vector.New(43.393, 11.58), location + scale * vector.New(45.283, 12.03),
        location + scale * vector.New(46.93, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(46.93, 12.93),
        location + scale * vector.New(48.577, 13.83),
        location + scale * vector.New(49.867, 15.043), location + scale * vector.New(50.8, 16.57),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(50.8, 16.57),
        location + scale * vector.New(51.733, 18.097),
        location + scale * vector.New(52.2, 19.793), location + scale * vector.New(52.2, 21.66),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.2, 21.66), location + scale * vector.New(52.2, 23),
        location + scale * vector.New(51.96, 24.307),
        location + scale * vector.New(51.48, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(51.48, 25.58),
        location + scale * vector.New(51, 26.853),
        location + scale * vector.New(50.173, 28.267), location + scale * vector.New(49, 29.82),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(49, 29.82),
        location + scale * vector.New(47.82, 31.38),
        location + scale * vector.New(46.19, 33.277), location + scale * vector.New(44.11, 35.51), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.11, 35.51), location + scale * vector.New(44.11, 35.51),
        location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25),
        location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53),
        location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53),
        location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44),
        location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 48.72),
        location + scale * vector.New(62.407, 48.72),
        location + scale * vector.New(61.657, 48.407),
        location + scale * vector.New(61.03, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 47.78),
        location + scale * vector.New(60.403, 47.153),
        location + scale * vector.New(60.09, 46.403), location + scale * vector.New(60.09, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(60.09, 45.53), location + scale * vector.New(60.09, 44.65),
        location + scale * vector.New(60.403, 43.897), location + scale * vector.New(61.03, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 43.27),
        location + scale * vector.New(61.657, 42.643),
        location + scale * vector.New(62.407, 42.33), location + scale * vector.New(63.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 42.33), location + scale * vector.New(64.16, 42.33),
        location + scale * vector.New(64.913, 42.643), location + scale * vector.New(65.54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(65.54, 43.27),
        location + scale * vector.New(66.167, 43.897), location + scale * vector.New(66.48, 44.65),
        location + scale * vector.New(66.48, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.48, 45.53), location + scale * vector.New(66.48, 46.11),
        location + scale * vector.New(66.333, 46.64), location + scale * vector.New(66.04, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.04, 47.12),
        location + scale * vector.New(65.753, 47.607),
        location + scale * vector.New(65.37, 47.997), location + scale * vector.New(64.89, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(64.89, 48.29),
        location + scale * vector.New(64.41, 48.577), location + scale * vector.New(63.873, 48.72),
        location + scale * vector.New(63.28, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 48.93),
        location + scale * vector.New(83.12, 48.93),
        location + scale * vector.New(80.84, 48.2), location + scale * vector.New(78.96, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.96, 46.74),
        location + scale * vector.New(77.08, 45.28), location + scale * vector.New(75.64, 43.157),
        location + scale * vector.New(74.64, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.64, 40.37),
        location + scale * vector.New(73.647, 37.583),
        location + scale * vector.New(73.15, 34.213), location + scale * vector.New(73.15, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.15, 30.26),
        location + scale * vector.New(73.15, 26.327),
        location + scale * vector.New(73.65, 22.967), location + scale * vector.New(74.65, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.65, 20.18),
        location + scale * vector.New(75.65, 17.393),
        location + scale * vector.New(77.097, 15.263), location + scale * vector.New(78.99, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.99, 13.79),
        location + scale * vector.New(80.877, 12.317),
        location + scale * vector.New(83.147, 11.58), location + scale * vector.New(85.8, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 11.58),
        location + scale * vector.New(88.447, 11.58),
        location + scale * vector.New(90.713, 12.317), location + scale * vector.New(92.6, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.6, 13.79),
        location + scale * vector.New(94.493, 15.263),
        location + scale * vector.New(95.94, 17.393), location + scale * vector.New(96.94, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.94, 20.18),
        location + scale * vector.New(97.94, 22.967),
        location + scale * vector.New(98.44, 26.327), location + scale * vector.New(98.44, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.44, 30.26),
        location + scale * vector.New(98.44, 34.213),
        location + scale * vector.New(97.943, 37.583), location + scale * vector.New(96.95, 40.37),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.95, 40.37),
        location + scale * vector.New(95.95, 43.157),
        location + scale * vector.New(94.51, 45.28), location + scale * vector.New(92.63, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.63, 46.74),
        location + scale * vector.New(90.75, 48.2),
        location + scale * vector.New(88.473, 48.93), location + scale * vector.New(85.8, 48.93),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 45.03),
        location + scale * vector.New(88.447, 45.03), location + scale * vector.New(90.503, 43.75),
        location + scale * vector.New(91.97, 41.19), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.97, 41.19),
        location + scale * vector.New(93.443, 38.637),
        location + scale * vector.New(94.18, 34.993), location + scale * vector.New(94.18, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.18, 30.26),
        location + scale * vector.New(94.18, 27.107),
        location + scale * vector.New(93.843, 24.423), location + scale * vector.New(93.17, 22.21),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.17, 22.21),
        location + scale * vector.New(92.503, 19.997),
        location + scale * vector.New(91.547, 18.31), location + scale * vector.New(90.3, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.3, 17.15),
        location + scale * vector.New(89.047, 15.99),
        location + scale * vector.New(87.547, 15.41), location + scale * vector.New(85.8, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 15.41),
        location + scale * vector.New(83.167, 15.41),
        location + scale * vector.New(81.11, 16.703), location + scale * vector.New(79.63, 19.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.63, 19.29),
        location + scale * vector.New(78.15, 21.877),
        location + scale * vector.New(77.41, 25.533), location + scale * vector.New(77.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(77.41, 30.26),
        location + scale * vector.New(77.41, 33.407), location + scale * vector.New(77.743, 36.08),
        location + scale * vector.New(78.41, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.41, 38.28), location + scale * vector.New(79.07, 40.48),
        location + scale * vector.New(80.027, 42.157), location + scale * vector.New(81.28, 43.31),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(81.28, 43.31),
        location + scale * vector.New(82.527, 44.457),
        location + scale * vector.New(84.033, 45.03), location + scale * vector.New(85.8, 45.03), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 48.72),
        location + scale * vector.New(107.437, 48.72),
        location + scale * vector.New(106.683, 48.407),
        location + scale * vector.New(106.05, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 47.78),
        location + scale * vector.New(105.423, 47.153),
        location + scale * vector.New(105.11, 46.403),
        location + scale * vector.New(105.11, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.11, 45.53),
        location + scale * vector.New(105.11, 44.65),
        location + scale * vector.New(105.423, 43.897),
        location + scale * vector.New(106.05, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 43.27),
        location + scale * vector.New(106.683, 42.643),
        location + scale * vector.New(107.437, 42.33), location + scale * vector.New(108.31, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 42.33),
        location + scale * vector.New(109.183, 42.33),
        location + scale * vector.New(109.933, 42.643),
        location + scale * vector.New(110.56, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.56, 43.27),
        location + scale * vector.New(111.193, 43.897),
        location + scale * vector.New(111.51, 44.65), location + scale * vector.New(111.51, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.51, 45.53), location + scale * vector.New(111.51, 46.11),
        location + scale * vector.New(111.363, 46.64),
        location + scale * vector.New(111.07, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.07, 47.12),
        location + scale * vector.New(110.783, 47.607),
        location + scale * vector.New(110.4, 47.997),
        location + scale * vector.New(109.92, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.92, 48.29),
        location + scale * vector.New(109.44, 48.577),
        location + scale * vector.New(108.903, 48.72), location + scale * vector.New(108.31, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(131.75, 12.07), location + scale * vector.New(131.75, 12.07),
        location + scale * vector.New(131.75, 48.44), location + scale * vector.New(131.75, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(131.75, 48.44), location + scale * vector.New(131.75, 48.44),
        location + scale * vector.New(127.34, 48.44), location + scale * vector.New(127.34, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(127.34, 48.44), location + scale * vector.New(127.34, 48.44),
        location + scale * vector.New(127.34, 16.69), location + scale * vector.New(127.34, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(127.34, 16.69), location + scale * vector.New(127.34, 16.69),
        location + scale * vector.New(127.13, 16.69), location + scale * vector.New(127.13, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(127.13, 16.69), location + scale * vector.New(127.13, 16.69),
        location + scale * vector.New(118.25, 22.59), location + scale * vector.New(118.25, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.25, 22.59), location + scale * vector.New(118.25, 22.59),
        location + scale * vector.New(118.25, 18.11), location + scale * vector.New(118.25, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.25, 18.11), location + scale * vector.New(118.25, 18.11),
        location + scale * vector.New(127.34, 12.07), location + scale * vector.New(127.34, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(127.34, 12.07), location + scale * vector.New(127.34, 12.07),
        location + scale * vector.New(131.75, 12.07), location + scale * vector.New(131.75, 12.07), col, thickness)
end
