function showPatchNotesV210(lc, rc)
    local bugFixes = {
        'Fixed jump to TG crashing the plugin when not selecting anything.',
        'Fixed importing themes not working properly.',
        'Edit > Lint Map > Merge now merges all TGs simultaneously.',
        'Edit > Lint Map > Fix Flipped LNs now works on all notes in all TGs.',
        'Fixed custom theming tooltip being shown even when already in a custom theme.',
        'Added an option to disable the ko-fi message at the bottom of the info page.',
        'Fixed Still > Per Note Group forcefully overriding final SV.',
        'Added some hints to text inputs.',
        'Fixed niche bug where border color would become a table on hot-reload.',
        'Fixed interactive bezier guide lines not reaching the orbs.',
        'Slightly changed the color of the bezier blue orb.',
        'Set max displacement exponent supremum to 6.',
        'Fixed relative ratio throwing an error when changed.',
        'Fixed the draw function being in the plugin file twice.',
        'Added aster\'s theme to the theming menu.',
    }

    local newFeatures = {
        'Added a deviation parameter to all vibrato functions.',
        'Reworked theming, allowing you to save infinite custom themes.',
        'Added gradients to major version updates.',
        'Now uses displacement exponent supremum as the default.',
        'Added new buttons to the SV Point selector.',
        'Added the ability to clone and delete SVs from the Direct SV menu.',
    }

    showPatchNotesElement('v2.1.0', drawV210, 136, { lc, rc }, bugFixes, newFeatures)
end

