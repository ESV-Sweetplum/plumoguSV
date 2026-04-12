function showPatchNotesV220(lc, rc)
    local bugFixes = {
        'Fixed the preset menu incorerctly rendering.',
        'Fixed the preset menu being unable to receive negative numbers.',
        'Fixed recompilation bug with the aho-corasick algorithm.',
        'Now correctly seeds the math module to ensure purely random results.',
        'Fixed the dust trail being entirely white.',
        'Fixed the plugin executing actions accidentally while an input is being edited.',
        'Fixed some custom theme parameters not correctly saving.',
        'Fixed some tabs not being openable when the preset menu was opened.',
        'Fixed scientific notation not being supported in the table parser.',
        'Fixed several hot-reload fails due to nonexistent globals.',
        'Updated timing group listener to correctly listen to batch arguments.',
    }

    local newFeatures = {
        'Added an error protector against faulty table parse attempts.',
        'Drastically reduced the size of the repository with sparse checkouts.',
        'Added a link to the plugin Discord.',
        'Updated the preset menu to use the imgui tabular API.',
        'Added the ability to use average SV targets for linear SV/SSF.',
        'Added a NONE option to final SV, which will omit the final SV/SSF no matter what.',
        'Added an alert when conflicting hotkeys are bound.',
        'Updated the keybinds settings menu to be more organized.',
        'Added the ability to have preset keybinds.',
        "Added capybara mode for those who don't make SV.",
    }

    local devUpdates = {
        'Moved the entire plugin over to Luaver2.',
        'Migrated from TypeScript 5 to TypeScript 6.',
        'Introduced several new packages to facilitate string processors.',
        'Moved packages folder to separate qua specific submodule.',
        'Changed a bit of naming to make things more clear.',
        'Finalized QParcel submodule.',
    }

    showPatchNotesElement('v2.2.0', drawV220, 142, { lc, rc }, bugFixes, newFeatures, devUpdates)
end

-- Replaced    vector.New\(([0-9\.]+), ([0-9\.]+)\), col
-- with        vector.New($1, $2), colFn($1)

