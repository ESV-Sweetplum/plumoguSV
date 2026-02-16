function showPatchNotesV200(lc, rc)
    local bugFixes = {
        'Fixed not being able to properly store some cursor trail parameters.',
        'Fixed start/end expo using incorrect algorithm.',
        'Fixed all bugs relating to automate.',
        'Removed v1.1.2 temporary bug fix.',
        'Fix direct SV pagination not working correctly.',
        'Fixed flicker percentage not accurately converting to map.',
        'Fixed align timing lines not being deterministic.',
        'Fixed suffix of computableInputFloat.',
        'Fixed inconsistency of negative/positive SV generation.',
        'Fixed getRemovableSVs to use tolerance.',
        'Fixed the builder not properly nesting files.',
        'Fixed stills placing duplicate SVs.',
        'Fixed internal documentation being incorrect and generally poor.',
        'Fixed several overlapping SV issues.',
        'Fixed hypothetical SVs using some weird BS.',
        'Removed splitscroll in favor of using TGs.',
        'Fixed TG selector being unable to properly select some TGs.',
        'Fixed TG selector not always being fully in-sync with the game.',
        'Fixed automate altering SV post-effect.',
        'Fixed 2-side vibrato inaccuracy.',
        'Fixed build script to use correct regex.',
        'Fixed cursor trail being broken.',
        'Fixed hotkey settings window having overlapping text.',
        'Fixed global vars being unable to default to true.',
        'Moved workspace settings to .luarc file.',
        'Cached variables are properly reloaded during hot-reload.',
        'Fixed bug where hot-reloading would crash the game.',
        'Fixed starting fresh plugin with no config.yaml breaking style.',
        'Fixed bug where string ending of pluralized content\ncarried over between function calls.',
        'Fixed vibrato placing duplicate SVs.',
        'Fixed still per note group finally.',
        'Now properly instantiates pulse color.',
        'Fixed relative ratio not saving.',
        'Fixed Still per note group displacements, and enabled auto/otua on the \naforementioned feature.',
        'Fixed Select Bookmark crashing the game.',
        'Fixed Select Bookmark text going off the screen.',
        'Fixed measure msx widget not rendering in real time, and not\nproperly recalculating distances when switching TGs.',
        "Fixed bug where saving a false setting wouldn't save it at all.",
        "Fixed bug with certain functions where LN ends would not be\nconsidered if their start wasn't within the selection.",
    }

    local newFeatures = {
        'Added tooltips to various functions to explain their functionality.',
        'New border pulse feature that pulses along with the beat.',
        'Added a new hotkey to select the TG of note(s).',
        'New menu: Edit > Convert SV <-> SSF; Self-explanatory.',
        'Added vibrato to plumoguSV, with less error than AFFINE. Includes linear,\npolynomial, exponential, sinusoidal, and sigmoidal shapes. Includes presets for FPS.',
        'Include code-based SV/SSF fast place.',
        'New settings menu with many more customizable features.',
        'Allow defaults to be edited.',
        'Include some new automate parameters for further customization.',
        'Edit > Layer Snaps feature: Save your snap colors before using AFFINE to\nbring them back easily.',
        'Edit > Split feature: Split notes into different TGs with the\nsurrounding SVs in one click.',
        'Added linear equalizer to allow you to create 0x SV on linear much easier.',
        'Added custom theme input, along with exporting/importing.',
        'Added 3 custom reactive backgrounds. More will be added\nwhen the kofi products are paid for.',
        'Added copy paste slots; now you can copy paste more than one thing at once.',
        'Allow border pulse to be custom.',
        "Note lock feature: you don't need to worry about accidentally placing,\nmoving, or deleting notes during SV generation.",
        'Now allows certain inputs to be computed automatically on the backend.',
        'A new performance mode to speed up the FPS by 2-3x.',
        'You can now merge SSFs to eliminate duped ones.',
        'Added new option to allow combo-select.',
        'New toggleable SV Info visualizer for the more inexperienced mappers.',
        'Reworked bezier menu to be much more intuitive.',
        'Added loadup animation because why not.',
        'Added patch notes page.',
        'Added map stats button to quickly grab SV and SSF count.',
        'Added pagination to bookmarks.',
        'Now allowed Direct SV to view SVs around a particular note.',
        'Moved many linting features to Edit > Lint Map.',
        'Added new feature to remove duplicated notes.',
        "Added new feature to remove hitsounds, for mappers who don't use\nthem but accidentally click on the menu.",
        'Added a very rudimentary preset system, so you can send menu data to others.',
        'Added a button to directly swap SVs and SSFs.',
        'Added a startup animation.',
        'Added hotkeys to switch between TGs.',
        'Added hotkey to move all selected notes to the selected TG.',
    }

    showPatchNotesElement('v2.0.0', drawV200, 144, { lc, rc }, bugFixes, newFeatures)
