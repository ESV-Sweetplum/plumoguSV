function showPatchNotesV100(lc, rc)
    local bugFixes = {
        'Fix LN Ends feature now flips LN ends, even if the corresponding ending SV is 0.',
        'Allowed Still to treat LN ends as displacement markers.',
    }

    local newFeatures = {
        'Added the Select tab, which allows users to quickly select desired notes based on\na variety of conditions. Currently, there is the Alternate option and the Snap option.',
    }

    showPatchNotesElement('v1.0.0', drawV100, 137, { lc, rc }, bugFixes, newFeatures)
end

---Draws v100 on screen, with dimensions = scale * [137,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param thickness integer
function drawV100(ctx, location, scale, thickness)
    local hueDegreeAdjust = (state.UnixTime % 7200) / 20 + 67
    local colFn = function(x)
        return color.vrgbaToUint(color.hslaToRgba(x + hueDegreeAdjust, 1, 0.7, 1))
    end
    location = location - vector.New(68.5, 24) * scale
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
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 48.93),
        location + scale * vector.New(76.087, 48.93),
        location + scale * vector.New(73.81, 48.2), location + scale * vector.New(71.93, 46.74),
        colFn(71.93),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.93, 46.74),
        location + scale * vector.New(70.05, 45.28), location + scale * vector.New(68.61, 43.157),
        location + scale * vector.New(67.61, 40.37), colFn(67.61), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.61, 40.37),
        location + scale * vector.New(66.617, 37.583),
        location + scale * vector.New(66.12, 34.213), location + scale * vector.New(66.12, 30.26),
        colFn(66.12),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.12, 30.26),
        location + scale * vector.New(66.12, 26.327),
        location + scale * vector.New(66.62, 22.967), location + scale * vector.New(67.62, 20.18),
        colFn(67.62),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.62, 20.18),
        location + scale * vector.New(68.62, 17.393),
        location + scale * vector.New(70.063, 15.263), location + scale * vector.New(71.95, 13.79),
        colFn(71.95), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.95, 13.79),
        location + scale * vector.New(73.843, 12.317),
        location + scale * vector.New(76.113, 11.58), location + scale * vector.New(78.76, 11.58),
        colFn(78.76),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 11.58),
        location + scale * vector.New(81.413, 11.58),
        location + scale * vector.New(83.683, 12.317), location + scale * vector.New(85.57, 13.79),
        colFn(85.57), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.57, 13.79),
        location + scale * vector.New(87.463, 15.263),
        location + scale * vector.New(88.91, 17.393), location + scale * vector.New(89.91, 20.18),
        colFn(89.91),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 20.18),
        location + scale * vector.New(90.91, 22.967),
        location + scale * vector.New(91.41, 26.327), location + scale * vector.New(91.41, 30.26),
        colFn(91.41),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.41, 30.26),
        location + scale * vector.New(91.41, 34.213), location + scale * vector.New(90.91, 37.583),
        location + scale * vector.New(89.91, 40.37), colFn(89.91), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 40.37),
        location + scale * vector.New(88.917, 43.157),
        location + scale * vector.New(87.48, 45.28), location + scale * vector.New(85.6, 46.74),
        colFn(85.6), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.6, 46.74),
        location + scale * vector.New(83.72, 48.2), location + scale * vector.New(81.44, 48.93),
        location + scale * vector.New(78.76, 48.93), colFn(78.76), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 45.03),
        location + scale * vector.New(81.413, 45.03), location + scale * vector.New(83.473, 43.75),
        location + scale * vector.New(84.94, 41.19), colFn(84.94), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(84.94, 41.19),
        location + scale * vector.New(86.407, 38.637),
        location + scale * vector.New(87.14, 34.993), location + scale * vector.New(87.14, 30.26),
        colFn(87.14),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(87.14, 30.26),
        location + scale * vector.New(87.14, 27.107),
        location + scale * vector.New(86.807, 24.423), location + scale * vector.New(86.14, 22.21),
        colFn(86.14), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.14, 22.21),
        location + scale * vector.New(85.473, 19.997),
        location + scale * vector.New(84.517, 18.31), location + scale * vector.New(83.27, 17.15),
        colFn(83.27),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(83.27, 17.15),
        location + scale * vector.New(82.017, 15.99),
        location + scale * vector.New(80.513, 15.41), location + scale * vector.New(78.76, 15.41),
        colFn(78.76),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 15.41),
        location + scale * vector.New(76.133, 15.41),
        location + scale * vector.New(74.08, 16.703), location + scale * vector.New(72.6, 19.29),
        colFn(72.6), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(72.6, 19.29),
        location + scale * vector.New(71.12, 21.877),
        location + scale * vector.New(70.38, 25.533), location + scale * vector.New(70.38, 30.26),
        colFn(70.38),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(70.38, 30.26),
        location + scale * vector.New(70.38, 33.407), location + scale * vector.New(70.713, 36.08),
        location + scale * vector.New(71.38, 38.28), colFn(71.38), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.38, 38.28),
        location + scale * vector.New(72.04, 40.48),
        location + scale * vector.New(72.997, 42.157), location + scale * vector.New(74.25, 43.31),
        colFn(74.25), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.25, 43.31),
        location + scale * vector.New(75.497, 44.457), location + scale * vector.New(77, 45.03),
        location + scale * vector.New(78.76, 45.03), colFn(78.76), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 48.72),
        location + scale * vector.New(100.4, 48.72),
        location + scale * vector.New(99.647, 48.407), location + scale * vector.New(99.02, 47.78),
        colFn(99.02), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 47.78),
        location + scale * vector.New(98.393, 47.153),
        location + scale * vector.New(98.08, 46.403), location + scale * vector.New(98.08, 45.53),
        colFn(98.08), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.08, 45.53),
        location + scale * vector.New(98.08, 44.65),
        location + scale * vector.New(98.393, 43.897), location + scale * vector.New(99.02, 43.27),
        colFn(99.02), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 43.27),
        location + scale * vector.New(99.647, 42.643),
        location + scale * vector.New(100.4, 42.33), location + scale * vector.New(101.28, 42.33),
        colFn(101.28),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 42.33),
        location + scale * vector.New(102.153, 42.33),
        location + scale * vector.New(102.903, 42.643),
        location + scale * vector.New(103.53, 43.27), colFn(103.53), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.53, 43.27),
        location + scale * vector.New(104.157, 43.897),
        location + scale * vector.New(104.47, 44.65), location + scale * vector.New(104.47, 45.53), colFn(104.47),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.47, 45.53), location + scale * vector.New(104.47, 46.11),
        location + scale * vector.New(104.327, 46.64),
        location + scale * vector.New(104.04, 47.12), colFn(104.04), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.04, 47.12),
        location + scale * vector.New(103.747, 47.607),
        location + scale * vector.New(103.363, 47.997),
        location + scale * vector.New(102.89, 48.29), colFn(102.89), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(102.89, 48.29),
        location + scale * vector.New(102.41, 48.577),
        location + scale * vector.New(101.873, 48.72), location + scale * vector.New(101.28, 48.72),
        colFn(101.28),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 48.93),
        location + scale * vector.New(121.117, 48.93),
        location + scale * vector.New(118.84, 48.2),
        location + scale * vector.New(116.96, 46.74), colFn(116.96), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.96, 46.74),
        location + scale * vector.New(115.073, 45.28),
        location + scale * vector.New(113.633, 43.157),
        location + scale * vector.New(112.64, 40.37), colFn(112.64), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.64, 40.37),
        location + scale * vector.New(111.647, 37.583),
        location + scale * vector.New(111.15, 34.213),
        location + scale * vector.New(111.15, 30.26), colFn(111.15), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.15, 30.26),
        location + scale * vector.New(111.15, 26.327),
        location + scale * vector.New(111.65, 22.967),
        location + scale * vector.New(112.65, 20.18), colFn(112.65), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.65, 20.18),
        location + scale * vector.New(113.65, 17.393),
        location + scale * vector.New(115.093, 15.263),
        location + scale * vector.New(116.98, 13.79), colFn(116.98), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.98, 13.79),
        location + scale * vector.New(118.873, 12.317),
        location + scale * vector.New(121.143, 11.58), location + scale * vector.New(123.79, 11.58),
        colFn(123.79),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 11.58),
        location + scale * vector.New(126.443, 11.58),
        location + scale * vector.New(128.713, 12.317), location + scale * vector.New(130.6, 13.79),
        colFn(130.6), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.6, 13.79),
        location + scale * vector.New(132.487, 15.263),
        location + scale * vector.New(133.93, 17.393), location + scale * vector.New(134.93, 20.18),
        colFn(134.93),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(134.93, 20.18),
        location + scale * vector.New(135.93, 22.967),
        location + scale * vector.New(136.43, 26.327), location + scale * vector.New(136.43, 30.26),
        colFn(136.43),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(136.43, 30.26),
        location + scale * vector.New(136.43, 34.213),
        location + scale * vector.New(135.933, 37.583),
        location + scale * vector.New(134.94, 40.37), colFn(134.94), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(134.94, 40.37),
        location + scale * vector.New(133.947, 43.157),
        location + scale * vector.New(132.51, 45.28), location + scale * vector.New(130.63, 46.74),
        colFn(130.63),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.63, 46.74),
        location + scale * vector.New(128.75, 48.2),
        location + scale * vector.New(126.47, 48.93), location + scale * vector.New(123.79, 48.93),
        colFn(123.79),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 45.03),
        location + scale * vector.New(126.443, 45.03),
        location + scale * vector.New(128.503, 43.75), location + scale * vector.New(129.97, 41.19),
        colFn(129.97),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(129.97, 41.19),
        location + scale * vector.New(131.437, 38.637),
        location + scale * vector.New(132.17, 34.993),
        location + scale * vector.New(132.17, 30.26), colFn(132.17), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(132.17, 30.26),
        location + scale * vector.New(132.17, 27.107),
        location + scale * vector.New(131.837, 24.423),
        location + scale * vector.New(131.17, 22.21), colFn(131.17), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(131.17, 22.21),
        location + scale * vector.New(130.503, 19.997),
        location + scale * vector.New(129.543, 18.31), location + scale * vector.New(128.29, 17.15),
        colFn(128.29),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(128.29, 17.15),
        location + scale * vector.New(127.043, 15.99),
        location + scale * vector.New(125.543, 15.41), location + scale * vector.New(123.79, 15.41),
        colFn(123.79),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 15.41),
        location + scale * vector.New(121.163, 15.41),
        location + scale * vector.New(119.11, 16.703),
        location + scale * vector.New(117.63, 19.29), colFn(117.63), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(117.63, 19.29),
        location + scale * vector.New(116.15, 21.877),
        location + scale * vector.New(115.41, 25.533), location + scale * vector.New(115.41, 30.26),
        colFn(115.41),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.41, 30.26),
        location + scale * vector.New(115.41, 33.407),
        location + scale * vector.New(115.743, 36.08), location + scale * vector.New(116.41, 38.28),
        colFn(116.41),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.41, 38.28), location + scale * vector.New(117.07, 40.48),
        location + scale * vector.New(118.023, 42.157),
        location + scale * vector.New(119.27, 43.31), colFn(119.27), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.27, 43.31),
        location + scale * vector.New(120.523, 44.457),
        location + scale * vector.New(122.03, 45.03), location + scale * vector.New(123.79, 45.03), colFn(123.79),
        thickness)
end
