function showPatchNotesV111(c)
    local bugFixes = {
        'Fixed more bugs involving stills.',
    }

    local newFeatures = {
        'Added a new hotkey to quickly place SSFs.',
        'Added a new TG selector.',
    }

    showPatchNotesElement('v1.1.1', drawV111, 111, c, bugFixes, newFeatures)
end

---Draws v111 on screen, with dimensions = scale * [111,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV111(ctx, location, scale, col, thickness)
    location = location - vector.New(55.5, 24) * scale
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
    ctx.AddBezierCubic(location + scale * vector.New(116.69, 12.07), location + scale * vector.New(116.69, 12.07),
        location + scale * vector.New(116.69, 48.44), location + scale * vector.New(116.69, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.69, 48.44), location + scale * vector.New(116.69, 48.44),
        location + scale * vector.New(112.29, 48.44), location + scale * vector.New(112.29, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.29, 48.44), location + scale * vector.New(112.29, 48.44),
        location + scale * vector.New(112.29, 16.69), location + scale * vector.New(112.29, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.29, 16.69), location + scale * vector.New(112.29, 16.69),
        location + scale * vector.New(112.07, 16.69), location + scale * vector.New(112.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.07, 16.69), location + scale * vector.New(112.07, 16.69),
        location + scale * vector.New(103.2, 22.59), location + scale * vector.New(103.2, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.2, 22.59), location + scale * vector.New(103.2, 22.59),
        location + scale * vector.New(103.2, 18.11), location + scale * vector.New(103.2, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.2, 18.11), location + scale * vector.New(103.2, 18.11),
        location + scale * vector.New(112.29, 12.07), location + scale * vector.New(112.29, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.29, 12.07), location + scale * vector.New(112.29, 12.07),
        location + scale * vector.New(116.69, 12.07), location + scale * vector.New(116.69, 12.07), col, thickness)
end
