---@diagnostic disable: redefined-local
function showPatchNotesWindow()
    startNextWindowNotCollapsed('plumoguSV Patch Notes')
    _, patchNotesOpened = imgui.Begin('plumoguSV Patch Notes', true, imgui_window_flags.NoResize)
    imgui.SetWindowSize('plumoguSV Patch Notes', vector.New(500, 400))
    imgui.PushStyleColor(imgui_col.Separator, color.int.white - color.int.alphaMask * 200)

    local minHeight = imgui.GetWindowPos().y
    local maxHeight = minHeight + 400

    if (not patchNotesOpened) then
        cache.windows.showPatchNotesWindow = false
    end

    imgui.BeginChild('v2.0.2Bezier', vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip202 end
    if (topLeft.y - minHeight < -50) then goto skip202 end
    drawV202(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 147 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 147 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip202::
    imgui.EndChild()
    imgui.SeparatorText('Bug Fixes / Minor Changes')
    imgui.BulletText('Steam builds now have a warning to save their config file because workshop poopoo.')
    imgui.BulletText('Fixed some backgrounds incorrectly displaying.')
    imgui.BulletText('Fixed hit object lag.')
    imgui.BulletText('Fixed measure not updating properly when applying sv (bug from v2.0.1).')
    imgui.BulletText('Cleaned up the lint map screen and added \"Remove Unnecessary SSF\" function.')
    imgui.BulletText('Did quite a large amount of work on the backend like renaming stuff to be more clear, etc.')
    imgui.BulletText('Align timing lines now properly hides timing lines if the first one was hidden.')
    imgui.BulletText('Now allows sinusoidal movement in dynamic scale.')
    imgui.BulletText(
        'Upgraded computableinputfloat to now allow for infinite precision and much more anti-cheese entries.')
    imgui.SeparatorText('New Features')
    imgui.BulletText('Added text to give me money like mr krabs.')

    imgui.BeginChild('v2.0.1Bezier', vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip201 end
    if (topLeft.y - minHeight < -50) then goto skip201 end
    drawV201(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 137 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 137 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip201::
    imgui.EndChild()
    imgui.SeparatorText('Bug Fixes / Minor Changes')
    imgui.BulletText('Fixed individual combo settings being able to be saved.')
    imgui.BulletText('Fixed loadup text color not being properly used in the custom theme.')
    imgui.BulletText('Changed the barbie theme to be less obnoxious.')
    imgui.BulletText('Fixed themes not exporting loadup parameters correctly.')
    imgui.BulletText('Changed some backend features to prevent bugs in the future.')
    imgui.BulletText('Moved some settings to the new "Advanced" section.')
    imgui.BulletText('Fixed performance mode not delaying HitObject refresh.')
    imgui.BulletText('Fixed stutter linear interpolation crashing the plugin.')
    imgui.BulletText('Now successfully hot-reloads menu data.')
    imgui.BulletText('Fixed Select > Alternating offset bug.')
    imgui.BulletText('Fixed loadup animation playing after delay even when it was disabled.')
    imgui.SeparatorText('New Features')
    imgui.BulletText('Now allows you to change the default displacement exponential multiplier.')
    imgui.BulletText('Added a setting which unrestricts sinusoidal period.')
    imgui.BulletText('Added mines to the Select > Note Type feature (canary only).')
    imgui.BulletText('Added a small gradient in the background to enhance appearance.')

    AddPadding()

    imgui.BeginChild('v2.0.0Bezier', vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip200 end
    if (topLeft.y - minHeight < -50) then goto skip200 end
    drawV200(ctx, topLeft + vector.New(243, 17), 1, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 144 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 144 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip200::
    imgui.EndChild()

    imgui.SeparatorText('Bug Fixes / Minor Changes')
    imgui.BulletText('Fixed not being able to properly store some cursor trail parameters.')
    imgui.BulletText('Fixed start/end expo using incorrect algorithm.')
    imgui.BulletText('Fixed all bugs relating to automate.')
    imgui.BulletText('Removed v1.1.2 temporary bug fix.')
    imgui.BulletText('Fix direct SV pagination not working correctly.')
    imgui.BulletText('Fixed flicker percentage not accurately converting to map.')
    imgui.BulletText('Fixed align timing lines not being deterministic.')
    imgui.BulletText('Fixed suffix of computableInputFloat.')
    imgui.BulletText('Fixed inconsistency of negative/positive SV generation.')
    imgui.BulletText('Fixed getRemovableSVs to use tolerance.')
    imgui.BulletText('Fixed the builder not properly nesting files.')
    imgui.BulletText('Fixed stills placing duplicate SVs.')
    imgui.BulletText('Fixed internal documentation being incorrect and generally poor.')
    imgui.BulletText('Fixed several overlapping SV issues.')
    imgui.BulletText('Fixed hypothetical SVs using some weird BS.')
    imgui.BulletText('Removed splitscroll in favor of using TGs.')
    imgui.BulletText('Fixed TG selector being unable to properly select some TGs.')
    imgui.BulletText('Fixed TG selector not always being fully in-sync with the game.')
    imgui.BulletText('Fixed automate altering SV post-effect.')
    imgui.BulletText('Fixed 2-side vibrato inaccuracy.')
    imgui.BulletText('Fixed build script to use correct regex.')
    imgui.BulletText('Fixed cursor trail being broken.')
    imgui.BulletText('Fixed hotkey settings window having overlapping text.')
    imgui.BulletText('Fixed global vars being unable to default to true.')
    imgui.BulletText('Moved workspace settings to .luarc file.')
    imgui.BulletText('Cached variables are properly reloaded during hot-reload.')
    imgui.BulletText('Fixed bug where hot-reloading would crash the game.')
    imgui.BulletText('Fixed starting fresh plugin with no config.yaml breaking style.')
    imgui.BulletText('Fixed bug where string ending of pluralized content\ncarried over between function calls.')
    imgui.BulletText('Fixed vibrato placing duplicate SVs.')
    imgui.BulletText('Fixed still per note group finally.')
    imgui.BulletText('Now properly instantiates pulse color.')
    imgui.BulletText('Fixed relative ratio not saving.')
    imgui.BulletText('Fixed Still per note group displacements, and enabled auto/otua on the \naforementioned feature.')
    imgui.BulletText('Fixed Select Bookmark crashing the game.')
    imgui.BulletText('Fixed Select Bookmark text going off the screen.')
    imgui.BulletText(
        'Fixed measure msx widget not rendering in real time, and not\nproperly recalculating distances when switching TGs.')
    imgui.BulletText("Fixed bug where saving a false setting wouldn't save it at all.")
    imgui.BulletText(
        "Fixed bug with certain functions where LN ends would not be\nconsidered if their start wasn't within the selection.")
    imgui.SeparatorText('New Features')
    imgui.BulletText('Added tooltips to various functions to explain their functionality.')
    imgui.BulletText('New border pulse feature that pulses along with the beat.')
    imgui.BulletText('Added a new hotkey to select the TG of note(s).')
    imgui.BulletText('New menu: Edit > Convert SV <-> SSF; Self-explanatory.')
    imgui.BulletText(
        'Added vibrato to plumoguSV, with less error than AFFINE. Includes linear,\npolynomial, exponential, sinusoidal, and sigmoidal shapes. Includes presets for FPS.')
    imgui.BulletText('Include code-based SV/SSF fast place.')
    imgui.BulletText('New settings menu with many more customizable features.')
    imgui.BulletText('Allow defaults to be edited.')
    imgui.BulletText('Include some new automate parameters for further customization.')
    imgui.BulletText('Edit > Layer Snaps feature: Save your snap colors before using AFFINE to\nbring them back easily.')
    imgui.BulletText('Edit > Split feature: Split notes into different TGs with the\nsurrounding SVs in one click.')
    imgui.BulletText('Added linear equalizer to allow you to create 0x SV on linear much easier.')
    imgui.BulletText('Added custom theme input, along with exporting/importing.')
    imgui.BulletText('Added 3 custom reactive backgrounds. More will be added\nwhen the kofi products are paid for.')
    imgui.BulletText('Added copy paste slots; now you can copy paste more than one thing at once.')
    imgui.BulletText('Allow border pulse to be custom.')
    imgui.BulletText(
        "Note lock feature: you don't need to worry about accidentally placing,\nmoving, or deleting notes during SV generation.")
    imgui.BulletText('Now allows certain inputs to be computed automatically on the backend.')
    imgui.BulletText('A new performance mode to speed up the FPS by 2-3x.')
    imgui.BulletText('You can now merge SSFs to eliminate duped ones.')
    imgui.BulletText('Added new option to allow combo-select.')
    imgui.BulletText('New toggleable SV Info visualizer for the more inexperienced mappers.')
    imgui.BulletText('Reworked bezier menu to be much more intuitive.')
    imgui.BulletText('Added loadup animation because why not.')
    imgui.BulletText('Added patch notes page.')
    imgui.BulletText('Added map stats button to quickly grab SV and SSF count.')
    imgui.BulletText('Added pagination to bookmarks.')
    imgui.BulletText('Now allowed Direct SV to view SVs around a particular note.')
    imgui.BulletText('Moved many linting features to Edit > Lint Map.')
    imgui.BulletText('Added new feature to remove duplicated notes.')
    imgui.BulletText(
        "Added new feature to remove hitsounds, for mappers who don't use\nthem but accidentally click on the menu.")
    imgui.BulletText('Added a very rudimentary preset system, so you can send menu data to others.')
    imgui.BulletText('Added a button to directly swap SVs and SSFs.')
    imgui.BulletText('Added a startup animation.')
    imgui.BulletText('Added hotkeys to switch between TGs.')
    imgui.BulletText('Added hotkey to move all selected notes to the selected TG.')

    AddPadding()

    imgui.BeginChild('v1.1.2Bezier', vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip112 end
    if (topLeft.y - minHeight < -50) then goto skip112 end
    drawV112(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 127 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 127 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip112::
    imgui.EndChild()

    imgui.SeparatorText('Bug Fixes / Minor Changes')
    imgui.BulletText('Fixed stills placing duplicate SVs that changed order when called.')
    imgui.BulletText('Fixed stills removing non-existent SVs.')
    imgui.BulletText('Fixed copy/paste priority problems.')
    imgui.BulletText('Fixed plugin TG selector overriding editor TG selector.')
    imgui.SeparatorText('New Features')
    imgui.BulletText("Now stores settings so you don't have to edit the plugin file to save them.")
    imgui.BulletText('Added step size to the exponential intensity bar.')
    imgui.BulletText('Distance fields now allow mathematical expressions\nthat are automatically evaluated.')
    imgui.BulletText('Created a new advanced mode, which disabling causes less clutter.')
    imgui.BulletText('Created Edit > Direct SV, an easier way to edit SVs directly within your selection.')
    imgui.BulletText('Added colors to the TG selector to easily distinguish groups.')

    AddPadding()

    imgui.BeginChild('v1.1.1Bezier', vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    drawV111(ctx, topLeft + vector.New(238, 17), 1, color.int.white, 1)
    if (topLeft.y - maxHeight > 0) then goto skip111 end
    if (topLeft.y - minHeight < -50) then goto skip111 end
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 111 / 2 - 15, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 111 / 2 + 15, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip111::
    imgui.EndChild()

    imgui.SeparatorText('Bug Fixes / Minor Changes')
    imgui.BulletText('Fixed more bugs involving stills.')
    imgui.SeparatorText('New Features')
    imgui.BulletText('Added a new hotkey to quickly place SSFs.')
    imgui.BulletText('Added a new TG selector.')

    AddPadding()

    imgui.BeginChild('v1.1.0Bezier', vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip110 end
    if (topLeft.y - minHeight < -50) then goto skip110 end
    drawV110(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 129 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 129 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip110::
    imgui.EndChild()

    imgui.SeparatorText('Bug Fixes / Minor Changes')
    imgui.BulletText('Fixed issues where stills would incorrectly displace notes.')
    imgui.BulletText('Fixed swap/negate buttons not working properly.')
    imgui.SeparatorText('New Features')
    imgui.BulletText('Added Select by Chord Size.')
    imgui.BulletText('Now allows displace note/flicker to be linearly interpolated.')
    imgui.BulletText('Stills now only require one undo instead of two.')
    imgui.BulletText('New Still mode: still per note group, which drastically speeds up still production.')
    imgui.BulletText('Two new exponential modes: start/end and distance-based algorithms.')
    imgui.BulletText('Added hotkeys to quickly swap, negate, and reset certain parameters.')
    imgui.BulletText('Added notifications to all features.')
    imgui.BulletText('Copy and paste now supports bookmarks and timing lines.')
    imgui.BulletText('New setting was added to allow you to ignore notes outside the current TG.')

    AddPadding()

    imgui.BeginChild('v1.0.1Bezier', vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip101 end
    if (topLeft.y - minHeight < -50) then goto skip101 end
    drawV101(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 125 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 125 / 2 + 12.5, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip101::
    imgui.EndChild()

    imgui.SeparatorText('Bug Fixes / Minor Changes')
    imgui.BulletText('Fixed game occasionally crashing when using the Select tab.')
    imgui.SeparatorText('New Features')
    imgui.BulletText('Added Select Bookmark feature (from BookmarkLeaper).')
    imgui.BulletText('Added Edit > Align Timing Lines feature (from SmartAlign).')
    imgui.BulletText('Added notifications for more features when executed.')
    imgui.BulletText('Added tooltips for Select features and swap/negate buttons.')
    imgui.BulletText('Changed the Delete menu to allow deleting SVs or SSFs.')

    AddPadding()

    imgui.BeginChild('v1.0.0Bezier', vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip100 end
    if (topLeft.y - minHeight < -50) then goto skip100 end
    drawV100(ctx, topLeft + vector.New(243, 17), 1, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 137 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 137 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip100::
    imgui.EndChild()

    imgui.SeparatorText('Bug Fixes / Minor Changes')
    imgui.BulletText('Fix LN Ends feature now flips LN ends, even if the corresponding ending SV is 0.')
    imgui.BulletText('Allowed Still to treat LN ends as displacement markers.')

    imgui.SeparatorText('New Features')
    imgui.BulletText('Added the SSF equivalent to all Standard SV shapes.')
    imgui.BulletText(
        'Added the Select tab, which allows users to quickly select desired notes based on\na variety of conditions. Currently, there is the Alternate option and the Snap option.')

    imgui.PopStyleColor()
    imgui.End()
end

---Draws v202 on screen, with dimensions = scale * [142,37].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV202(ctx, location, scale, col, thickness)
    location = location - vector.New(71, 18.5) * scale
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
    ctx.AddBezierCubic(location + scale * vector.New(118.96, 48.44), location + scale * vector.New(118.96, 48.44),
        location + scale * vector.New(118.96, 45.24), location + scale * vector.New(118.96, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.96, 45.24), location + scale * vector.New(118.96, 45.24),
        location + scale * vector.New(130.97, 32.1), location + scale * vector.New(130.97, 32.1), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.97, 32.1),
        location + scale * vector.New(132.377, 30.56),
        location + scale * vector.New(133.537, 29.22), location + scale * vector.New(134.45, 28.08), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(134.45, 28.08),
        location + scale * vector.New(135.357, 26.94),
        location + scale * vector.New(136.033, 25.863), location + scale * vector.New(136.48, 24.85),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(136.48, 24.85),
        location + scale * vector.New(136.92, 23.837),
        location + scale * vector.New(137.14, 22.773), location + scale * vector.New(137.14, 21.66), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137.14, 21.66), location + scale * vector.New(137.14, 20.38),
        location + scale * vector.New(136.837, 19.273),
        location + scale * vector.New(136.23, 18.34), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(136.23, 18.34),
        location + scale * vector.New(135.623, 17.407),
        location + scale * vector.New(134.793, 16.687),
        location + scale * vector.New(133.74, 16.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(133.74, 16.18),
        location + scale * vector.New(132.687, 15.667),
        location + scale * vector.New(131.5, 15.41), location + scale * vector.New(130.18, 15.41), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.18, 15.41),
        location + scale * vector.New(128.787, 15.41),
        location + scale * vector.New(127.573, 15.697),
        location + scale * vector.New(126.54, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.54, 16.27),
        location + scale * vector.New(125.5, 16.843),
        location + scale * vector.New(124.7, 17.647),
        location + scale * vector.New(124.14, 18.68), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.14, 18.68),
        location + scale * vector.New(123.58, 19.707),
        location + scale * vector.New(123.3, 20.913), location + scale * vector.New(123.3, 22.3),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.3, 22.3), location + scale * vector.New(123.3, 22.3),
        location + scale * vector.New(119.11, 22.3), location + scale * vector.New(119.11, 22.3), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.11, 22.3),
        location + scale * vector.New(119.11, 20.173),
        location + scale * vector.New(119.6, 18.303), location + scale * vector.New(120.58, 16.69), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.58, 16.69),
        location + scale * vector.New(121.56, 15.083),
        location + scale * vector.New(122.9, 13.83),
        location + scale * vector.New(124.6, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.6, 12.93), location + scale * vector.New(126.3, 12.03),
        location + scale * vector.New(128.21, 11.58), location + scale * vector.New(130.33, 11.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.33, 11.58),
        location + scale * vector.New(132.457, 11.58),
        location + scale * vector.New(134.343, 12.03), location + scale * vector.New(135.99, 12.93), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(135.99, 12.93),
        location + scale * vector.New(137.637, 13.83),
        location + scale * vector.New(138.927, 15.043),
        location + scale * vector.New(139.86, 16.57), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(139.86, 16.57),
        location + scale * vector.New(140.793, 18.097),
        location + scale * vector.New(141.26, 19.793), location + scale * vector.New(141.26, 21.66), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(141.26, 21.66), location + scale * vector.New(141.26, 23),
        location + scale * vector.New(141.023, 24.307),
        location + scale * vector.New(140.55, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(140.55, 25.58),
        location + scale * vector.New(140.07, 26.853),
        location + scale * vector.New(139.24, 28.267), location + scale * vector.New(138.06, 29.82), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(138.06, 29.82),
        location + scale * vector.New(136.88, 31.38),
        location + scale * vector.New(135.25, 33.277),
        location + scale * vector.New(133.17, 35.51), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(133.17, 35.51), location + scale * vector.New(133.17, 35.51),
        location + scale * vector.New(125, 44.25), location + scale * vector.New(125, 44.25), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(125, 44.25), location + scale * vector.New(125, 44.25),
        location + scale * vector.New(125, 44.53), location + scale * vector.New(125, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(125, 44.53), location + scale * vector.New(125, 44.53),
        location + scale * vector.New(141.9, 44.53), location + scale * vector.New(141.9, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(141.9, 44.53), location + scale * vector.New(141.9, 44.53),
        location + scale * vector.New(141.9, 48.44), location + scale * vector.New(141.9, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(141.9, 48.44), location + scale * vector.New(141.9, 48.44),
        location + scale * vector.New(118.96, 48.44), location + scale * vector.New(118.96, 48.44), col, thickness)
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

---Draws v110 on screen, with dimensions = scale * [129,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param thickness integer
function drawV110(ctx, location, scale, col, thickness)
    location = location - vector.New(64.5, 24) * scale
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
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07),
        location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44), colFn(79.69), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44),
        location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44), colFn(75.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44),
        location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69), colFn(75.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69),
        location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69), colFn(75.07), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69),
        location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59), colFn(66.19), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59),
        location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11), colFn(66.19), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11),
        location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07), colFn(75.28), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07),
        location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07), colFn(79.69), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 48.72),
        location + scale * vector.New(92.377, 48.72),
        location + scale * vector.New(91.627, 48.407), location + scale * vector.New(91, 47.78),
        colFn(91), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 47.78),
        location + scale * vector.New(90.373, 47.153),
        location + scale * vector.New(90.06, 46.403), location + scale * vector.New(90.06, 45.53),
        colFn(90.06),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.06, 45.53), location + scale * vector.New(90.06, 44.65),
        location + scale * vector.New(90.373, 43.897), location + scale * vector.New(91, 43.27),
        colFn(91), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 43.27),
        location + scale * vector.New(91.627, 42.643),
        location + scale * vector.New(92.377, 42.33), location + scale * vector.New(93.25, 42.33),
        colFn(93.25),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 42.33), location + scale * vector.New(94.13, 42.33),
        location + scale * vector.New(94.883, 42.643), location + scale * vector.New(95.51, 43.27),
        colFn(95.51), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.51, 43.27),
        location + scale * vector.New(96.137, 43.897),
        location + scale * vector.New(96.45, 44.65), location + scale * vector.New(96.45, 45.53),
        colFn(96.45),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.45, 45.53),
        location + scale * vector.New(96.45, 46.11),
        location + scale * vector.New(96.303, 46.64), location + scale * vector.New(96.01, 47.12),
        colFn(96.01), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.01, 47.12),
        location + scale * vector.New(95.723, 47.607),
        location + scale * vector.New(95.34, 47.997), location + scale * vector.New(94.86, 48.29),
        colFn(94.86),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.86, 48.29),
        location + scale * vector.New(94.38, 48.577), location + scale * vector.New(93.843, 48.72),
        location + scale * vector.New(93.25, 48.72), colFn(93.25), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 48.93),
        location + scale * vector.New(113.09, 48.93),
        location + scale * vector.New(110.81, 48.2), location + scale * vector.New(108.93, 46.74),
        colFn(108.93),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.93, 46.74),
        location + scale * vector.New(107.05, 45.28),
        location + scale * vector.New(105.613, 43.157),
        location + scale * vector.New(104.62, 40.37), colFn(104.62), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.62, 40.37),
        location + scale * vector.New(103.627, 37.583),
        location + scale * vector.New(103.13, 34.213), location + scale * vector.New(103.13, 30.26),
        colFn(103.13),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.13, 30.26),
        location + scale * vector.New(103.13, 26.327),
        location + scale * vector.New(103.63, 22.967), location + scale * vector.New(104.63, 20.18),
        colFn(104.63),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.63, 20.18),
        location + scale * vector.New(105.63, 17.393),
        location + scale * vector.New(107.073, 15.263),
        location + scale * vector.New(108.96, 13.79), colFn(108.96), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.96, 13.79),
        location + scale * vector.New(110.847, 12.317),
        location + scale * vector.New(113.117, 11.58), location + scale * vector.New(115.77, 11.58),
        colFn(115.77),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 11.58),
        location + scale * vector.New(118.417, 11.58),
        location + scale * vector.New(120.687, 12.317),
        location + scale * vector.New(122.58, 13.79), colFn(122.58), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.58, 13.79),
        location + scale * vector.New(124.467, 15.263),
        location + scale * vector.New(125.91, 17.393),
        location + scale * vector.New(126.91, 20.18), colFn(126.91), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.91, 20.18),
        location + scale * vector.New(127.91, 22.967),
        location + scale * vector.New(128.41, 26.327),
        location + scale * vector.New(128.41, 30.26), colFn(128.41), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(128.41, 30.26),
        location + scale * vector.New(128.41, 34.213),
        location + scale * vector.New(127.913, 37.583),
        location + scale * vector.New(126.92, 40.37), colFn(126.92), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.92, 40.37),
        location + scale * vector.New(125.927, 43.157),
        location + scale * vector.New(124.487, 45.28),
        location + scale * vector.New(122.6, 46.74), colFn(122.6), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.6, 46.74),
        location + scale * vector.New(120.72, 48.2),
        location + scale * vector.New(118.443, 48.93),
        location + scale * vector.New(115.77, 48.93), colFn(115.77), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 45.03),
        location + scale * vector.New(118.417, 45.03),
        location + scale * vector.New(120.477, 43.75), location + scale * vector.New(121.95, 41.19),
        colFn(121.95),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.95, 41.19),
        location + scale * vector.New(123.417, 38.637),
        location + scale * vector.New(124.15, 34.993), location + scale * vector.New(124.15, 30.26),
        colFn(124.15),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.15, 30.26),
        location + scale * vector.New(124.15, 27.107),
        location + scale * vector.New(123.813, 24.423),
        location + scale * vector.New(123.14, 22.21), colFn(123.14), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.14, 22.21),
        location + scale * vector.New(122.473, 19.997),
        location + scale * vector.New(121.517, 18.31), location + scale * vector.New(120.27, 17.15),
        colFn(120.27),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.27, 17.15),
        location + scale * vector.New(119.017, 15.99),
        location + scale * vector.New(117.517, 15.41), location + scale * vector.New(115.77, 15.41),
        colFn(115.77),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 15.41),
        location + scale * vector.New(113.143, 15.41),
        location + scale * vector.New(111.09, 16.703),
        location + scale * vector.New(109.61, 19.29), colFn(109.61), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.61, 19.29),
        location + scale * vector.New(108.13, 21.877),
        location + scale * vector.New(107.39, 25.533), location + scale * vector.New(107.39, 30.26),
        colFn(107.39),
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(107.39, 30.26),
        location + scale * vector.New(107.39, 33.407), location + scale * vector.New(107.72, 36.08),
        location + scale * vector.New(108.38, 38.28), colFn(108.38), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.38, 38.28),
        location + scale * vector.New(109.047, 40.48),
        location + scale * vector.New(110.003, 42.157),
        location + scale * vector.New(111.25, 43.31), colFn(111.25), thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.25, 43.31),
        location + scale * vector.New(112.497, 44.457),
        location + scale * vector.New(114.003, 45.03), location + scale * vector.New(115.77, 45.03),
        colFn(115.77),
        thickness)
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
