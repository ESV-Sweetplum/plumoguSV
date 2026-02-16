function showPatchNotesV112(c)
    local bugFixes = {
        'Fixed stills placing duplicate SVs that changed order when called.',
        'Fixed stills removing non-existent SVs.',
        'Fixed copy/paste priority problems.',
        'Fixed plugin TG selector overriding editor TG selector.',
    }

    local newFeatures = {
        "Now stores settings so you don't have to edit the plugin file to save them.",
        'Added step size to the exponential intensity bar.',
        'Distance fields now allow mathematical expressions\nthat are automatically evaluated.',
        'Created a new advanced mode, which disabling causes less clutter.',
        'Created Edit > Direct SV, an easier way to edit SVs directly within your selection.',
        'Added colors to the TG selector to easily distinguish groups.',
    }

    showPatchNotesElement('v1.1.2', drawV112, 127, c, bugFixes, newFeatures)
end

---Draws v112 on screen, with dimensions = scale * [127,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV112(ctx, location, scale, col, thickness)
    location = location - vector.New(63.5, 24) * scale
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
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07),
        location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44),
        location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44),
        location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69),
        location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69),
        location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59),
        location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11),
        location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07),
        location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 48.72),
        location + scale * vector.New(92.377, 48.72),
        location + scale * vector.New(91.627, 48.407), location + scale * vector.New(91, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 47.78),
        location + scale * vector.New(90.373, 47.153),
        location + scale * vector.New(90.06, 46.403), location + scale * vector.New(90.06, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.06, 45.53), location + scale * vector.New(90.06, 44.65),
        location + scale * vector.New(90.373, 43.897), location + scale * vector.New(91, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 43.27),
        location + scale * vector.New(91.627, 42.643),
        location + scale * vector.New(92.377, 42.33), location + scale * vector.New(93.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 42.33), location + scale * vector.New(94.13, 42.33),
        location + scale * vector.New(94.883, 42.643), location + scale * vector.New(95.51, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.51, 43.27),
        location + scale * vector.New(96.137, 43.897),
        location + scale * vector.New(96.45, 44.65), location + scale * vector.New(96.45, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.45, 45.53),
        location + scale * vector.New(96.45, 46.11),
        location + scale * vector.New(96.303, 46.64), location + scale * vector.New(96.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.01, 47.12),
        location + scale * vector.New(95.723, 47.607),
        location + scale * vector.New(95.34, 47.997), location + scale * vector.New(94.86, 48.29), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.86, 48.29),
        location + scale * vector.New(94.38, 48.577), location + scale * vector.New(93.843, 48.72),
        location + scale * vector.New(93.25, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.91, 48.44), location + scale * vector.New(103.91, 48.44),
        location + scale * vector.New(103.91, 45.24), location + scale * vector.New(103.91, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.91, 45.24), location + scale * vector.New(103.91, 45.24),
        location + scale * vector.New(115.91, 32.1), location + scale * vector.New(115.91, 32.1), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.91, 32.1),
        location + scale * vector.New(117.317, 30.56),
        location + scale * vector.New(118.477, 29.22), location + scale * vector.New(119.39, 28.08), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.39, 28.08),
        location + scale * vector.New(120.303, 26.94),
        location + scale * vector.New(120.98, 25.863),
        location + scale * vector.New(121.42, 24.85), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.42, 24.85),
        location + scale * vector.New(121.867, 23.837),
        location + scale * vector.New(122.09, 22.773), location + scale * vector.New(122.09, 21.66), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.09, 21.66), location + scale * vector.New(122.09, 20.38),
        location + scale * vector.New(121.783, 19.273),
        location + scale * vector.New(121.17, 18.34), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.17, 18.34),
        location + scale * vector.New(120.563, 17.407),
        location + scale * vector.New(119.733, 16.687),
        location + scale * vector.New(118.68, 16.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.68, 16.18),
        location + scale * vector.New(117.627, 15.667),
        location + scale * vector.New(116.443, 15.41), location + scale * vector.New(115.13, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.13, 15.41),
        location + scale * vector.New(113.73, 15.41),
        location + scale * vector.New(112.513, 15.697),
        location + scale * vector.New(111.48, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.48, 16.27),
        location + scale * vector.New(110.447, 16.843),
        location + scale * vector.New(109.647, 17.647),
        location + scale * vector.New(109.08, 18.68), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.08, 18.68),
        location + scale * vector.New(108.52, 19.707),
        location + scale * vector.New(108.24, 20.913), location + scale * vector.New(108.24, 22.3), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.24, 22.3), location + scale * vector.New(108.24, 22.3),
        location + scale * vector.New(104.05, 22.3), location + scale * vector.New(104.05, 22.3), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.05, 22.3),
        location + scale * vector.New(104.05, 20.173),
        location + scale * vector.New(104.54, 18.303),
        location + scale * vector.New(105.52, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.52, 16.69),
        location + scale * vector.New(106.507, 15.083),
        location + scale * vector.New(107.847, 13.83),
        location + scale * vector.New(109.54, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.54, 12.93), location + scale * vector.New(111.24, 12.03),
        location + scale * vector.New(113.15, 11.58), location + scale * vector.New(115.27, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.27, 11.58),
        location + scale * vector.New(117.403, 11.58),
        location + scale * vector.New(119.29, 12.03), location + scale * vector.New(120.93, 12.93), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.93, 12.93),
        location + scale * vector.New(122.577, 13.83),
        location + scale * vector.New(123.867, 15.043),
        location + scale * vector.New(124.8, 16.57), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.8, 16.57),
        location + scale * vector.New(125.74, 18.097),
        location + scale * vector.New(126.21, 19.793),
        location + scale * vector.New(126.21, 21.66), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.21, 21.66),
        location + scale * vector.New(126.21, 23),
        location + scale * vector.New(125.97, 24.307),
        location + scale * vector.New(125.49, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(125.49, 25.58),
        location + scale * vector.New(125.01, 26.853),
        location + scale * vector.New(124.18, 28.267), location + scale * vector.New(123, 29.82),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123, 29.82),
        location + scale * vector.New(121.827, 31.38),
        location + scale * vector.New(120.197, 33.277),
        location + scale * vector.New(118.11, 35.51), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.11, 35.51), location + scale * vector.New(118.11, 35.51),
        location + scale * vector.New(109.94, 44.25), location + scale * vector.New(109.94, 44.25), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.94, 44.25), location + scale * vector.New(109.94, 44.25),
        location + scale * vector.New(109.94, 44.53), location + scale * vector.New(109.94, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.94, 44.53), location + scale * vector.New(109.94, 44.53),
        location + scale * vector.New(126.85, 44.53), location + scale * vector.New(126.85, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.85, 44.53), location + scale * vector.New(126.85, 44.53),
        location + scale * vector.New(126.85, 48.44), location + scale * vector.New(126.85, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.85, 48.44), location + scale * vector.New(126.85, 48.44),
        location + scale * vector.New(103.91, 48.44), location + scale * vector.New(103.91, 48.44), col, thickness)
end