end

---Draws v200 on screen, with dimensions = scale * [144,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param thickness integer
function drawV200(ctx, location, scale, thickness)
    location = location - vector.New(72, 24) * scale
    local hueDegreeAdjust = (state.UnixTime % 7200) / 20 + 67
    local colFn = function(x)
        return color.vrgbaToUint(color.hslaToRgba(x + hueDegreeAdjust, 1, 0.7, 1))
    end
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        colFn(14.35), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        colFn(10.09), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        colFn(0), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        colFn(4.55), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        colFn(12.07), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        colFn(12.36), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        colFn(19.89), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        colFn(24.43), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44),
        location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24),
        colFn(29.9), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24),
        location + scale * vector.New(41.9, 32.1), location + scale * vector.New(41.9, 32.1),
        colFn(41.9), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.9, 32.1), location + scale * vector.New(43.313, 30.56),
        location + scale * vector.New(44.473, 29.22), location + scale * vector.New(45.38, 28.08),
        colFn(45.38),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(45.38, 28.08),
        location + scale * vector.New(46.293, 26.94),
        location + scale * vector.New(46.973, 25.863), location + scale * vector.New(47.42, 24.85),
        colFn(47.42), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.42, 24.85),
        location + scale * vector.New(47.86, 23.837),
        location + scale * vector.New(48.08, 22.773), location + scale * vector.New(48.08, 21.66),
        colFn(48.08), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(48.08, 21.66),
        location + scale * vector.New(48.08, 20.38),
        location + scale * vector.New(47.777, 19.273), location + scale * vector.New(47.17, 18.34),
        colFn(47.17), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.17, 18.34),
        location + scale * vector.New(46.557, 17.407),
        location + scale * vector.New(45.723, 16.687), location + scale * vector.New(44.67, 16.18),
        colFn(44.67), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.67, 16.18),
        location + scale * vector.New(43.617, 15.667),
        location + scale * vector.New(42.433, 15.41), location + scale * vector.New(41.12, 15.41),
        colFn(41.12),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.12, 15.41),
        location + scale * vector.New(39.727, 15.41), location + scale * vector.New(38.51, 15.697),
        location + scale * vector.New(37.47, 16.27),
        colFn(37.47), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(37.47, 16.27),
        location + scale * vector.New(36.437, 16.843),
        location + scale * vector.New(35.64, 17.647), location + scale * vector.New(35.08, 18.68),
        colFn(35.08),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.08, 18.68),
        location + scale * vector.New(34.513, 19.707),
        location + scale * vector.New(34.23, 20.913), location + scale * vector.New(34.23, 22.3),
        colFn(34.23),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(34.23, 22.3), location + scale * vector.New(34.23, 22.3),
        location + scale * vector.New(30.04, 22.3), location + scale * vector.New(30.04, 22.3),
        colFn(30.04), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(30.04, 22.3),
        location + scale * vector.New(30.04, 20.173),
        location + scale * vector.New(30.533, 18.303), location + scale * vector.New(31.52, 16.69),
        colFn(31.52), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(31.52, 16.69),
        location + scale * vector.New(32.5, 15.083),
        location + scale * vector.New(33.84, 13.83),
        location + scale * vector.New(35.54, 12.93),
        colFn(35.54), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.54, 12.93), location + scale * vector.New(37.24, 12.03),
        location + scale * vector.New(39.147, 11.58), location + scale * vector.New(41.26, 11.58),
        colFn(41.26),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.26, 11.58),
        location + scale * vector.New(43.393, 11.58), location + scale * vector.New(45.283, 12.03),
        location + scale * vector.New(46.93, 12.93),
        colFn(46.93), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(46.93, 12.93),
        location + scale * vector.New(48.577, 13.83),
        location + scale * vector.New(49.867, 15.043), location + scale * vector.New(50.8, 16.57),
        colFn(50.8), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(50.8, 16.57),
        location + scale * vector.New(51.733, 18.097),
        location + scale * vector.New(52.2, 19.793), location + scale * vector.New(52.2, 21.66),
        colFn(52.2), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.2, 21.66), location + scale * vector.New(52.2, 23),
        location + scale * vector.New(51.96, 24.307),
        location + scale * vector.New(51.48, 25.58),
        colFn(51.48), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(51.48, 25.58),
        location + scale * vector.New(51, 26.853),
        location + scale * vector.New(50.173, 28.267), location + scale * vector.New(49, 29.82),
        colFn(49), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(49, 29.82),
        location + scale * vector.New(47.82, 31.38),
        location + scale * vector.New(46.19, 33.277), location + scale * vector.New(44.11, 35.51),
        colFn(44.11),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.11, 35.51), location + scale * vector.New(44.11, 35.51),
        location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25),
        colFn(35.94), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25),
        location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53),
        colFn(35.94), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53),
        location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53),
        colFn(52.84), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53),
        location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44),
        colFn(52.84), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44),
        location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44),
        colFn(29.9), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 48.72),
        location + scale * vector.New(62.407, 48.72),
        location + scale * vector.New(61.657, 48.407),
        location + scale * vector.New(61.03, 47.78),
        colFn(61.03), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 47.78),
        location + scale * vector.New(60.403, 47.153),
        location + scale * vector.New(60.09, 46.403), location + scale * vector.New(60.09, 45.53),
        colFn(60.09),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(60.09, 45.53), location + scale * vector.New(60.09, 44.65),
        location + scale * vector.New(60.403, 43.897), location + scale * vector.New(61.03, 43.27),
        colFn(61.03), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 43.27),
        location + scale * vector.New(61.657, 42.643),
        location + scale * vector.New(62.407, 42.33), location + scale * vector.New(63.28, 42.33),
        colFn(63.28),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 42.33), location + scale * vector.New(64.16, 42.33),
        location + scale * vector.New(64.913, 42.643), location + scale * vector.New(65.54, 43.27),
        colFn(65.54), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(65.54, 43.27),
        location + scale * vector.New(66.167, 43.897), location + scale * vector.New(66.48, 44.65),
        location + scale * vector.New(66.48, 45.53),
        colFn(66.48), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.48, 45.53), location + scale * vector.New(66.48, 46.11),
        location + scale * vector.New(66.333, 46.64), location + scale * vector.New(66.04, 47.12),
        colFn(66.04), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.04, 47.12),
        location + scale * vector.New(65.753, 47.607),
        location + scale * vector.New(65.37, 47.997), location + scale * vector.New(64.89, 48.29),
        colFn(64.89), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(64.89, 48.29),
        location + scale * vector.New(64.41, 48.577), location + scale * vector.New(63.873, 48.72),
        location + scale * vector.New(63.28, 48.72),
        colFn(63.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 48.93),
        location + scale * vector.New(83.12, 48.93),
        location + scale * vector.New(80.84, 48.2), location + scale * vector.New(78.96, 46.74),
        colFn(78.96), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.96, 46.74),
        location + scale * vector.New(77.08, 45.28), location + scale * vector.New(75.64, 43.157),
        location + scale * vector.New(74.64, 40.37),
        colFn(74.64), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.64, 40.37),
        location + scale * vector.New(73.647, 37.583),
        location + scale * vector.New(73.15, 34.213), location + scale * vector.New(73.15, 30.26),
        colFn(73.15),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.15, 30.26),
        location + scale * vector.New(73.15, 26.327),
        location + scale * vector.New(73.65, 22.967), location + scale * vector.New(74.65, 20.18),
        colFn(74.65),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.65, 20.18),
        location + scale * vector.New(75.65, 17.393),
        location + scale * vector.New(77.097, 15.263), location + scale * vector.New(78.99, 13.79),
        colFn(78.99), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.99, 13.79),
        location + scale * vector.New(80.877, 12.317),
        location + scale * vector.New(83.147, 11.58), location + scale * vector.New(85.8, 11.58),
        colFn(85.8),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 11.58),
        location + scale * vector.New(88.447, 11.58),
        location + scale * vector.New(90.713, 12.317), location + scale * vector.New(92.6, 13.79),
        colFn(92.6), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.6, 13.79),
        location + scale * vector.New(94.493, 15.263),
        location + scale * vector.New(95.94, 17.393), location + scale * vector.New(96.94, 20.18),
        colFn(96.94),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.94, 20.18),
        location + scale * vector.New(97.94, 22.967),
        location + scale * vector.New(98.44, 26.327), location + scale * vector.New(98.44, 30.26),
        colFn(98.44),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.44, 30.26),
        location + scale * vector.New(98.44, 34.213),
        location + scale * vector.New(97.943, 37.583), location + scale * vector.New(96.95, 40.37),
        colFn(96.95), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.95, 40.37),
        location + scale * vector.New(95.95, 43.157),
        location + scale * vector.New(94.51, 45.28), location + scale * vector.New(92.63, 46.74),
        colFn(92.63), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.63, 46.74),
        location + scale * vector.New(90.75, 48.2),
        location + scale * vector.New(88.473, 48.93), location + scale * vector.New(85.8, 48.93),
        colFn(85.8), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 45.03),
        location + scale * vector.New(88.447, 45.03), location + scale * vector.New(90.503, 43.75),
        location + scale * vector.New(91.97, 41.19),
        colFn(91.97), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.97, 41.19),
        location + scale * vector.New(93.443, 38.637),
        location + scale * vector.New(94.18, 34.993), location + scale * vector.New(94.18, 30.26),
        colFn(94.18),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.18, 30.26),
        location + scale * vector.New(94.18, 27.107),
        location + scale * vector.New(93.843, 24.423), location + scale * vector.New(93.17, 22.21),
        colFn(93.17), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.17, 22.21),
        location + scale * vector.New(92.503, 19.997),
        location + scale * vector.New(91.547, 18.31), location + scale * vector.New(90.3, 17.15),
        colFn(90.3),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.3, 17.15),
        location + scale * vector.New(89.047, 15.99),
        location + scale * vector.New(87.547, 15.41), location + scale * vector.New(85.8, 15.41),
        colFn(85.8),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 15.41),
        location + scale * vector.New(83.167, 15.41),
        location + scale * vector.New(81.11, 16.703), location + scale * vector.New(79.63, 19.29),
        colFn(79.63), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.63, 19.29),
        location + scale * vector.New(78.15, 21.877),
        location + scale * vector.New(77.41, 25.533), location + scale * vector.New(77.41, 30.26),
        colFn(77.41),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(77.41, 30.26),
        location + scale * vector.New(77.41, 33.407), location + scale * vector.New(77.743, 36.08),
        location + scale * vector.New(78.41, 38.28),
        colFn(78.41), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.41, 38.28), location + scale * vector.New(79.07, 40.48),
        location + scale * vector.New(80.027, 42.157), location + scale * vector.New(81.28, 43.31),
        colFn(81.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(81.28, 43.31),
        location + scale * vector.New(82.527, 44.457),
        location + scale * vector.New(84.033, 45.03), location + scale * vector.New(85.8, 45.03),
        colFn(85.8),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 48.72),
        location + scale * vector.New(107.437, 48.72),
        location + scale * vector.New(106.683, 48.407),
        location + scale * vector.New(106.05, 47.78),
        colFn(106.05), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 47.78),
        location + scale * vector.New(105.423, 47.153),
        location + scale * vector.New(105.11, 46.403),
        location + scale * vector.New(105.11, 45.53),
        colFn(105.11), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.11, 45.53),
        location + scale * vector.New(105.11, 44.65),
        location + scale * vector.New(105.423, 43.897),
        location + scale * vector.New(106.05, 43.27),
        colFn(106.05), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 43.27),
        location + scale * vector.New(106.683, 42.643),
        location + scale * vector.New(107.437, 42.33), location + scale * vector.New(108.31, 42.33),
        colFn(108.31),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 42.33),
        location + scale * vector.New(109.183, 42.33),
        location + scale * vector.New(109.933, 42.643),
        location + scale * vector.New(110.56, 43.27),
        colFn(110.56), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.56, 43.27),
        location + scale * vector.New(111.193, 43.897),
        location + scale * vector.New(111.51, 44.65), location + scale * vector.New(111.51, 45.53),
        colFn(111.51), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.51, 45.53), location + scale * vector.New(111.51, 46.11),
        location + scale * vector.New(111.363, 46.64),
        location + scale * vector.New(111.07, 47.12),
        colFn(111.07), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.07, 47.12),
        location + scale * vector.New(110.783, 47.607),
        location + scale * vector.New(110.4, 47.997),
        location + scale * vector.New(109.92, 48.29),
        colFn(109.92), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.92, 48.29),
        location + scale * vector.New(109.44, 48.577),
        location + scale * vector.New(108.903, 48.72), location + scale * vector.New(108.31, 48.72),
        colFn(108.31),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 48.93),
        location + scale * vector.New(128.147, 48.93),
        location + scale * vector.New(125.87, 48.2),
        location + scale * vector.New(123.99, 46.74),
        colFn(123.99), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.99, 46.74),
        location + scale * vector.New(122.103, 45.28),
        location + scale * vector.New(120.663, 43.157),
        location + scale * vector.New(119.67, 40.37),
        colFn(119.67), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.67, 40.37),
        location + scale * vector.New(118.677, 37.583),
        location + scale * vector.New(118.18, 34.213),
        location + scale * vector.New(118.18, 30.26),
        colFn(118.18), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.18, 30.26),
        location + scale * vector.New(118.18, 26.327),
        location + scale * vector.New(118.68, 22.967),
        location + scale * vector.New(119.68, 20.18),
        colFn(119.68), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.68, 20.18),
        location + scale * vector.New(120.68, 17.393),
        location + scale * vector.New(122.123, 15.263),
        location + scale * vector.New(124.01, 13.79),
        colFn(124.01), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.01, 13.79),
        location + scale * vector.New(125.903, 12.317),
        location + scale * vector.New(128.173, 11.58), location + scale * vector.New(130.82, 11.58),
        colFn(130.82),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 11.58),
        location + scale * vector.New(133.473, 11.58),
        location + scale * vector.New(135.743, 12.317),
        location + scale * vector.New(137.63, 13.79),
        colFn(137.63), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137.63, 13.79),
        location + scale * vector.New(139.523, 15.263),
        location + scale * vector.New(140.97, 17.393), location + scale * vector.New(141.97, 20.18),
        colFn(141.97),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(141.97, 20.18),
        location + scale * vector.New(142.97, 22.967),
        location + scale * vector.New(143.47, 26.327), location + scale * vector.New(143.47, 30.26),
        colFn(143.47),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(143.47, 30.26),
        location + scale * vector.New(143.47, 34.213),
        location + scale * vector.New(142.97, 37.583), location + scale * vector.New(141.97, 40.37),
        colFn(141.97),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(141.97, 40.37),
        location + scale * vector.New(140.977, 43.157),
        location + scale * vector.New(139.54, 45.28), location + scale * vector.New(137.66, 46.74),
        colFn(137.66),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137.66, 46.74),
        location + scale * vector.New(135.78, 48.2),
        location + scale * vector.New(133.5, 48.93), location + scale * vector.New(130.82, 48.93),
        colFn(130.82),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 45.03),
        location + scale * vector.New(133.473, 45.03),
        location + scale * vector.New(135.533, 43.75), location + scale * vector.New(137, 41.19),
        colFn(137),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137, 41.19),
        location + scale * vector.New(138.467, 38.637),
        location + scale * vector.New(139.2, 34.993), location + scale * vector.New(139.2, 30.26),
        colFn(139.2),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(139.2, 30.26),
        location + scale * vector.New(139.2, 27.107),
        location + scale * vector.New(138.867, 24.423),
        location + scale * vector.New(138.2, 22.21),
        colFn(138.2), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(138.2, 22.21),
        location + scale * vector.New(137.533, 19.997),
        location + scale * vector.New(136.573, 18.31), location + scale * vector.New(135.32, 17.15),
        colFn(135.32),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(135.32, 17.15),
        location + scale * vector.New(134.073, 15.99),
        location + scale * vector.New(132.573, 15.41), location + scale * vector.New(130.82, 15.41),
        colFn(130.82),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 15.41),
        location + scale * vector.New(128.193, 15.41),
        location + scale * vector.New(126.14, 16.703),
        location + scale * vector.New(124.66, 19.29),
        colFn(124.66), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.66, 19.29),
        location + scale * vector.New(123.18, 21.877),
        location + scale * vector.New(122.44, 25.533), location + scale * vector.New(122.44, 30.26),
        colFn(122.44),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.44, 30.26),
        location + scale * vector.New(122.44, 33.407),
        location + scale * vector.New(122.773, 36.08), location + scale * vector.New(123.44, 38.28),
        colFn(123.44),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.44, 38.28), location + scale * vector.New(124.1, 40.48),
        location + scale * vector.New(125.057, 42.157),
        location + scale * vector.New(126.31, 43.31),
        colFn(126.31), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.31, 43.31),
        location + scale * vector.New(127.557, 44.457),
        location + scale * vector.New(129.06, 45.03), location + scale * vector.New(130.82, 45.03),
        colFn(130.82), thickness)
end