---Draws v220 on screen, with dimensions = scale * [142, 37].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param thickness integer
function drawV220(ctx, location, scale, thickness)
    location = location - vector.New(71, 18.5) * scale
    local lightnessAdjust = (state.UnixTime % 2400) / 1200 * math.pi
    local colFn = |x| color.vrgbaToUint(color.hslaToRgba(x + 200, 1, math.sin(lightnessAdjust + x / 20) / 5 + 0.67, 1))

    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), colFn(14.35), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), colFn(10.09), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0.00, 21.16), location + scale * vector.New(0.00, 21.16), colFn(0.00), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0.00, 21.16), location + scale * vector.New(0.00, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), colFn(4.55), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.90), location + scale * vector.New(12.07, 42.90), colFn(12.07), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.90), location + scale * vector.New(12.07, 42.90),
        location + scale * vector.New(12.36, 42.90), location + scale * vector.New(12.36, 42.90), colFn(12.36), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.90), location + scale * vector.New(12.36, 42.90),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), colFn(19.89), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), colFn(24.43), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.90, 48.44), location + scale * vector.New(29.90, 48.44),
        location + scale * vector.New(29.90, 45.24), location + scale * vector.New(29.90, 45.24), colFn(29.90), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.90, 45.24), location + scale * vector.New(29.90, 45.24),
        location + scale * vector.New(41.90, 32.10), location + scale * vector.New(41.90, 32.10), colFn(41.90), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.90, 32.10), location + scale * vector.New(43.31, 30.56),
        location + scale * vector.New(44.47, 29.22), location + scale * vector.New(45.38, 28.08), colFn(45.38), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(45.38, 28.08), location + scale * vector.New(46.29, 26.94),
        location + scale * vector.New(46.97, 25.86), location + scale * vector.New(47.42, 24.85), colFn(47.42), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.42, 24.85), location + scale * vector.New(47.86, 23.84),
        location + scale * vector.New(48.08, 22.77), location + scale * vector.New(48.08, 21.66), colFn(48.08), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(48.08, 21.66), location + scale * vector.New(48.08, 20.38),
        location + scale * vector.New(47.78, 19.27), location + scale * vector.New(47.17, 18.34), colFn(47.17), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.17, 18.34), location + scale * vector.New(46.56, 17.41),
        location + scale * vector.New(45.72, 16.69), location + scale * vector.New(44.67, 16.18), colFn(44.67), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.67, 16.18), location + scale * vector.New(43.62, 15.67),
        location + scale * vector.New(42.43, 15.41), location + scale * vector.New(41.12, 15.41), colFn(41.12), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.12, 15.41), location + scale * vector.New(39.73, 15.41),
        location + scale * vector.New(38.51, 15.70), location + scale * vector.New(37.47, 16.27), colFn(37.47), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(37.47, 16.27), location + scale * vector.New(36.44, 16.84),
        location + scale * vector.New(35.64, 17.65), location + scale * vector.New(35.08, 18.68), colFn(35.08), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.08, 18.68), location + scale * vector.New(34.51, 19.71),
        location + scale * vector.New(34.23, 20.91), location + scale * vector.New(34.23, 22.30), colFn(34.23), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(34.23, 22.30), location + scale * vector.New(34.23, 22.30),
        location + scale * vector.New(30.04, 22.30), location + scale * vector.New(30.04, 22.30), colFn(30.04), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(30.04, 22.30), location + scale * vector.New(30.04, 20.17),
        location + scale * vector.New(30.53, 18.30), location + scale * vector.New(31.52, 16.69), colFn(31.52), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(31.52, 16.69), location + scale * vector.New(32.50, 15.08),
        location + scale * vector.New(33.84, 13.83), location + scale * vector.New(35.54, 12.93), colFn(35.54), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.54, 12.93), location + scale * vector.New(37.24, 12.03),
        location + scale * vector.New(39.15, 11.58), location + scale * vector.New(41.26, 11.58), colFn(41.26), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.26, 11.58), location + scale * vector.New(43.39, 11.58),
        location + scale * vector.New(45.28, 12.03), location + scale * vector.New(46.93, 12.93), colFn(46.93), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(46.93, 12.93), location + scale * vector.New(48.58, 13.83),
        location + scale * vector.New(49.87, 15.04), location + scale * vector.New(50.80, 16.57), colFn(50.80), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(50.80, 16.57), location + scale * vector.New(51.73, 18.10),
        location + scale * vector.New(52.20, 19.79), location + scale * vector.New(52.20, 21.66), colFn(52.20), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.20, 21.66), location + scale * vector.New(52.20, 23.00),
        location + scale * vector.New(51.96, 24.31), location + scale * vector.New(51.48, 25.58), colFn(51.48), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(51.48, 25.58), location + scale * vector.New(51.00, 26.85),
        location + scale * vector.New(50.17, 28.27), location + scale * vector.New(49.00, 29.82), colFn(49.00), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(49.00, 29.82), location + scale * vector.New(47.82, 31.38),
        location + scale * vector.New(46.19, 33.28), location + scale * vector.New(44.11, 35.51), colFn(44.11), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.11, 35.51), location + scale * vector.New(44.11, 35.51),
        location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25), colFn(35.94), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25),
        location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53), colFn(35.94), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53),
        location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53), colFn(52.84), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53),
        location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44), colFn(52.84), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44),
        location + scale * vector.New(29.90, 48.44), location + scale * vector.New(29.90, 48.44), colFn(29.90), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 48.72), location + scale * vector.New(62.41, 48.72),
        location + scale * vector.New(61.66, 48.41), location + scale * vector.New(61.03, 47.78), colFn(61.03), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 47.78), location + scale * vector.New(60.40, 47.15),
        location + scale * vector.New(60.09, 46.40), location + scale * vector.New(60.09, 45.53), colFn(60.09), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(60.09, 45.53), location + scale * vector.New(60.09, 44.65),
        location + scale * vector.New(60.40, 43.90), location + scale * vector.New(61.03, 43.27), colFn(61.03), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 43.27), location + scale * vector.New(61.66, 42.64),
        location + scale * vector.New(62.41, 42.33), location + scale * vector.New(63.28, 42.33), colFn(63.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 42.33), location + scale * vector.New(64.16, 42.33),
        location + scale * vector.New(64.91, 42.64), location + scale * vector.New(65.54, 43.27), colFn(65.54), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(65.54, 43.27), location + scale * vector.New(66.17, 43.90),
        location + scale * vector.New(66.48, 44.65), location + scale * vector.New(66.48, 45.53), colFn(66.48), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.48, 45.53), location + scale * vector.New(66.48, 46.11),
        location + scale * vector.New(66.33, 46.64), location + scale * vector.New(66.04, 47.12), colFn(66.04), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.04, 47.12), location + scale * vector.New(65.75, 47.61),
        location + scale * vector.New(65.37, 48.00), location + scale * vector.New(64.89, 48.29), colFn(64.89), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(64.89, 48.29), location + scale * vector.New(64.41, 48.58),
        location + scale * vector.New(63.87, 48.72), location + scale * vector.New(63.28, 48.72), colFn(63.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.93, 48.44), location + scale * vector.New(73.93, 48.44),
        location + scale * vector.New(73.93, 45.24), location + scale * vector.New(73.93, 45.24), colFn(73.93), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.93, 45.24), location + scale * vector.New(73.93, 45.24),
        location + scale * vector.New(85.94, 32.10), location + scale * vector.New(85.94, 32.10), colFn(85.94), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.94, 32.10), location + scale * vector.New(87.35, 30.56),
        location + scale * vector.New(88.51, 29.22), location + scale * vector.New(89.42, 28.08), colFn(89.42), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.42, 28.08), location + scale * vector.New(90.33, 26.94),
        location + scale * vector.New(91.00, 25.86), location + scale * vector.New(91.45, 24.85), colFn(91.45), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.45, 24.85), location + scale * vector.New(91.90, 23.84),
        location + scale * vector.New(92.12, 22.77), location + scale * vector.New(92.12, 21.66), colFn(92.12), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.12, 21.66), location + scale * vector.New(92.12, 20.38),
        location + scale * vector.New(91.81, 19.27), location + scale * vector.New(91.20, 18.34), colFn(91.20), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.20, 18.34), location + scale * vector.New(90.59, 17.41),
        location + scale * vector.New(89.76, 16.69), location + scale * vector.New(88.71, 16.18), colFn(88.71), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(88.71, 16.18), location + scale * vector.New(87.66, 15.67),
        location + scale * vector.New(86.47, 15.41), location + scale * vector.New(85.16, 15.41), colFn(85.16), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.16, 15.41), location + scale * vector.New(83.76, 15.41),
        location + scale * vector.New(82.54, 15.70), location + scale * vector.New(81.51, 16.27), colFn(81.51), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(81.51, 16.27), location + scale * vector.New(80.47, 16.84),
        location + scale * vector.New(79.67, 17.65), location + scale * vector.New(79.11, 18.68), colFn(79.11), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.11, 18.68), location + scale * vector.New(78.55, 19.71),
        location + scale * vector.New(78.27, 20.91), location + scale * vector.New(78.27, 22.30), colFn(78.27), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.27, 22.30), location + scale * vector.New(78.27, 22.30),
        location + scale * vector.New(74.08, 22.30), location + scale * vector.New(74.08, 22.30), colFn(74.08), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.08, 22.30), location + scale * vector.New(74.08, 20.17),
        location + scale * vector.New(74.57, 18.30), location + scale * vector.New(75.55, 16.69), colFn(75.55), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.55, 16.69), location + scale * vector.New(76.53, 15.08),
        location + scale * vector.New(77.87, 13.83), location + scale * vector.New(79.57, 12.93), colFn(79.57), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.57, 12.93), location + scale * vector.New(81.27, 12.03),
        location + scale * vector.New(83.18, 11.58), location + scale * vector.New(85.30, 11.58), colFn(85.30), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.30, 11.58), location + scale * vector.New(87.43, 11.58),
        location + scale * vector.New(89.31, 12.03), location + scale * vector.New(90.96, 12.93), colFn(90.96), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.96, 12.93), location + scale * vector.New(92.61, 13.83),
        location + scale * vector.New(93.90, 15.04), location + scale * vector.New(94.83, 16.57), colFn(94.83), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.83, 16.57), location + scale * vector.New(95.77, 18.10),
        location + scale * vector.New(96.24, 19.79), location + scale * vector.New(96.24, 21.66), colFn(96.24), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.24, 21.66), location + scale * vector.New(96.24, 23.00),
        location + scale * vector.New(96.00, 24.31), location + scale * vector.New(95.52, 25.58), colFn(95.52), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.52, 25.58), location + scale * vector.New(95.04, 26.85),
        location + scale * vector.New(94.21, 28.27), location + scale * vector.New(93.03, 29.82), colFn(93.03), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.03, 29.82), location + scale * vector.New(91.85, 31.38),
        location + scale * vector.New(90.22, 33.28), location + scale * vector.New(88.14, 35.51), colFn(88.14), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(88.14, 35.51), location + scale * vector.New(88.14, 35.51),
        location + scale * vector.New(79.97, 44.25), location + scale * vector.New(79.97, 44.25), colFn(79.97), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.97, 44.25), location + scale * vector.New(79.97, 44.25),
        location + scale * vector.New(79.97, 44.53), location + scale * vector.New(79.97, 44.53), colFn(79.97), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.97, 44.53), location + scale * vector.New(79.97, 44.53),
        location + scale * vector.New(96.88, 44.53), location + scale * vector.New(96.88, 44.53), colFn(96.88), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.88, 44.53), location + scale * vector.New(96.88, 44.53),
        location + scale * vector.New(96.88, 48.44), location + scale * vector.New(96.88, 48.44), colFn(96.88), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.88, 48.44), location + scale * vector.New(96.88, 48.44),
        location + scale * vector.New(73.93, 48.44), location + scale * vector.New(73.93, 48.44), colFn(73.93), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(107.32, 48.72), location + scale * vector.New(106.44, 48.72),
        location + scale * vector.New(105.69, 48.41), location + scale * vector.New(105.06, 47.78), colFn(105.06),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.06, 47.78), location + scale * vector.New(104.43, 47.15),
        location + scale * vector.New(104.12, 46.40), location + scale * vector.New(104.12, 45.53), colFn(104.12),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.12, 45.53), location + scale * vector.New(104.12, 44.65),
        location + scale * vector.New(104.43, 43.90), location + scale * vector.New(105.06, 43.27), colFn(105.06),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.06, 43.27), location + scale * vector.New(105.69, 42.64),
        location + scale * vector.New(106.44, 42.33), location + scale * vector.New(107.32, 42.33), colFn(107.32),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(107.32, 42.33), location + scale * vector.New(108.19, 42.33),
        location + scale * vector.New(108.94, 42.64), location + scale * vector.New(109.57, 43.27), colFn(109.57),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.57, 43.27), location + scale * vector.New(110.20, 43.90),
        location + scale * vector.New(110.51, 44.65), location + scale * vector.New(110.51, 45.53), colFn(110.51),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.51, 45.53), location + scale * vector.New(110.51, 46.11),
        location + scale * vector.New(110.37, 46.64), location + scale * vector.New(110.08, 47.12), colFn(110.08),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.08, 47.12), location + scale * vector.New(109.79, 47.61),
        location + scale * vector.New(109.40, 48.00), location + scale * vector.New(108.92, 48.29), colFn(108.92),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.92, 48.29), location + scale * vector.New(108.44, 48.58),
        location + scale * vector.New(107.91, 48.72), location + scale * vector.New(107.32, 48.72), colFn(107.32),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(129.83, 48.93), location + scale * vector.New(127.16, 48.93),
        location + scale * vector.New(124.88, 48.20), location + scale * vector.New(122.99, 46.74), colFn(122.99),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.99, 46.74), location + scale * vector.New(121.11, 45.28),
        location + scale * vector.New(119.67, 43.16), location + scale * vector.New(118.68, 40.37), colFn(118.68),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.68, 40.37), location + scale * vector.New(117.69, 37.58),
        location + scale * vector.New(117.19, 34.21), location + scale * vector.New(117.19, 30.26), colFn(117.19),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(117.19, 30.26), location + scale * vector.New(117.19, 26.33),
        location + scale * vector.New(117.69, 22.97), location + scale * vector.New(118.69, 20.18), colFn(118.69),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.69, 20.18), location + scale * vector.New(119.69, 17.39),
        location + scale * vector.New(121.13, 15.26), location + scale * vector.New(123.02, 13.79), colFn(123.02),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.02, 13.79), location + scale * vector.New(124.91, 12.32),
        location + scale * vector.New(127.18, 11.58), location + scale * vector.New(129.83, 11.58), colFn(129.83),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(129.83, 11.58), location + scale * vector.New(132.48, 11.58),
        location + scale * vector.New(134.75, 12.32), location + scale * vector.New(136.64, 13.79), colFn(136.64),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(136.64, 13.79), location + scale * vector.New(138.53, 15.26),
        location + scale * vector.New(139.97, 17.39), location + scale * vector.New(140.97, 20.18), colFn(140.97),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(140.97, 20.18), location + scale * vector.New(141.97, 22.97),
        location + scale * vector.New(142.47, 26.33), location + scale * vector.New(142.47, 30.26), colFn(142.47),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(142.47, 30.26), location + scale * vector.New(142.47, 34.21),
        location + scale * vector.New(141.97, 37.58), location + scale * vector.New(140.98, 40.37), colFn(140.98),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(140.98, 40.37), location + scale * vector.New(139.99, 43.16),
        location + scale * vector.New(138.55, 45.28), location + scale * vector.New(136.67, 46.74), colFn(136.67),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(136.67, 46.74), location + scale * vector.New(134.78, 48.20),
        location + scale * vector.New(132.50, 48.93), location + scale * vector.New(129.83, 48.93), colFn(129.83),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(129.83, 45.03), location + scale * vector.New(132.48, 45.03),
        location + scale * vector.New(134.54, 43.75), location + scale * vector.New(136.01, 41.19), colFn(136.01),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(136.01, 41.19), location + scale * vector.New(137.48, 38.64),
        location + scale * vector.New(138.21, 34.99), location + scale * vector.New(138.21, 30.26), colFn(138.21),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(138.21, 30.26), location + scale * vector.New(138.21, 27.11),
        location + scale * vector.New(137.88, 24.42), location + scale * vector.New(137.21, 22.21), colFn(137.21),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137.21, 22.21), location + scale * vector.New(136.54, 20.00),
        location + scale * vector.New(135.58, 18.31), location + scale * vector.New(134.33, 17.15), colFn(134.33),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(134.33, 17.15), location + scale * vector.New(133.08, 15.99),
        location + scale * vector.New(131.58, 15.41), location + scale * vector.New(129.83, 15.41), colFn(129.83),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(129.83, 15.41), location + scale * vector.New(127.20, 15.41),
        location + scale * vector.New(125.15, 16.70), location + scale * vector.New(123.67, 19.29), colFn(123.67),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.67, 19.29), location + scale * vector.New(122.19, 21.88),
        location + scale * vector.New(121.45, 25.53), location + scale * vector.New(121.45, 30.26), colFn(121.45),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.45, 30.26), location + scale * vector.New(121.45, 33.41),
        location + scale * vector.New(121.78, 36.08), location + scale * vector.New(122.44, 38.28), colFn(122.44),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.44, 38.28), location + scale * vector.New(123.11, 40.48),
        location + scale * vector.New(124.06, 42.16), location + scale * vector.New(125.31, 43.31), colFn(125.31),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(125.31, 43.31), location + scale * vector.New(126.56, 44.46),
        location + scale * vector.New(128.06, 45.03), location + scale * vector.New(129.83, 45.03), colFn(129.83),
        thickness)
end