---Draws v210 on screen, with dimensions = scale * [136,37].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param thickness integer
function drawV210(ctx, location, scale, thickness)
    location = location - vector.New(68, 24) * scale
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
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44),
        location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24), colFn(29.9), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24),
        location + scale * vector.New(41.9, 32.1), location + scale * vector.New(41.9, 32.1), colFn(41.9), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.9, 32.1), location + scale * vector.New(43.31, 30.56),
        location + scale * vector.New(44.47, 29.22), location + scale * vector.New(45.38, 28.08),
        colFn(45.38),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(45.38, 28.08),
        location + scale * vector.New(46.29, 26.94),
        location + scale * vector.New(46.97, 25.86), location + scale * vector.New(47.42, 24.85),
        colFn(47.42), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.42, 24.85),
        location + scale * vector.New(47.86, 23.84),
        location + scale * vector.New(48.08, 22.77), location + scale * vector.New(48.08, 21.66),
        colFn(48.08), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(48.08, 21.66),
        location + scale * vector.New(48.08, 20.38),
        location + scale * vector.New(47.78, 19.27), location + scale * vector.New(47.17, 18.34),
        colFn(47.17), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.17, 18.34),
        location + scale * vector.New(46.56, 17.41),
        location + scale * vector.New(45.72, 16.69), location + scale * vector.New(44.67, 16.18),
        colFn(44.67), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.67, 16.18),
        location + scale * vector.New(43.62, 15.67),
        location + scale * vector.New(42.43, 15.41), location + scale * vector.New(41.12, 15.41),
        colFn(41.12),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.12, 15.41),
        location + scale * vector.New(39.73, 15.41), location + scale * vector.New(38.51, 15.7),
        location + scale * vector.New(37.47, 16.27), colFn(37.47), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(37.47, 16.27),
        location + scale * vector.New(36.44, 16.84),
        location + scale * vector.New(35.64, 17.65), location + scale * vector.New(35.08, 18.68),
        colFn(35.08),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.08, 18.68),
        location + scale * vector.New(34.51, 19.71),
        location + scale * vector.New(34.23, 20.91), location + scale * vector.New(34.23, 22.3),
        colFn(34.23),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(34.23, 22.3), location + scale * vector.New(34.23, 22.3),
        location + scale * vector.New(30.04, 22.3), location + scale * vector.New(30.04, 22.3), colFn(30.04), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(30.04, 22.3),
        location + scale * vector.New(30.04, 20.17),
        location + scale * vector.New(30.53, 18.30), location + scale * vector.New(31.52, 16.69),
        colFn(31.52), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(31.52, 16.69),
        location + scale * vector.New(32.5, 15.08),
        location + scale * vector.New(33.84, 13.83),
        location + scale * vector.New(35.54, 12.93), colFn(35.54), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.54, 12.93), location + scale * vector.New(37.24, 12.03),
        location + scale * vector.New(39.15, 11.58), location + scale * vector.New(41.26, 11.58),
        colFn(41.26),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.26, 11.58),
        location + scale * vector.New(43.39, 11.58), location + scale * vector.New(45.28, 12.03),
        location + scale * vector.New(46.93, 12.93), colFn(46.93), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(46.93, 12.93),
        location + scale * vector.New(48.58, 13.83),
        location + scale * vector.New(49.87, 15.04), location + scale * vector.New(50.8, 16.57),
        colFn(50.8), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(50.8, 16.57),
        location + scale * vector.New(51.73, 18.1),
        location + scale * vector.New(52.2, 19.79), location + scale * vector.New(52.2, 21.66),
        colFn(52.2), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.2, 21.66), location + scale * vector.New(52.2, 23),
        location + scale * vector.New(51.96, 24.31),
        location + scale * vector.New(51.48, 25.58), colFn(51.48), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(51.48, 25.58),
        location + scale * vector.New(51, 26.85),
        location + scale * vector.New(50.17, 28.27), location + scale * vector.New(49, 29.82),
        colFn(49), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(49, 29.82),
        location + scale * vector.New(47.82, 31.38),
        location + scale * vector.New(46.19, 33.28), location + scale * vector.New(44.11, 35.51),
        colFn(44.11),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.11, 35.51), location + scale * vector.New(44.11, 35.51),
        location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25), colFn(35.94), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25),
        location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53), colFn(35.94), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53),
        location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53), colFn(52.84), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53),
        location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44), colFn(52.84), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44),
        location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44), colFn(29.9), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 48.72),
        location + scale * vector.New(62.41, 48.72),
        location + scale * vector.New(61.66, 48.41),
        location + scale * vector.New(61.03, 47.78), colFn(61.03), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 47.78),
        location + scale * vector.New(60.40, 47.15),
        location + scale * vector.New(60.09, 46.40), location + scale * vector.New(60.09, 45.53),
        colFn(60.09),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(60.09, 45.53), location + scale * vector.New(60.09, 44.65),
        location + scale * vector.New(60.40, 43.9), location + scale * vector.New(61.03, 43.27),
        colFn(61.03), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 43.27),
        location + scale * vector.New(61.66, 42.64),
        location + scale * vector.New(62.41, 42.33), location + scale * vector.New(63.28, 42.33),
        colFn(63.28),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 42.33), location + scale * vector.New(64.16, 42.33),
        location + scale * vector.New(64.91, 42.64), location + scale * vector.New(65.54, 43.27),
        colFn(65.54), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(65.54, 43.27),
        location + scale * vector.New(66.17, 43.9), location + scale * vector.New(66.48, 44.65),
        location + scale * vector.New(66.48, 45.53), colFn(66.48), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.48, 45.53), location + scale * vector.New(66.48, 46.11),
        location + scale * vector.New(66.33, 46.64), location + scale * vector.New(66.04, 47.12),
        colFn(66.04), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.04, 47.12),
        location + scale * vector.New(65.75, 47.61),
        location + scale * vector.New(65.37, 48), location + scale * vector.New(64.89, 48.29),
        colFn(64.89), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(64.89, 48.29),
        location + scale * vector.New(64.41, 48.58), location + scale * vector.New(63.87, 48.72),
        location + scale * vector.New(63.28, 48.72), colFn(63.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.72, 12.07), location + scale * vector.New(86.72, 12.07),
        location + scale * vector.New(86.72, 48.44), location + scale * vector.New(86.72, 48.44), colFn(86.72), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.72, 48.44), location + scale * vector.New(86.72, 48.44),
        location + scale * vector.New(82.32, 48.44), location + scale * vector.New(82.32, 48.44), colFn(82.32), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(82.32, 48.44), location + scale * vector.New(82.32, 48.44),
        location + scale * vector.New(82.32, 16.69), location + scale * vector.New(82.32, 16.69), colFn(82.32), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(82.32, 16.69), location + scale * vector.New(82.32, 16.69),
        location + scale * vector.New(82.1, 16.69), location + scale * vector.New(82.1, 16.69), colFn(82.1), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(82.1, 16.69), location + scale * vector.New(82.1, 16.69),
        location + scale * vector.New(73.22, 22.59), location + scale * vector.New(73.22, 22.59), colFn(73.22), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.22, 22.59), location + scale * vector.New(73.22, 22.59),
        location + scale * vector.New(73.22, 18.11), location + scale * vector.New(73.22, 18.11), colFn(73.22), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.22, 18.11), location + scale * vector.New(73.22, 18.11),
        location + scale * vector.New(82.32, 12.07), location + scale * vector.New(82.32, 12.07), colFn(82.32), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(82.32, 12.07), location + scale * vector.New(82.32, 12.07),
        location + scale * vector.New(86.72, 12.07), location + scale * vector.New(86.72, 12.07), colFn(86.72), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(100.28, 48.72),
        location + scale * vector.New(99.41, 48.72),
        location + scale * vector.New(98.66, 48.41), location + scale * vector.New(98.03, 47.78),
        colFn(98.03), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.03, 47.78),
        location + scale * vector.New(97.40, 47.15),
        location + scale * vector.New(97.09, 46.40), location + scale * vector.New(97.09, 45.53),
        colFn(97.09), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(97.09, 45.53),
        location + scale * vector.New(97.09, 44.65),
        location + scale * vector.New(97.40, 43.9), location + scale * vector.New(98.03, 43.27),
        colFn(98.03), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.03, 43.27),
        location + scale * vector.New(98.66, 42.64),
        location + scale * vector.New(99.41, 42.33), location + scale * vector.New(100.28, 42.33),
        colFn(100.28),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(100.28, 42.33),
        location + scale * vector.New(101.16, 42.33),
        location + scale * vector.New(101.91, 42.64),
        location + scale * vector.New(102.54, 43.27), colFn(102.54), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(102.54, 43.27),
        location + scale * vector.New(103.17, 43.9),
        location + scale * vector.New(103.48, 44.65), location + scale * vector.New(103.48, 45.53),
        colFn(103.48),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.48, 45.53),
        location + scale * vector.New(103.48, 46.11),
        location + scale * vector.New(103.34, 46.64),
        location + scale * vector.New(103.05, 47.12), colFn(103.05), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.05, 47.12),
        location + scale * vector.New(102.76, 47.61),
        location + scale * vector.New(102.37, 48), location + scale * vector.New(101.89, 48.29),
        colFn(101.89),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.89, 48.29),
        location + scale * vector.New(101.41, 48.58),
        location + scale * vector.New(100.87, 48.72), location + scale * vector.New(100.28, 48.72),
        colFn(100.28),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.8, 48.93),
        location + scale * vector.New(120.13, 48.93),
        location + scale * vector.New(117.85, 48.2),
        location + scale * vector.New(115.96, 46.74), colFn(115.96), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.96, 46.74),
        location + scale * vector.New(114.08, 45.28),
        location + scale * vector.New(112.64, 43.16),
        location + scale * vector.New(111.65, 40.37), colFn(111.65), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.65, 40.37),
        location + scale * vector.New(110.66, 37.58),
        location + scale * vector.New(110.16, 34.21), location + scale * vector.New(110.16, 30.26),
        colFn(110.16),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.16, 30.26),
        location + scale * vector.New(110.16, 26.33),
        location + scale * vector.New(110.66, 22.97), location + scale * vector.New(111.66, 20.18),
        colFn(111.66),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.66, 20.18),
        location + scale * vector.New(112.66, 17.39),
        location + scale * vector.New(114.10, 15.26),
        location + scale * vector.New(115.99, 13.79), colFn(115.99), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.99, 13.79),
        location + scale * vector.New(117.88, 12.32),
        location + scale * vector.New(120.15, 11.58), location + scale * vector.New(122.8, 11.58),
        colFn(122.8),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.8, 11.58),
        location + scale * vector.New(125.45, 11.58),
        location + scale * vector.New(127.72, 12.32),
        location + scale * vector.New(129.61, 13.79), colFn(129.61), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(129.61, 13.79),
        location + scale * vector.New(131.5, 15.26),
        location + scale * vector.New(132.94, 17.39), location + scale * vector.New(133.94, 20.18),
        colFn(133.94),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(133.94, 20.18),
        location + scale * vector.New(134.94, 22.97),
        location + scale * vector.New(135.44, 26.33), location + scale * vector.New(135.44, 30.26),
        colFn(135.44),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(135.44, 30.26),
        location + scale * vector.New(135.44, 34.21),
        location + scale * vector.New(134.94, 37.58),
        location + scale * vector.New(133.95, 40.37), colFn(133.95), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(133.95, 40.37),
        location + scale * vector.New(132.96, 43.16),
        location + scale * vector.New(131.52, 45.28),
        location + scale * vector.New(129.63, 46.74), colFn(129.63), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(129.63, 46.74),
        location + scale * vector.New(127.75, 48.2),
        location + scale * vector.New(125.47, 48.93), location + scale * vector.New(122.8, 48.93),
        colFn(122.8), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.8, 45.03),
        location + scale * vector.New(125.45, 45.03),
        location + scale * vector.New(127.51, 43.75), location + scale * vector.New(128.98, 41.19),
        colFn(128.98),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(128.98, 41.19),
        location + scale * vector.New(130.45, 38.64),
        location + scale * vector.New(131.18, 34.99), location + scale * vector.New(131.18, 30.26),
        colFn(131.18),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(131.18, 30.26),
        location + scale * vector.New(131.18, 27.11),
        location + scale * vector.New(130.85, 24.42),
        location + scale * vector.New(130.18, 22.21), colFn(130.18), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.18, 22.21),
        location + scale * vector.New(129.51, 20),
        location + scale * vector.New(128.55, 18.31), location + scale * vector.New(127.3, 17.15),
        colFn(127.3),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(127.3, 17.15),
        location + scale * vector.New(126.05, 15.99),
        location + scale * vector.New(124.55, 15.41), location + scale * vector.New(122.8, 15.41),
        colFn(122.8),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.8, 15.41),
        location + scale * vector.New(120.17, 15.41),
        location + scale * vector.New(118.12, 16.70),
        location + scale * vector.New(116.64, 19.29), colFn(116.64), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.64, 19.29),
        location + scale * vector.New(115.16, 21.88),
        location + scale * vector.New(114.42, 25.53), location + scale * vector.New(114.42, 30.26),
        colFn(114.42),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(114.42, 30.26),
        location + scale * vector.New(114.42, 33.41), location + scale * vector.New(114.75, 36.08),
        location + scale * vector.New(115.41, 38.28), colFn(115.41), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.41, 38.28),
        location + scale * vector.New(116.08, 40.48),
        location + scale * vector.New(117.03, 42.16),
        location + scale * vector.New(118.28, 43.31), colFn(118.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.28, 43.31),
        location + scale * vector.New(119.53, 44.46),
        location + scale * vector.New(121.03, 45.03), location + scale * vector.New(122.8, 45.03),
        colFn(122.8),
        thickness)
end
