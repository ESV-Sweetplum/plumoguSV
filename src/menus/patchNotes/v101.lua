function showPatchNotesV101(c)
    local bugFixes = {
        'Fixed game occasionally crashing when using the Select tab.',
    }

    local newFeatures = {
        'Added Select Bookmark feature (from BookmarkLeaper).',
        'Added Edit > Align Timing Lines feature (from SmartAlign).',
        'Added notifications for more features when executed.',
        'Added tooltips for Select features and swap/negate buttons.',
        'Changed the Delete menu to allow deleting SVs or SSFs.',
    }

    showPatchNotesElement('v1.0.1', drawV101, 125, c, bugFixes, newFeatures)
end

---Draws v101 on screen, with dimensions = scale * [125,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV101(ctx, location, scale, col, thickness)
    location = location - vector.New(62.5, 24) * scale
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
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07),
        location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44),
        location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44),
        location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69),
        location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69),
        location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59),
        location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11),
        location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07),
        location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 48.72),
        location + scale * vector.New(55.377, 48.72),
        location + scale * vector.New(54.627, 48.407), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.367, 47.153),
        location + scale * vector.New(53.05, 46.403), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.05, 44.65),
        location + scale * vector.New(53.367, 43.897), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.627, 42.643),
        location + scale * vector.New(55.377, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123, 42.33),
        location + scale * vector.New(57.873, 42.643), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.133, 43.897), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.303, 46.64), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.723, 47.607),
        location + scale * vector.New(58.34, 47.997), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.38, 48.577),
        location + scale * vector.New(56.843, 48.72), location + scale * vector.New(56.25, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 48.93),
        location + scale * vector.New(76.087, 48.93),
        location + scale * vector.New(73.81, 48.2), location + scale * vector.New(71.93, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.93, 46.74),
        location + scale * vector.New(70.05, 45.28), location + scale * vector.New(68.61, 43.157),
        location + scale * vector.New(67.61, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.61, 40.37),
        location + scale * vector.New(66.617, 37.583),
        location + scale * vector.New(66.12, 34.213), location + scale * vector.New(66.12, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.12, 30.26),
        location + scale * vector.New(66.12, 26.327),
        location + scale * vector.New(66.62, 22.967), location + scale * vector.New(67.62, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.62, 20.18),
        location + scale * vector.New(68.62, 17.393),
        location + scale * vector.New(70.063, 15.263), location + scale * vector.New(71.95, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.95, 13.79),
        location + scale * vector.New(73.843, 12.317),
        location + scale * vector.New(76.113, 11.58), location + scale * vector.New(78.76, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 11.58),
        location + scale * vector.New(81.413, 11.58),
        location + scale * vector.New(83.683, 12.317), location + scale * vector.New(85.57, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.57, 13.79),
        location + scale * vector.New(87.463, 15.263),
        location + scale * vector.New(88.91, 17.393), location + scale * vector.New(89.91, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 20.18),
        location + scale * vector.New(90.91, 22.967),
        location + scale * vector.New(91.41, 26.327), location + scale * vector.New(91.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.41, 30.26),
        location + scale * vector.New(91.41, 34.213), location + scale * vector.New(90.91, 37.583),
        location + scale * vector.New(89.91, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 40.37),
        location + scale * vector.New(88.917, 43.157),
        location + scale * vector.New(87.48, 45.28), location + scale * vector.New(85.6, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.6, 46.74),
        location + scale * vector.New(83.72, 48.2), location + scale * vector.New(81.44, 48.93),
        location + scale * vector.New(78.76, 48.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 45.03),
        location + scale * vector.New(81.413, 45.03), location + scale * vector.New(83.473, 43.75),
        location + scale * vector.New(84.94, 41.19), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(84.94, 41.19),
        location + scale * vector.New(86.407, 38.637),
        location + scale * vector.New(87.14, 34.993), location + scale * vector.New(87.14, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(87.14, 30.26),
        location + scale * vector.New(87.14, 27.107),
        location + scale * vector.New(86.807, 24.423), location + scale * vector.New(86.14, 22.21),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.14, 22.21),
        location + scale * vector.New(85.473, 19.997),
        location + scale * vector.New(84.517, 18.31), location + scale * vector.New(83.27, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(83.27, 17.15),
        location + scale * vector.New(82.017, 15.99),
        location + scale * vector.New(80.513, 15.41), location + scale * vector.New(78.76, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 15.41),
        location + scale * vector.New(76.133, 15.41),
        location + scale * vector.New(74.08, 16.703), location + scale * vector.New(72.6, 19.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(72.6, 19.29),
        location + scale * vector.New(71.12, 21.877),
        location + scale * vector.New(70.38, 25.533), location + scale * vector.New(70.38, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(70.38, 30.26),
        location + scale * vector.New(70.38, 33.407), location + scale * vector.New(70.713, 36.08),
        location + scale * vector.New(71.38, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.38, 38.28),
        location + scale * vector.New(72.04, 40.48),
        location + scale * vector.New(72.997, 42.157), location + scale * vector.New(74.25, 43.31),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.25, 43.31),
        location + scale * vector.New(75.497, 44.457), location + scale * vector.New(77, 45.03),
        location + scale * vector.New(78.76, 45.03), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 48.72),
        location + scale * vector.New(100.4, 48.72),
        location + scale * vector.New(99.647, 48.407), location + scale * vector.New(99.02, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 47.78),
        location + scale * vector.New(98.393, 47.153),
        location + scale * vector.New(98.08, 46.403), location + scale * vector.New(98.08, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.08, 45.53),
        location + scale * vector.New(98.08, 44.65),
        location + scale * vector.New(98.393, 43.897), location + scale * vector.New(99.02, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 43.27),
        location + scale * vector.New(99.647, 42.643),
        location + scale * vector.New(100.4, 42.33), location + scale * vector.New(101.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 42.33),
        location + scale * vector.New(102.153, 42.33),
        location + scale * vector.New(102.903, 42.643),
        location + scale * vector.New(103.53, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.53, 43.27),
        location + scale * vector.New(104.157, 43.897),
        location + scale * vector.New(104.47, 44.65), location + scale * vector.New(104.47, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.47, 45.53), location + scale * vector.New(104.47, 46.11),
        location + scale * vector.New(104.327, 46.64),
        location + scale * vector.New(104.04, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.04, 47.12),
        location + scale * vector.New(103.747, 47.607),
        location + scale * vector.New(103.363, 47.997),
        location + scale * vector.New(102.89, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(102.89, 48.29),
        location + scale * vector.New(102.41, 48.577),
        location + scale * vector.New(101.873, 48.72), location + scale * vector.New(101.28, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.72, 12.07), location + scale * vector.New(124.72, 12.07),
        location + scale * vector.New(124.72, 48.44), location + scale * vector.New(124.72, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.72, 48.44), location + scale * vector.New(124.72, 48.44),
        location + scale * vector.New(120.31, 48.44), location + scale * vector.New(120.31, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.31, 48.44), location + scale * vector.New(120.31, 48.44),
        location + scale * vector.New(120.31, 16.69), location + scale * vector.New(120.31, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.31, 16.69), location + scale * vector.New(120.31, 16.69),
        location + scale * vector.New(120.1, 16.69), location + scale * vector.New(120.1, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.1, 16.69), location + scale * vector.New(120.1, 16.69),
        location + scale * vector.New(111.22, 22.59), location + scale * vector.New(111.22, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.22, 22.59), location + scale * vector.New(111.22, 22.59),
        location + scale * vector.New(111.22, 18.11), location + scale * vector.New(111.22, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.22, 18.11), location + scale * vector.New(111.22, 18.11),
        location + scale * vector.New(120.31, 12.07), location + scale * vector.New(120.31, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.31, 12.07), location + scale * vector.New(120.31, 12.07),
        location + scale * vector.New(124.72, 12.07), location + scale * vector.New(124.72, 12.07), col, thickness)
end
