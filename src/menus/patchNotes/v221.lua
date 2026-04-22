function showPatchNotesV221(lc)
    local bugFixes = {
        'Fixed various menus calling nil function.',
        'Fixed gaussian vibrato crashing the plugin with 0msx deviance.',
        'Fixed old themes not being compatible with new theme parameters.',
    }

    local newFeatures = {}

    local devUpdates = {
        'Changed some anonymous functions to use metalua lambda syntax.',
        'Added back bezier module.',
        'Migrated to != notation instead of ~= notation.',
        'Updated to the latest version of Luaver.',
    }

    showPatchNotesElement('v2.2.1', drawV221, 131, lc, bugFixes, newFeatures, devUpdates)
end

---Draws v221 on screen, with dimensions = scale * {"x":131,"y":37,"tolerance":1e-8}.
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV221(ctx, location, scale, col, thickness)
    location = location - vector.New(65.5, 18.5) * scale
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0.00, 21.16), location + scale * vector.New(0.00, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0.00, 21.16), location + scale * vector.New(0.00, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.90), location + scale * vector.New(12.07, 42.90), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.90), location + scale * vector.New(12.07, 42.90),
        location + scale * vector.New(12.36, 42.90), location + scale * vector.New(12.36, 42.90), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.90), location + scale * vector.New(12.36, 42.90),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.90, 48.44), location + scale * vector.New(29.90, 48.44),
        location + scale * vector.New(29.90, 45.24), location + scale * vector.New(29.90, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.90, 45.24), location + scale * vector.New(29.90, 45.24),
        location + scale * vector.New(41.90, 32.10), location + scale * vector.New(41.90, 32.10), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.90, 32.10), location + scale * vector.New(43.31, 30.56),
        location + scale * vector.New(44.47, 29.22), location + scale * vector.New(45.38, 28.08), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(45.38, 28.08), location + scale * vector.New(46.29, 26.94),
        location + scale * vector.New(46.97, 25.86), location + scale * vector.New(47.42, 24.85), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.42, 24.85), location + scale * vector.New(47.86, 23.84),
        location + scale * vector.New(48.08, 22.77), location + scale * vector.New(48.08, 21.66), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(48.08, 21.66), location + scale * vector.New(48.08, 20.38),
        location + scale * vector.New(47.78, 19.27), location + scale * vector.New(47.17, 18.34), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.17, 18.34), location + scale * vector.New(46.56, 17.41),
        location + scale * vector.New(45.72, 16.69), location + scale * vector.New(44.67, 16.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.67, 16.18), location + scale * vector.New(43.62, 15.67),
        location + scale * vector.New(42.43, 15.41), location + scale * vector.New(41.12, 15.41), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.12, 15.41), location + scale * vector.New(39.73, 15.41),
        location + scale * vector.New(38.51, 15.70), location + scale * vector.New(37.47, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(37.47, 16.27), location + scale * vector.New(36.44, 16.84),
        location + scale * vector.New(35.64, 17.65), location + scale * vector.New(35.08, 18.68), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.08, 18.68), location + scale * vector.New(34.51, 19.71),
        location + scale * vector.New(34.23, 20.91), location + scale * vector.New(34.23, 22.30), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(34.23, 22.30), location + scale * vector.New(34.23, 22.30),
        location + scale * vector.New(30.04, 22.30), location + scale * vector.New(30.04, 22.30), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(30.04, 22.30), location + scale * vector.New(30.04, 20.17),
        location + scale * vector.New(30.53, 18.30), location + scale * vector.New(31.52, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(31.52, 16.69), location + scale * vector.New(32.50, 15.08),
        location + scale * vector.New(33.84, 13.83), location + scale * vector.New(35.54, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.54, 12.93), location + scale * vector.New(37.24, 12.03),
        location + scale * vector.New(39.15, 11.58), location + scale * vector.New(41.26, 11.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.26, 11.58), location + scale * vector.New(43.39, 11.58),
        location + scale * vector.New(45.28, 12.03), location + scale * vector.New(46.93, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(46.93, 12.93), location + scale * vector.New(48.58, 13.83),
        location + scale * vector.New(49.87, 15.04), location + scale * vector.New(50.80, 16.57), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(50.80, 16.57), location + scale * vector.New(51.73, 18.10),
        location + scale * vector.New(52.20, 19.79), location + scale * vector.New(52.20, 21.66), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.20, 21.66), location + scale * vector.New(52.20, 23.00),
        location + scale * vector.New(51.96, 24.31), location + scale * vector.New(51.48, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(51.48, 25.58), location + scale * vector.New(51.00, 26.85),
        location + scale * vector.New(50.17, 28.27), location + scale * vector.New(49.00, 29.82), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(49.00, 29.82), location + scale * vector.New(47.82, 31.38),
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
        location + scale * vector.New(29.90, 48.44), location + scale * vector.New(29.90, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 48.72), location + scale * vector.New(62.41, 48.72),
        location + scale * vector.New(61.66, 48.41), location + scale * vector.New(61.03, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 47.78), location + scale * vector.New(60.40, 47.15),
        location + scale * vector.New(60.09, 46.40), location + scale * vector.New(60.09, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(60.09, 45.53), location + scale * vector.New(60.09, 44.65),
        location + scale * vector.New(60.40, 43.90), location + scale * vector.New(61.03, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 43.27), location + scale * vector.New(61.66, 42.64),
        location + scale * vector.New(62.41, 42.33), location + scale * vector.New(63.28, 42.33), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 42.33), location + scale * vector.New(64.16, 42.33),
        location + scale * vector.New(64.91, 42.64), location + scale * vector.New(65.54, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(65.54, 43.27), location + scale * vector.New(66.17, 43.90),
        location + scale * vector.New(66.48, 44.65), location + scale * vector.New(66.48, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.48, 45.53), location + scale * vector.New(66.48, 46.11),
        location + scale * vector.New(66.33, 46.64), location + scale * vector.New(66.04, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.04, 47.12), location + scale * vector.New(65.75, 47.61),
        location + scale * vector.New(65.37, 48.00), location + scale * vector.New(64.89, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(64.89, 48.29), location + scale * vector.New(64.41, 48.58),
        location + scale * vector.New(63.87, 48.72), location + scale * vector.New(63.28, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.93, 48.44), location + scale * vector.New(73.93, 48.44),
        location + scale * vector.New(73.93, 45.24), location + scale * vector.New(73.93, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.93, 45.24), location + scale * vector.New(73.93, 45.24),
        location + scale * vector.New(85.94, 32.10), location + scale * vector.New(85.94, 32.10), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.94, 32.10), location + scale * vector.New(87.35, 30.56),
        location + scale * vector.New(88.51, 29.22), location + scale * vector.New(89.42, 28.08), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.42, 28.08), location + scale * vector.New(90.33, 26.94),
        location + scale * vector.New(91.00, 25.86), location + scale * vector.New(91.45, 24.85), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.45, 24.85), location + scale * vector.New(91.90, 23.84),
        location + scale * vector.New(92.12, 22.77), location + scale * vector.New(92.12, 21.66), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.12, 21.66), location + scale * vector.New(92.12, 20.38),
        location + scale * vector.New(91.81, 19.27), location + scale * vector.New(91.20, 18.34), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.20, 18.34), location + scale * vector.New(90.59, 17.41),
        location + scale * vector.New(89.76, 16.69), location + scale * vector.New(88.71, 16.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(88.71, 16.18), location + scale * vector.New(87.66, 15.67),
        location + scale * vector.New(86.47, 15.41), location + scale * vector.New(85.16, 15.41), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.16, 15.41), location + scale * vector.New(83.76, 15.41),
        location + scale * vector.New(82.54, 15.70), location + scale * vector.New(81.51, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(81.51, 16.27), location + scale * vector.New(80.47, 16.84),
        location + scale * vector.New(79.67, 17.65), location + scale * vector.New(79.11, 18.68), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.11, 18.68), location + scale * vector.New(78.55, 19.71),
        location + scale * vector.New(78.27, 20.91), location + scale * vector.New(78.27, 22.30), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.27, 22.30), location + scale * vector.New(78.27, 22.30),
        location + scale * vector.New(74.08, 22.30), location + scale * vector.New(74.08, 22.30), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.08, 22.30), location + scale * vector.New(74.08, 20.17),
        location + scale * vector.New(74.57, 18.30), location + scale * vector.New(75.55, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.55, 16.69), location + scale * vector.New(76.53, 15.08),
        location + scale * vector.New(77.87, 13.83), location + scale * vector.New(79.57, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.57, 12.93), location + scale * vector.New(81.27, 12.03),
        location + scale * vector.New(83.18, 11.58), location + scale * vector.New(85.30, 11.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.30, 11.58), location + scale * vector.New(87.43, 11.58),
        location + scale * vector.New(89.31, 12.03), location + scale * vector.New(90.96, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.96, 12.93), location + scale * vector.New(92.61, 13.83),
        location + scale * vector.New(93.90, 15.04), location + scale * vector.New(94.83, 16.57), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.83, 16.57), location + scale * vector.New(95.77, 18.10),
        location + scale * vector.New(96.24, 19.79), location + scale * vector.New(96.24, 21.66), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.24, 21.66), location + scale * vector.New(96.24, 23.00),
        location + scale * vector.New(96.00, 24.31), location + scale * vector.New(95.52, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.52, 25.58), location + scale * vector.New(95.04, 26.85),
        location + scale * vector.New(94.21, 28.27), location + scale * vector.New(93.03, 29.82), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.03, 29.82), location + scale * vector.New(91.85, 31.38),
        location + scale * vector.New(90.22, 33.28), location + scale * vector.New(88.14, 35.51), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(88.14, 35.51), location + scale * vector.New(88.14, 35.51),
        location + scale * vector.New(79.97, 44.25), location + scale * vector.New(79.97, 44.25), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.97, 44.25), location + scale * vector.New(79.97, 44.25),
        location + scale * vector.New(79.97, 44.53), location + scale * vector.New(79.97, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.97, 44.53), location + scale * vector.New(79.97, 44.53),
        location + scale * vector.New(96.88, 44.53), location + scale * vector.New(96.88, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.88, 44.53), location + scale * vector.New(96.88, 44.53),
        location + scale * vector.New(96.88, 48.44), location + scale * vector.New(96.88, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.88, 48.44), location + scale * vector.New(96.88, 48.44),
        location + scale * vector.New(73.93, 48.44), location + scale * vector.New(73.93, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(107.32, 48.72), location + scale * vector.New(106.44, 48.72),
        location + scale * vector.New(105.69, 48.41), location + scale * vector.New(105.06, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.06, 47.78), location + scale * vector.New(104.43, 47.15),
        location + scale * vector.New(104.12, 46.40), location + scale * vector.New(104.12, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.12, 45.53), location + scale * vector.New(104.12, 44.65),
        location + scale * vector.New(104.43, 43.90), location + scale * vector.New(105.06, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.06, 43.27), location + scale * vector.New(105.69, 42.64),
        location + scale * vector.New(106.44, 42.33), location + scale * vector.New(107.32, 42.33), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(107.32, 42.33), location + scale * vector.New(108.19, 42.33),
        location + scale * vector.New(108.94, 42.64), location + scale * vector.New(109.57, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.57, 43.27), location + scale * vector.New(110.20, 43.90),
        location + scale * vector.New(110.51, 44.65), location + scale * vector.New(110.51, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.51, 45.53), location + scale * vector.New(110.51, 46.11),
        location + scale * vector.New(110.37, 46.64), location + scale * vector.New(110.08, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.08, 47.12), location + scale * vector.New(109.79, 47.61),
        location + scale * vector.New(109.40, 48.00), location + scale * vector.New(108.92, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.92, 48.29), location + scale * vector.New(108.44, 48.58),
        location + scale * vector.New(107.91, 48.72), location + scale * vector.New(107.32, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.75, 12.07), location + scale * vector.New(130.75, 12.07),
        location + scale * vector.New(130.75, 48.44), location + scale * vector.New(130.75, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.75, 48.44), location + scale * vector.New(130.75, 48.44),
        location + scale * vector.New(126.35, 48.44), location + scale * vector.New(126.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.35, 48.44), location + scale * vector.New(126.35, 48.44),
        location + scale * vector.New(126.35, 16.69), location + scale * vector.New(126.35, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.35, 16.69), location + scale * vector.New(126.35, 16.69),
        location + scale * vector.New(126.14, 16.69), location + scale * vector.New(126.14, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.14, 16.69), location + scale * vector.New(126.14, 16.69),
        location + scale * vector.New(117.26, 22.59), location + scale * vector.New(117.26, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(117.26, 22.59), location + scale * vector.New(117.26, 22.59),
        location + scale * vector.New(117.26, 18.11), location + scale * vector.New(117.26, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(117.26, 18.11), location + scale * vector.New(117.26, 18.11),
        location + scale * vector.New(126.35, 12.07), location + scale * vector.New(126.35, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.35, 12.07), location + scale * vector.New(126.35, 12.07),
        location + scale * vector.New(130.75, 12.07), location + scale * vector.New(130.75, 12.07), col, thickness)
end
