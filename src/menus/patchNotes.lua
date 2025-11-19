function showPatchNotesWindow()
    startNextWindowNotCollapsed("plumoguSV Patch Notes")
    _, patchNotesOpened = imgui.Begin("plumoguSV Patch Notes", true, imgui_window_flags.NoResize)
    imgui.SetWindowSize("plumoguSV Patch Notes", vector.New(500, 400))
    imgui.PushStyleColor(imgui_col.Separator, color.int.white - color.int.alphaMask * 200)

    local minHeight = imgui.GetWindowPos().y
    local maxHeight = minHeight + 400

    if (not patchNotesOpened) then
        cache.windows.showPatchNotesWindow = false
    end

    imgui.BeginChild("v2.0.0Bezier", vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip200 end
    if (topLeft.y - minHeight < -50) then goto skip200 end
    drawV200(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 144 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 144 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip200::
    imgui.EndChild()

    imgui.SeparatorText("Bug Fixes")
    imgui.BulletText("Fixed not being able to properly store some cursor trail parameters.")
    imgui.BulletText("Fixed start/end expo using incorrect algorithm.")
    imgui.BulletText("Fixed all bugs relating to automate.")
    imgui.BulletText("Removed v1.1.2 temporary bug fix.")
    imgui.BulletText("Fix direct SV pagination not working correctly.")
    imgui.BulletText("Fixed flicker percentage not accurately converting to map.")
    imgui.BulletText("Fixed align timing lines not being deterministic.")
    imgui.BulletText("Fixed suffix of computableInputFloat.")
    imgui.BulletText("Fixed inconsistency of negative/positive SV generation.")
    imgui.BulletText("Fixed getRemovableSVs to use tolerance.")
    imgui.BulletText("Fixed the builder not properly nesting files.")
    imgui.BulletText("Fixed stills placing duplicate SVs.")
    imgui.BulletText("Fixed internal documentation being incorrect and generally poor.")
    imgui.BulletText("Fixed several overlapping SV issues.")
    imgui.BulletText("Fixed hypothetical SVs using some weird BS.")
    imgui.BulletText("Removed splitscroll in favor of using TGs.")
    imgui.BulletText("Fixed TG selector being unable to properly select some TGs.")
    imgui.BulletText("Fixed TG selector not always being fully in-sync with the game.")
    imgui.BulletText("Fixed automate altering SV post-effect.")
    imgui.BulletText("Fixed 2-side vibrato inaccuracy.")
    imgui.BulletText("Fixed build script to use correct regex.")
    imgui.BulletText("Fixed cursor trail being broken.")
    imgui.BulletText("Fixed hotkey settings window having overlapping text.")
    imgui.BulletText("Fixed global vars being unable to default to true.")
    imgui.BulletText("Moved workspace settings to .luarc file.")
    imgui.BulletText("Cached variables are properly reloaded during hot-reload.")
    imgui.BulletText("Fixed bug where hot-reloading would crash the game.")
    imgui.BulletText("Fixed starting fresh plugin with no config.yaml breaking style.")
    imgui.BulletText("Fixed bug where string ending of pluralized content\ncarried over between function calls.")
    imgui.BulletText("Fixed vibrato placing duplicate SVs.")
    imgui.BulletText("Fixed still per note group finally.")
    imgui.BulletText("Now properly instantiates pulse color.")
    imgui.BulletText("Fixed relative ratio not saving.")
    imgui.BulletText("Fixed Still per note group displacements, and enabled auto/otua on the \naforementioned feature.")
    imgui.BulletText("Fixed Select Bookmark crashing the game.")
    imgui.BulletText("Fixed Select Bookmark text going off the screen.")
    imgui.BulletText(
        "Fixed measure msx widget not rendering in real time, and not\nproperly recalculating distances when switching TGs.")
    imgui.BulletText("Fixed bug where saving a false setting wouldn't save it at all.")
    imgui.BulletText(
        "Fixed bug with certain functions where LN ends would not be\nconsidered if their start wasn't within the selection.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Added tooltips to various functions to explain their functionality.")
    imgui.BulletText("New border pulse feature that pulses along with the beat.")
    imgui.BulletText("Added a new hotkey to select the TG of note(s).")
    imgui.BulletText("New menu: Edit > Convert SV <-> SSF; Self-explanatory.")
    imgui.BulletText(
        "Added vibrato to plumoguSV, with less error than AFFINE. Includes linear,\npolynomial, exponential, sinusoidal, and sigmoidal shapes. Includes presets for FPS.")
    imgui.BulletText("Include code-based SV/SSF fast place.")
    imgui.BulletText("New settings menu with many more customizable features.")
    imgui.BulletText("Allow defaults to be edited.")
    imgui.BulletText("Include some new automate parameters for further customization.")
    imgui.BulletText("Edit > Layer Snaps feature: Save your snap colors before using AFFINE to\nbring them back easily.")
    imgui.BulletText("Edit > Split feature: Split notes into different TGs with the\nsurrounding SVs in one click.")
    imgui.BulletText("Added linear equalizer to allow you to create 0x SV on linear much easier.")
    imgui.BulletText("Added custom theme input, along with exporting/importing.")
    imgui.BulletText("Added 3 custom reactive backgrounds. More will be added\nwhen the kofi products are paid for.")
    imgui.BulletText("Added copy paste slots; now you can copy paste more than one thing at once.")
    imgui.BulletText("Allow border pulse to be custom.")
    imgui.BulletText(
        "Note lock feature: you don't need to worry about accidentally placing,\nmoving, or deleting notes during SV generation.")
    imgui.BulletText("Now allows certain inputs to be computed automatically on the backend.")
    imgui.BulletText("A new performance mode to speed up the FPS by 2-3x.")
    imgui.BulletText("You can now merge SSFs to eliminate duped ones.")
    imgui.BulletText("Added new option to allow combo-select.")
    imgui.BulletText("New toggleable SV Info visualizer for the more inexperienced mappers.")
    imgui.BulletText("Reworked bezier menu to be much more intuitive.")
    imgui.BulletText("Added loadup animation because why not.")
    imgui.BulletText("Added patch notes page.")
    imgui.BulletText("Added map stats button to quickly grab SV and SSF count.")
    imgui.BulletText("Added pagination to bookmarks.")
    imgui.BulletText("Now allowed Direct SV to view SVs around a particular note.")
    imgui.BulletText("Moved many linting features to Edit > Lint Map.")
    imgui.BulletText("Added new feature to remove duplicated notes.")
    imgui.BulletText(
        "Added new feature to remove hitsounds, for mappers who don't use\nthem but accidentally click on the menu.")
    imgui.BulletText("Added a very rudimentary preset system, so you can send menu data to others.")
    imgui.BulletText("Added a button to directly swap SVs and SSFs.")
    imgui.BulletText("Added a startup animation.")
    imgui.BulletText("Added hotkeys to switch between TGs.")
    imgui.BulletText("Added hotkey to move all selected notes to the selected TG.")


    AddPadding()

    imgui.BeginChild("v1.1.2Bezier", vector.New(486, 48), 2, 3)
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

    imgui.SeparatorText("Bug Fixes")
    imgui.BulletText("Fixed stills placing duplicate SVs that changed order when called.")
    imgui.BulletText("Fixed stills removing non-existent SVs.")
    imgui.BulletText("Fixed copy/paste priority problems.")
    imgui.BulletText("Fixed plugin TG selector overriding editor TG selector.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Now stores settings so you don't have to edit the plugin file to save them.")
    imgui.BulletText("Added step size to the exponential intensity bar.")
    imgui.BulletText("Distance fields now allow mathematical expressions\nthat are automatically evaluated.")
    imgui.BulletText("Created a new advanced mode, which disabling causes less clutter.")
    imgui.BulletText("Created Edit > Direct SV, an easier way to edit SVs directly within your selection.")
    imgui.BulletText("Added colors to the TG selector to easily distinguish groups.")

    AddPadding()

    imgui.BeginChild("v1.1.1Bezier", vector.New(486, 48), 2, 3)
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

    imgui.SeparatorText("Bug Fixes")
    imgui.BulletText("Fixed more bugs involving stills.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Added a new hotkey to quickly place SSFs.")
    imgui.BulletText("Added a new TG selector.")

    AddPadding()

    imgui.BeginChild("v1.1.0Bezier", vector.New(486, 48), 2, 3)
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

    imgui.SeparatorText("Bug Fixes")
    imgui.BulletText("Fixed issues where stills would incorrectly displace notes.")
    imgui.BulletText("Fixed swap/negate buttons not working properly.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Added Select by Chord Size.")
    imgui.BulletText("Now allows displace note/flicker to be linearly interpolated.")
    imgui.BulletText("Stills now only require one undo instead of two.")
    imgui.BulletText("New Still mode: still per note group, which drastically speeds up still production.")
    imgui.BulletText("Two new exponential modes: start/end and distance-based algorithms.")
    imgui.BulletText("Added hotkeys to quickly swap, negate, and reset certain parameters.")
    imgui.BulletText("Added notifications to all features.")
    imgui.BulletText("Copy and paste now supports bookmarks and timing lines.")
    imgui.BulletText("New setting was added to allow you to ignore notes outside the current TG.")

    AddPadding()

    imgui.BeginChild("v1.0.1Bezier", vector.New(486, 48), 2, 3)
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

    imgui.SeparatorText("Bug Fixes")
    imgui.BulletText("Fixed game occasionally crashing when using the Select tab.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Added Select Bookmark feature (from BookmarkLeaper).")
    imgui.BulletText("Added Edit > Align Timing Lines feature (from SmartAlign).")
    imgui.BulletText("Added notifications for more features when executed.")
    imgui.BulletText("Added tooltips for Select features and swap/negate buttons.")
    imgui.BulletText("Changed the Delete menu to allow deleting SVs or SSFs.")

    AddPadding()

    imgui.BeginChild("v1.0.0Bezier", vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip100 end
    if (topLeft.y - minHeight < -50) then goto skip100 end
    drawV100(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 137 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 137 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip100::
    imgui.EndChild()

    imgui.SeparatorText("Bug Fixes")
    imgui.BulletText("Fix LN Ends feature now flips LN ends, even if the corresponding ending SV is 0.")
    imgui.BulletText("Allowed Still to treat LN ends as displacement markers.")

    imgui.SeparatorText("New Features")
    imgui.BulletText("Added the SSF equivalent to all Standard SV shapes.")
    imgui.BulletText(
        "Added the Select tab, which allows users to quickly select desired notes based on\na variety of conditions. Currently, there is the Alternate option and the Snap option.")

    imgui.PopStyleColor()
    imgui.End()
end

---Draws v200 on screen, with dimensions = scale * [144,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV200(ctx, location, scale, col, thickness)
    location = location - vector.New(72, 24) * scale
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
    ctx.AddBezierCubic(location + scale * vector.New(41.9, 32.1), location + scale * vector.New(43.31333333333333, 30.56),
        location + scale * vector.New(44.473333333333336, 29.22), location + scale * vector.New(45.38, 28.08), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(45.38, 28.08),
        location + scale * vector.New(46.29333333333333, 26.939999999999998),
        location + scale * vector.New(46.97333333333333, 25.86333333333333), location + scale * vector.New(47.42, 24.85),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.42, 24.85),
        location + scale * vector.New(47.85999999999999, 23.836666666666666),
        location + scale * vector.New(48.07999999999999, 22.77333333333333), location + scale * vector.New(48.08, 21.66),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(48.08, 21.66),
        location + scale * vector.New(48.07999999999999, 20.38),
        location + scale * vector.New(47.77666666666666, 19.273333333333333), location + scale * vector.New(47.17, 18.34),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.17, 18.34),
        location + scale * vector.New(46.556666666666665, 17.406666666666666),
        location + scale * vector.New(45.72333333333333, 16.686666666666667), location + scale * vector.New(44.67, 16.18),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.67, 16.18),
        location + scale * vector.New(43.61666666666667, 15.666666666666666),
        location + scale * vector.New(42.43333333333333, 15.41), location + scale * vector.New(41.12, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.12, 15.41),
        location + scale * vector.New(39.72666666666667, 15.41), location + scale * vector.New(38.51, 15.696666666666665),
        location + scale * vector.New(37.47, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(37.47, 16.27),
        location + scale * vector.New(36.43666666666667, 16.84333333333333),
        location + scale * vector.New(35.64, 17.646666666666665), location + scale * vector.New(35.08, 18.68), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.08, 18.68),
        location + scale * vector.New(34.51333333333333, 19.706666666666663),
        location + scale * vector.New(34.23, 20.913333333333334), location + scale * vector.New(34.23, 22.3), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(34.23, 22.3), location + scale * vector.New(34.23, 22.3),
        location + scale * vector.New(30.04, 22.3), location + scale * vector.New(30.04, 22.3), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(30.04, 22.3),
        location + scale * vector.New(30.039999999999996, 20.173333333333332),
        location + scale * vector.New(30.53333333333333, 18.30333333333333), location + scale * vector.New(31.52, 16.69),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(31.52, 16.69),
        location + scale * vector.New(32.5, 15.083333333333332),
        location + scale * vector.New(33.839999999999996, 13.829999999999998),
        location + scale * vector.New(35.54, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.54, 12.93), location + scale * vector.New(37.24, 12.03),
        location + scale * vector.New(39.14666666666667, 11.58), location + scale * vector.New(41.26, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.26, 11.58),
        location + scale * vector.New(43.39333333333333, 11.58), location + scale * vector.New(45.28333333333333, 12.03),
        location + scale * vector.New(46.93, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(46.93, 12.93),
        location + scale * vector.New(48.57666666666666, 13.829999999999998),
        location + scale * vector.New(49.86666666666666, 15.043333333333333), location + scale * vector.New(50.8, 16.57),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(50.8, 16.57),
        location + scale * vector.New(51.73333333333333, 18.096666666666664),
        location + scale * vector.New(52.199999999999996, 19.793333333333333), location + scale * vector.New(52.2, 21.66),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.2, 21.66), location + scale * vector.New(52.199999999999996, 23),
        location + scale * vector.New(51.959999999999994, 24.306666666666665),
        location + scale * vector.New(51.48, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(51.48, 25.58),
        location + scale * vector.New(50.99999999999999, 26.85333333333333),
        location + scale * vector.New(50.17333333333333, 28.266666666666666), location + scale * vector.New(49, 29.82),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(49, 29.82),
        location + scale * vector.New(47.81999999999999, 31.379999999999995),
        location + scale * vector.New(46.19, 33.276666666666664), location + scale * vector.New(44.11, 35.51), col,
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
        location + scale * vector.New(62.406666666666666, 48.72),
        location + scale * vector.New(61.656666666666666, 48.406666666666666),
        location + scale * vector.New(61.03, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 47.78),
        location + scale * vector.New(60.403333333333336, 47.153333333333336),
        location + scale * vector.New(60.09, 46.403333333333336), location + scale * vector.New(60.09, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(60.09, 45.53), location + scale * vector.New(60.09, 44.65),
        location + scale * vector.New(60.403333333333336, 43.89666666666667), location + scale * vector.New(61.03, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 43.27),
        location + scale * vector.New(61.656666666666666, 42.64333333333333),
        location + scale * vector.New(62.406666666666666, 42.33), location + scale * vector.New(63.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 42.33), location + scale * vector.New(64.16, 42.33),
        location + scale * vector.New(64.91333333333333, 42.64333333333333), location + scale * vector.New(65.54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(65.54, 43.27),
        location + scale * vector.New(66.16666666666667, 43.89666666666667), location + scale * vector.New(66.48, 44.65),
        location + scale * vector.New(66.48, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.48, 45.53), location + scale * vector.New(66.48, 46.11),
        location + scale * vector.New(66.33333333333334, 46.63999999999999), location + scale * vector.New(66.04, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.04, 47.12),
        location + scale * vector.New(65.75333333333333, 47.60666666666666),
        location + scale * vector.New(65.36999999999999, 47.99666666666666), location + scale * vector.New(64.89, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(64.89, 48.29),
        location + scale * vector.New(64.41, 48.57666666666666), location + scale * vector.New(63.873333333333335, 48.72),
        location + scale * vector.New(63.28, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 48.93),
        location + scale * vector.New(83.11999999999999, 48.92999999999999),
        location + scale * vector.New(80.83999999999999, 48.199999999999996), location + scale * vector.New(78.96, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.96, 46.74),
        location + scale * vector.New(77.08, 45.279999999999994), location + scale * vector.New(75.64, 43.15666666666666),
        location + scale * vector.New(74.64, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.64, 40.37),
        location + scale * vector.New(73.64666666666666, 37.58333333333333),
        location + scale * vector.New(73.15, 34.21333333333333), location + scale * vector.New(73.15, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.15, 30.26),
        location + scale * vector.New(73.15, 26.326666666666664),
        location + scale * vector.New(73.65, 22.966666666666665), location + scale * vector.New(74.65, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.65, 20.18),
        location + scale * vector.New(75.65, 17.39333333333333),
        location + scale * vector.New(77.09666666666666, 15.263333333333332), location + scale * vector.New(78.99, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.99, 13.79),
        location + scale * vector.New(80.87666666666667, 12.316666666666666),
        location + scale * vector.New(83.14666666666666, 11.58), location + scale * vector.New(85.8, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 11.58),
        location + scale * vector.New(88.44666666666666, 11.58),
        location + scale * vector.New(90.71333333333332, 12.316666666666666), location + scale * vector.New(92.6, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.6, 13.79),
        location + scale * vector.New(94.49333333333333, 15.263333333333332),
        location + scale * vector.New(95.94, 17.39333333333333), location + scale * vector.New(96.94, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.94, 20.18),
        location + scale * vector.New(97.94, 22.966666666666665),
        location + scale * vector.New(98.44, 26.326666666666664), location + scale * vector.New(98.44, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.44, 30.26),
        location + scale * vector.New(98.44, 34.21333333333333),
        location + scale * vector.New(97.94333333333333, 37.58333333333333), location + scale * vector.New(96.95, 40.37),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.95, 40.37),
        location + scale * vector.New(95.94999999999999, 43.15666666666666),
        location + scale * vector.New(94.50999999999999, 45.279999999999994), location + scale * vector.New(92.63, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.63, 46.74),
        location + scale * vector.New(90.75, 48.199999999999996),
        location + scale * vector.New(88.47333333333333, 48.92999999999999), location + scale * vector.New(85.8, 48.93),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 45.03),
        location + scale * vector.New(88.44666666666666, 45.03), location + scale * vector.New(90.50333333333333, 43.75),
        location + scale * vector.New(91.97, 41.19), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.97, 41.19),
        location + scale * vector.New(93.44333333333333, 38.63666666666666),
        location + scale * vector.New(94.18, 34.99333333333333), location + scale * vector.New(94.18, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.18, 30.26),
        location + scale * vector.New(94.18, 27.106666666666666),
        location + scale * vector.New(93.84333333333333, 24.423333333333332), location + scale * vector.New(93.17, 22.21),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.17, 22.21),
        location + scale * vector.New(92.50333333333333, 19.996666666666666),
        location + scale * vector.New(91.54666666666667, 18.31), location + scale * vector.New(90.3, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.3, 17.15),
        location + scale * vector.New(89.04666666666667, 15.989999999999998),
        location + scale * vector.New(87.54666666666667, 15.41), location + scale * vector.New(85.8, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 15.41),
        location + scale * vector.New(83.16666666666666, 15.41),
        location + scale * vector.New(81.10999999999999, 16.703333333333333), location + scale * vector.New(79.63, 19.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.63, 19.29),
        location + scale * vector.New(78.14999999999999, 21.876666666666665),
        location + scale * vector.New(77.41, 25.53333333333333), location + scale * vector.New(77.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(77.41, 30.26),
        location + scale * vector.New(77.41, 33.406666666666666), location + scale * vector.New(77.74333333333333, 36.08),
        location + scale * vector.New(78.41, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.41, 38.28), location + scale * vector.New(79.07, 40.48),
        location + scale * vector.New(80.02666666666667, 42.156666666666666), location + scale * vector.New(81.28, 43.31),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(81.28, 43.31),
        location + scale * vector.New(82.52666666666667, 44.45666666666666),
        location + scale * vector.New(84.03333333333333, 45.03), location + scale * vector.New(85.8, 45.03), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 48.72),
        location + scale * vector.New(107.43666666666667, 48.72),
        location + scale * vector.New(106.68333333333332, 48.406666666666666),
        location + scale * vector.New(106.05, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 47.78),
        location + scale * vector.New(105.42333333333332, 47.153333333333336),
        location + scale * vector.New(105.10999999999999, 46.403333333333336),
        location + scale * vector.New(105.11, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.11, 45.53),
        location + scale * vector.New(105.10999999999999, 44.65),
        location + scale * vector.New(105.42333333333332, 43.89666666666667),
        location + scale * vector.New(106.05, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 43.27),
        location + scale * vector.New(106.68333333333332, 42.64333333333333),
        location + scale * vector.New(107.43666666666667, 42.33), location + scale * vector.New(108.31, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 42.33),
        location + scale * vector.New(109.18333333333334, 42.33),
        location + scale * vector.New(109.93333333333334, 42.64333333333333),
        location + scale * vector.New(110.56, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.56, 43.27),
        location + scale * vector.New(111.19333333333333, 43.89666666666667),
        location + scale * vector.New(111.51, 44.65), location + scale * vector.New(111.51, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.51, 45.53), location + scale * vector.New(111.51, 46.11),
        location + scale * vector.New(111.36333333333333, 46.63999999999999),
        location + scale * vector.New(111.07, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.07, 47.12),
        location + scale * vector.New(110.78333333333332, 47.60666666666666),
        location + scale * vector.New(110.39999999999999, 47.99666666666666),
        location + scale * vector.New(109.92, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.92, 48.29),
        location + scale * vector.New(109.44, 48.57666666666666),
        location + scale * vector.New(108.90333333333334, 48.72), location + scale * vector.New(108.31, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 48.93),
        location + scale * vector.New(128.14666666666665, 48.92999999999999),
        location + scale * vector.New(125.86999999999999, 48.199999999999996),
        location + scale * vector.New(123.99, 46.74), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.99, 46.74),
        location + scale * vector.New(122.10333333333332, 45.279999999999994),
        location + scale * vector.New(120.66333333333333, 43.15666666666666),
        location + scale * vector.New(119.67, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.67, 40.37),
        location + scale * vector.New(118.67666666666666, 37.58333333333333),
        location + scale * vector.New(118.17999999999999, 34.21333333333333),
        location + scale * vector.New(118.18, 30.26), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.18, 30.26),
        location + scale * vector.New(118.17999999999999, 26.326666666666664),
        location + scale * vector.New(118.67999999999999, 22.966666666666665),
        location + scale * vector.New(119.68, 20.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.68, 20.18),
        location + scale * vector.New(120.67999999999999, 17.39333333333333),
        location + scale * vector.New(122.12333333333333, 15.263333333333332),
        location + scale * vector.New(124.01, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.01, 13.79),
        location + scale * vector.New(125.90333333333334, 12.316666666666666),
        location + scale * vector.New(128.17333333333332, 11.58), location + scale * vector.New(130.82, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 11.58),
        location + scale * vector.New(133.47333333333333, 11.58),
        location + scale * vector.New(135.74333333333334, 12.316666666666666),
        location + scale * vector.New(137.63, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137.63, 13.79),
        location + scale * vector.New(139.5233333333333, 15.263333333333332),
        location + scale * vector.New(140.97, 17.39333333333333), location + scale * vector.New(141.97, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(141.97, 20.18),
        location + scale * vector.New(142.97, 22.966666666666665),
        location + scale * vector.New(143.47, 26.326666666666664), location + scale * vector.New(143.47, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(143.47, 30.26),
        location + scale * vector.New(143.47, 34.21333333333333),
        location + scale * vector.New(142.97, 37.58333333333333), location + scale * vector.New(141.97, 40.37), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(141.97, 40.37),
        location + scale * vector.New(140.97666666666666, 43.15666666666666),
        location + scale * vector.New(139.54, 45.279999999999994), location + scale * vector.New(137.66, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137.66, 46.74),
        location + scale * vector.New(135.78, 48.199999999999996),
        location + scale * vector.New(133.5, 48.92999999999999), location + scale * vector.New(130.82, 48.93), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 45.03),
        location + scale * vector.New(133.47333333333333, 45.03),
        location + scale * vector.New(135.53333333333333, 43.75), location + scale * vector.New(137, 41.19), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137, 41.19),
        location + scale * vector.New(138.46666666666664, 38.63666666666666),
        location + scale * vector.New(139.2, 34.99333333333333), location + scale * vector.New(139.2, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(139.2, 30.26),
        location + scale * vector.New(139.2, 27.106666666666666),
        location + scale * vector.New(138.86666666666665, 24.423333333333332),
        location + scale * vector.New(138.2, 22.21), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(138.2, 22.21),
        location + scale * vector.New(137.5333333333333, 19.996666666666666),
        location + scale * vector.New(136.57333333333332, 18.31), location + scale * vector.New(135.32, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(135.32, 17.15),
        location + scale * vector.New(134.07333333333332, 15.989999999999998),
        location + scale * vector.New(132.57333333333332, 15.41), location + scale * vector.New(130.82, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 15.41),
        location + scale * vector.New(128.19333333333333, 15.41),
        location + scale * vector.New(126.13999999999999, 16.703333333333333),
        location + scale * vector.New(124.66, 19.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.66, 19.29),
        location + scale * vector.New(123.17999999999999, 21.876666666666665),
        location + scale * vector.New(122.44, 25.53333333333333), location + scale * vector.New(122.44, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.44, 30.26),
        location + scale * vector.New(122.44, 33.406666666666666),
        location + scale * vector.New(122.77333333333333, 36.08), location + scale * vector.New(123.44, 38.28), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.44, 38.28), location + scale * vector.New(124.1, 40.48),
        location + scale * vector.New(125.05666666666667, 42.156666666666666),
        location + scale * vector.New(126.31, 43.31), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.31, 43.31),
        location + scale * vector.New(127.55666666666667, 44.45666666666666),
        location + scale * vector.New(129.06, 45.03), location + scale * vector.New(130.82, 45.03), col, thickness)
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
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
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
        location + scale * vector.New(92.37666666666667, 48.72),
        location + scale * vector.New(91.62666666666667, 48.406666666666666), location + scale * vector.New(91, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 47.78),
        location + scale * vector.New(90.37333333333333, 47.153333333333336),
        location + scale * vector.New(90.06, 46.403333333333336), location + scale * vector.New(90.06, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.06, 45.53), location + scale * vector.New(90.06, 44.65),
        location + scale * vector.New(90.37333333333333, 43.89666666666667), location + scale * vector.New(91, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 43.27),
        location + scale * vector.New(91.62666666666667, 42.64333333333333),
        location + scale * vector.New(92.37666666666667, 42.33), location + scale * vector.New(93.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 42.33), location + scale * vector.New(94.13, 42.33),
        location + scale * vector.New(94.88333333333333, 42.64333333333333), location + scale * vector.New(95.51, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.51, 43.27),
        location + scale * vector.New(96.13666666666666, 43.89666666666667),
        location + scale * vector.New(96.44999999999999, 44.65), location + scale * vector.New(96.45, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.45, 45.53),
        location + scale * vector.New(96.44999999999999, 46.11),
        location + scale * vector.New(96.30333333333333, 46.63999999999999), location + scale * vector.New(96.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.01, 47.12),
        location + scale * vector.New(95.72333333333333, 47.60666666666666),
        location + scale * vector.New(95.34, 47.99666666666666), location + scale * vector.New(94.86, 48.29), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.86, 48.29),
        location + scale * vector.New(94.38, 48.57666666666666), location + scale * vector.New(93.84333333333333, 48.72),
        location + scale * vector.New(93.25, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.91, 48.44), location + scale * vector.New(103.91, 48.44),
        location + scale * vector.New(103.91, 45.24), location + scale * vector.New(103.91, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.91, 45.24), location + scale * vector.New(103.91, 45.24),
        location + scale * vector.New(115.91, 32.1), location + scale * vector.New(115.91, 32.1), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.91, 32.1),
        location + scale * vector.New(117.31666666666666, 30.56),
        location + scale * vector.New(118.47666666666666, 29.22), location + scale * vector.New(119.39, 28.08), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.39, 28.08),
        location + scale * vector.New(120.30333333333333, 26.939999999999998),
        location + scale * vector.New(120.97999999999999, 25.86333333333333),
        location + scale * vector.New(121.42, 24.85), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.42, 24.85),
        location + scale * vector.New(121.86666666666666, 23.836666666666666),
        location + scale * vector.New(122.09, 22.77333333333333), location + scale * vector.New(122.09, 21.66), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.09, 21.66), location + scale * vector.New(122.09, 20.38),
        location + scale * vector.New(121.78333333333333, 19.273333333333333),
        location + scale * vector.New(121.17, 18.34), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.17, 18.34),
        location + scale * vector.New(120.56333333333333, 17.406666666666666),
        location + scale * vector.New(119.73333333333333, 16.686666666666667),
        location + scale * vector.New(118.68, 16.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.68, 16.18),
        location + scale * vector.New(117.62666666666667, 15.666666666666666),
        location + scale * vector.New(116.44333333333333, 15.41), location + scale * vector.New(115.13, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.13, 15.41),
        location + scale * vector.New(113.72999999999999, 15.41),
        location + scale * vector.New(112.51333333333332, 15.696666666666665),
        location + scale * vector.New(111.48, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.48, 16.27),
        location + scale * vector.New(110.44666666666666, 16.84333333333333),
        location + scale * vector.New(109.64666666666666, 17.646666666666665),
        location + scale * vector.New(109.08, 18.68), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.08, 18.68),
        location + scale * vector.New(108.52, 19.706666666666663),
        location + scale * vector.New(108.24, 20.913333333333334), location + scale * vector.New(108.24, 22.3), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.24, 22.3), location + scale * vector.New(108.24, 22.3),
        location + scale * vector.New(104.05, 22.3), location + scale * vector.New(104.05, 22.3), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.05, 22.3),
        location + scale * vector.New(104.04999999999998, 20.173333333333332),
        location + scale * vector.New(104.53999999999999, 18.30333333333333),
        location + scale * vector.New(105.52, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.52, 16.69),
        location + scale * vector.New(106.50666666666666, 15.083333333333332),
        location + scale * vector.New(107.84666666666666, 13.829999999999998),
        location + scale * vector.New(109.54, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.54, 12.93), location + scale * vector.New(111.24, 12.03),
        location + scale * vector.New(113.14999999999999, 11.58), location + scale * vector.New(115.27, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.27, 11.58),
        location + scale * vector.New(117.40333333333332, 11.58),
        location + scale * vector.New(119.28999999999999, 12.03), location + scale * vector.New(120.93, 12.93), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.93, 12.93),
        location + scale * vector.New(122.57666666666667, 13.829999999999998),
        location + scale * vector.New(123.86666666666666, 15.043333333333333),
        location + scale * vector.New(124.8, 16.57), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.8, 16.57),
        location + scale * vector.New(125.73999999999998, 18.096666666666664),
        location + scale * vector.New(126.20999999999998, 19.793333333333333),
        location + scale * vector.New(126.21, 21.66), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.21, 21.66),
        location + scale * vector.New(126.20999999999998, 23),
        location + scale * vector.New(125.96999999999998, 24.306666666666665),
        location + scale * vector.New(125.49, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(125.49, 25.58),
        location + scale * vector.New(125.00999999999999, 26.85333333333333),
        location + scale * vector.New(124.17999999999999, 28.266666666666666), location + scale * vector.New(123, 29.82),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123, 29.82),
        location + scale * vector.New(121.82666666666665, 31.379999999999995),
        location + scale * vector.New(120.19666666666666, 33.276666666666664),
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
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
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
        location + scale * vector.New(92.37666666666667, 48.72),
        location + scale * vector.New(91.62666666666667, 48.406666666666666), location + scale * vector.New(91, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 47.78),
        location + scale * vector.New(90.37333333333333, 47.153333333333336),
        location + scale * vector.New(90.06, 46.403333333333336), location + scale * vector.New(90.06, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.06, 45.53), location + scale * vector.New(90.06, 44.65),
        location + scale * vector.New(90.37333333333333, 43.89666666666667), location + scale * vector.New(91, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 43.27),
        location + scale * vector.New(91.62666666666667, 42.64333333333333),
        location + scale * vector.New(92.37666666666667, 42.33), location + scale * vector.New(93.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 42.33), location + scale * vector.New(94.13, 42.33),
        location + scale * vector.New(94.88333333333333, 42.64333333333333), location + scale * vector.New(95.51, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.51, 43.27),
        location + scale * vector.New(96.13666666666666, 43.89666666666667),
        location + scale * vector.New(96.44999999999999, 44.65), location + scale * vector.New(96.45, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.45, 45.53),
        location + scale * vector.New(96.44999999999999, 46.11),
        location + scale * vector.New(96.30333333333333, 46.63999999999999), location + scale * vector.New(96.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.01, 47.12),
        location + scale * vector.New(95.72333333333333, 47.60666666666666),
        location + scale * vector.New(95.34, 47.99666666666666), location + scale * vector.New(94.86, 48.29), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.86, 48.29),
        location + scale * vector.New(94.38, 48.57666666666666), location + scale * vector.New(93.84333333333333, 48.72),
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
---@param col integer
---@param thickness integer
function drawV110(ctx, location, scale, col, thickness)
    location = location - vector.New(64.5, 24) * scale
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
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
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
        location + scale * vector.New(92.37666666666667, 48.72),
        location + scale * vector.New(91.62666666666667, 48.406666666666666), location + scale * vector.New(91, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 47.78),
        location + scale * vector.New(90.37333333333333, 47.153333333333336),
        location + scale * vector.New(90.06, 46.403333333333336), location + scale * vector.New(90.06, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.06, 45.53), location + scale * vector.New(90.06, 44.65),
        location + scale * vector.New(90.37333333333333, 43.89666666666667), location + scale * vector.New(91, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 43.27),
        location + scale * vector.New(91.62666666666667, 42.64333333333333),
        location + scale * vector.New(92.37666666666667, 42.33), location + scale * vector.New(93.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 42.33), location + scale * vector.New(94.13, 42.33),
        location + scale * vector.New(94.88333333333333, 42.64333333333333), location + scale * vector.New(95.51, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.51, 43.27),
        location + scale * vector.New(96.13666666666666, 43.89666666666667),
        location + scale * vector.New(96.44999999999999, 44.65), location + scale * vector.New(96.45, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.45, 45.53),
        location + scale * vector.New(96.44999999999999, 46.11),
        location + scale * vector.New(96.30333333333333, 46.63999999999999), location + scale * vector.New(96.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.01, 47.12),
        location + scale * vector.New(95.72333333333333, 47.60666666666666),
        location + scale * vector.New(95.34, 47.99666666666666), location + scale * vector.New(94.86, 48.29), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.86, 48.29),
        location + scale * vector.New(94.38, 48.57666666666666), location + scale * vector.New(93.84333333333333, 48.72),
        location + scale * vector.New(93.25, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 48.93),
        location + scale * vector.New(113.09, 48.92999999999999),
        location + scale * vector.New(110.81, 48.199999999999996), location + scale * vector.New(108.93, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.93, 46.74),
        location + scale * vector.New(107.05, 45.279999999999994),
        location + scale * vector.New(105.61333333333333, 43.15666666666666),
        location + scale * vector.New(104.62, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.62, 40.37),
        location + scale * vector.New(103.62666666666667, 37.58333333333333),
        location + scale * vector.New(103.13, 34.21333333333333), location + scale * vector.New(103.13, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.13, 30.26),
        location + scale * vector.New(103.13, 26.326666666666664),
        location + scale * vector.New(103.63, 22.966666666666665), location + scale * vector.New(104.63, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.63, 20.18),
        location + scale * vector.New(105.63, 17.39333333333333),
        location + scale * vector.New(107.07333333333332, 15.263333333333332),
        location + scale * vector.New(108.96, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.96, 13.79),
        location + scale * vector.New(110.84666666666666, 12.316666666666666),
        location + scale * vector.New(113.11666666666667, 11.58), location + scale * vector.New(115.77, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 11.58),
        location + scale * vector.New(118.41666666666666, 11.58),
        location + scale * vector.New(120.68666666666665, 12.316666666666666),
        location + scale * vector.New(122.58, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.58, 13.79),
        location + scale * vector.New(124.46666666666665, 15.263333333333332),
        location + scale * vector.New(125.90999999999998, 17.39333333333333),
        location + scale * vector.New(126.91, 20.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.91, 20.18),
        location + scale * vector.New(127.90999999999998, 22.966666666666665),
        location + scale * vector.New(128.40999999999997, 26.326666666666664),
        location + scale * vector.New(128.41, 30.26), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(128.41, 30.26),
        location + scale * vector.New(128.40999999999997, 34.21333333333333),
        location + scale * vector.New(127.91333333333333, 37.58333333333333),
        location + scale * vector.New(126.92, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.92, 40.37),
        location + scale * vector.New(125.92666666666668, 43.15666666666666),
        location + scale * vector.New(124.48666666666666, 45.279999999999994),
        location + scale * vector.New(122.6, 46.74), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.6, 46.74),
        location + scale * vector.New(120.71999999999998, 48.199999999999996),
        location + scale * vector.New(118.44333333333333, 48.92999999999999),
        location + scale * vector.New(115.77, 48.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 45.03),
        location + scale * vector.New(118.41666666666666, 45.03),
        location + scale * vector.New(120.47666666666666, 43.75), location + scale * vector.New(121.95, 41.19), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.95, 41.19),
        location + scale * vector.New(123.41666666666666, 38.63666666666666),
        location + scale * vector.New(124.15, 34.99333333333333), location + scale * vector.New(124.15, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.15, 30.26),
        location + scale * vector.New(124.15, 27.106666666666666),
        location + scale * vector.New(123.81333333333333, 24.423333333333332),
        location + scale * vector.New(123.14, 22.21), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.14, 22.21),
        location + scale * vector.New(122.47333333333333, 19.996666666666666),
        location + scale * vector.New(121.51666666666665, 18.31), location + scale * vector.New(120.27, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.27, 17.15),
        location + scale * vector.New(119.01666666666665, 15.989999999999998),
        location + scale * vector.New(117.51666666666665, 15.41), location + scale * vector.New(115.77, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 15.41),
        location + scale * vector.New(113.14333333333332, 15.41),
        location + scale * vector.New(111.08999999999999, 16.703333333333333),
        location + scale * vector.New(109.61, 19.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.61, 19.29),
        location + scale * vector.New(108.13, 21.876666666666665),
        location + scale * vector.New(107.39, 25.53333333333333), location + scale * vector.New(107.39, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(107.39, 30.26),
        location + scale * vector.New(107.39, 33.406666666666666), location + scale * vector.New(107.72, 36.08),
        location + scale * vector.New(108.38, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.38, 38.28),
        location + scale * vector.New(109.04666666666665, 40.48),
        location + scale * vector.New(110.00333333333332, 42.156666666666666),
        location + scale * vector.New(111.25, 43.31), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.25, 43.31),
        location + scale * vector.New(112.49666666666666, 44.45666666666666),
        location + scale * vector.New(114.00333333333333, 45.03), location + scale * vector.New(115.77, 45.03), col,
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
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 48.93),
        location + scale * vector.New(76.08666666666666, 48.92999999999999),
        location + scale * vector.New(73.81, 48.199999999999996), location + scale * vector.New(71.93, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.93, 46.74),
        location + scale * vector.New(70.05, 45.279999999999994), location + scale * vector.New(68.61, 43.15666666666666),
        location + scale * vector.New(67.61, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.61, 40.37),
        location + scale * vector.New(66.61666666666666, 37.58333333333333),
        location + scale * vector.New(66.12, 34.21333333333333), location + scale * vector.New(66.12, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.12, 30.26),
        location + scale * vector.New(66.12, 26.326666666666664),
        location + scale * vector.New(66.62, 22.966666666666665), location + scale * vector.New(67.62, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.62, 20.18),
        location + scale * vector.New(68.62, 17.39333333333333),
        location + scale * vector.New(70.06333333333333, 15.263333333333332), location + scale * vector.New(71.95, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.95, 13.79),
        location + scale * vector.New(73.84333333333333, 12.316666666666666),
        location + scale * vector.New(76.11333333333333, 11.58), location + scale * vector.New(78.76, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 11.58),
        location + scale * vector.New(81.41333333333333, 11.58),
        location + scale * vector.New(83.68333333333332, 12.316666666666666), location + scale * vector.New(85.57, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.57, 13.79),
        location + scale * vector.New(87.46333333333332, 15.263333333333332),
        location + scale * vector.New(88.91, 17.39333333333333), location + scale * vector.New(89.91, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 20.18),
        location + scale * vector.New(90.91, 22.966666666666665),
        location + scale * vector.New(91.41, 26.326666666666664), location + scale * vector.New(91.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.41, 30.26),
        location + scale * vector.New(91.41, 34.21333333333333), location + scale * vector.New(90.91, 37.58333333333333),
        location + scale * vector.New(89.91, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 40.37),
        location + scale * vector.New(88.91666666666666, 43.15666666666666),
        location + scale * vector.New(87.47999999999999, 45.279999999999994), location + scale * vector.New(85.6, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.6, 46.74),
        location + scale * vector.New(83.72, 48.199999999999996), location + scale * vector.New(81.44, 48.92999999999999),
        location + scale * vector.New(78.76, 48.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 45.03),
        location + scale * vector.New(81.41333333333333, 45.03), location + scale * vector.New(83.47333333333333, 43.75),
        location + scale * vector.New(84.94, 41.19), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(84.94, 41.19),
        location + scale * vector.New(86.40666666666667, 38.63666666666666),
        location + scale * vector.New(87.14, 34.99333333333333), location + scale * vector.New(87.14, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(87.14, 30.26),
        location + scale * vector.New(87.14, 27.106666666666666),
        location + scale * vector.New(86.80666666666667, 24.423333333333332), location + scale * vector.New(86.14, 22.21),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.14, 22.21),
        location + scale * vector.New(85.47333333333333, 19.996666666666666),
        location + scale * vector.New(84.51666666666667, 18.31), location + scale * vector.New(83.27, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(83.27, 17.15),
        location + scale * vector.New(82.01666666666667, 15.989999999999998),
        location + scale * vector.New(80.51333333333334, 15.41), location + scale * vector.New(78.76, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 15.41),
        location + scale * vector.New(76.13333333333333, 15.41),
        location + scale * vector.New(74.07999999999998, 16.703333333333333), location + scale * vector.New(72.6, 19.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(72.6, 19.29),
        location + scale * vector.New(71.11999999999999, 21.876666666666665),
        location + scale * vector.New(70.38, 25.53333333333333), location + scale * vector.New(70.38, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(70.38, 30.26),
        location + scale * vector.New(70.38, 33.406666666666666), location + scale * vector.New(70.71333333333332, 36.08),
        location + scale * vector.New(71.38, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.38, 38.28),
        location + scale * vector.New(72.03999999999999, 40.48),
        location + scale * vector.New(72.99666666666667, 42.156666666666666), location + scale * vector.New(74.25, 43.31),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.25, 43.31),
        location + scale * vector.New(75.49666666666667, 44.45666666666666), location + scale * vector.New(77, 45.03),
        location + scale * vector.New(78.76, 45.03), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 48.72),
        location + scale * vector.New(100.39999999999998, 48.72),
        location + scale * vector.New(99.64666666666665, 48.406666666666666), location + scale * vector.New(99.02, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 47.78),
        location + scale * vector.New(98.39333333333332, 47.153333333333336),
        location + scale * vector.New(98.07999999999998, 46.403333333333336), location + scale * vector.New(98.08, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.08, 45.53),
        location + scale * vector.New(98.07999999999998, 44.65),
        location + scale * vector.New(98.39333333333332, 43.89666666666667), location + scale * vector.New(99.02, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 43.27),
        location + scale * vector.New(99.64666666666665, 42.64333333333333),
        location + scale * vector.New(100.39999999999998, 42.33), location + scale * vector.New(101.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 42.33),
        location + scale * vector.New(102.15333333333334, 42.33),
        location + scale * vector.New(102.90333333333334, 42.64333333333333),
        location + scale * vector.New(103.53, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.53, 43.27),
        location + scale * vector.New(104.15666666666667, 43.89666666666667),
        location + scale * vector.New(104.47, 44.65), location + scale * vector.New(104.47, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.47, 45.53), location + scale * vector.New(104.47, 46.11),
        location + scale * vector.New(104.32666666666665, 46.63999999999999),
        location + scale * vector.New(104.04, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.04, 47.12),
        location + scale * vector.New(103.74666666666667, 47.60666666666666),
        location + scale * vector.New(103.36333333333333, 47.99666666666666),
        location + scale * vector.New(102.89, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(102.89, 48.29),
        location + scale * vector.New(102.41, 48.57666666666666),
        location + scale * vector.New(101.87333333333333, 48.72), location + scale * vector.New(101.28, 48.72), col,
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
---@param col integer
---@param thickness integer
function drawV100(ctx, location, scale, col, thickness)
    location = location - vector.New(68.5, 24) * scale
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
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 48.93),
        location + scale * vector.New(76.08666666666666, 48.92999999999999),
        location + scale * vector.New(73.81, 48.199999999999996), location + scale * vector.New(71.93, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.93, 46.74),
        location + scale * vector.New(70.05, 45.279999999999994), location + scale * vector.New(68.61, 43.15666666666666),
        location + scale * vector.New(67.61, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.61, 40.37),
        location + scale * vector.New(66.61666666666666, 37.58333333333333),
        location + scale * vector.New(66.12, 34.21333333333333), location + scale * vector.New(66.12, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.12, 30.26),
        location + scale * vector.New(66.12, 26.326666666666664),
        location + scale * vector.New(66.62, 22.966666666666665), location + scale * vector.New(67.62, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.62, 20.18),
        location + scale * vector.New(68.62, 17.39333333333333),
        location + scale * vector.New(70.06333333333333, 15.263333333333332), location + scale * vector.New(71.95, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.95, 13.79),
        location + scale * vector.New(73.84333333333333, 12.316666666666666),
        location + scale * vector.New(76.11333333333333, 11.58), location + scale * vector.New(78.76, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 11.58),
        location + scale * vector.New(81.41333333333333, 11.58),
        location + scale * vector.New(83.68333333333332, 12.316666666666666), location + scale * vector.New(85.57, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.57, 13.79),
        location + scale * vector.New(87.46333333333332, 15.263333333333332),
        location + scale * vector.New(88.91, 17.39333333333333), location + scale * vector.New(89.91, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 20.18),
        location + scale * vector.New(90.91, 22.966666666666665),
        location + scale * vector.New(91.41, 26.326666666666664), location + scale * vector.New(91.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.41, 30.26),
        location + scale * vector.New(91.41, 34.21333333333333), location + scale * vector.New(90.91, 37.58333333333333),
        location + scale * vector.New(89.91, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 40.37),
        location + scale * vector.New(88.91666666666666, 43.15666666666666),
        location + scale * vector.New(87.47999999999999, 45.279999999999994), location + scale * vector.New(85.6, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.6, 46.74),
        location + scale * vector.New(83.72, 48.199999999999996), location + scale * vector.New(81.44, 48.92999999999999),
        location + scale * vector.New(78.76, 48.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 45.03),
        location + scale * vector.New(81.41333333333333, 45.03), location + scale * vector.New(83.47333333333333, 43.75),
        location + scale * vector.New(84.94, 41.19), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(84.94, 41.19),
        location + scale * vector.New(86.40666666666667, 38.63666666666666),
        location + scale * vector.New(87.14, 34.99333333333333), location + scale * vector.New(87.14, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(87.14, 30.26),
        location + scale * vector.New(87.14, 27.106666666666666),
        location + scale * vector.New(86.80666666666667, 24.423333333333332), location + scale * vector.New(86.14, 22.21),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.14, 22.21),
        location + scale * vector.New(85.47333333333333, 19.996666666666666),
        location + scale * vector.New(84.51666666666667, 18.31), location + scale * vector.New(83.27, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(83.27, 17.15),
        location + scale * vector.New(82.01666666666667, 15.989999999999998),
        location + scale * vector.New(80.51333333333334, 15.41), location + scale * vector.New(78.76, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 15.41),
        location + scale * vector.New(76.13333333333333, 15.41),
        location + scale * vector.New(74.07999999999998, 16.703333333333333), location + scale * vector.New(72.6, 19.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(72.6, 19.29),
        location + scale * vector.New(71.11999999999999, 21.876666666666665),
        location + scale * vector.New(70.38, 25.53333333333333), location + scale * vector.New(70.38, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(70.38, 30.26),
        location + scale * vector.New(70.38, 33.406666666666666), location + scale * vector.New(70.71333333333332, 36.08),
        location + scale * vector.New(71.38, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.38, 38.28),
        location + scale * vector.New(72.03999999999999, 40.48),
        location + scale * vector.New(72.99666666666667, 42.156666666666666), location + scale * vector.New(74.25, 43.31),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.25, 43.31),
        location + scale * vector.New(75.49666666666667, 44.45666666666666), location + scale * vector.New(77, 45.03),
        location + scale * vector.New(78.76, 45.03), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 48.72),
        location + scale * vector.New(100.39999999999998, 48.72),
        location + scale * vector.New(99.64666666666665, 48.406666666666666), location + scale * vector.New(99.02, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 47.78),
        location + scale * vector.New(98.39333333333332, 47.153333333333336),
        location + scale * vector.New(98.07999999999998, 46.403333333333336), location + scale * vector.New(98.08, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.08, 45.53),
        location + scale * vector.New(98.07999999999998, 44.65),
        location + scale * vector.New(98.39333333333332, 43.89666666666667), location + scale * vector.New(99.02, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 43.27),
        location + scale * vector.New(99.64666666666665, 42.64333333333333),
        location + scale * vector.New(100.39999999999998, 42.33), location + scale * vector.New(101.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 42.33),
        location + scale * vector.New(102.15333333333334, 42.33),
        location + scale * vector.New(102.90333333333334, 42.64333333333333),
        location + scale * vector.New(103.53, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.53, 43.27),
        location + scale * vector.New(104.15666666666667, 43.89666666666667),
        location + scale * vector.New(104.47, 44.65), location + scale * vector.New(104.47, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.47, 45.53), location + scale * vector.New(104.47, 46.11),
        location + scale * vector.New(104.32666666666665, 46.63999999999999),
        location + scale * vector.New(104.04, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.04, 47.12),
        location + scale * vector.New(103.74666666666667, 47.60666666666666),
        location + scale * vector.New(103.36333333333333, 47.99666666666666),
        location + scale * vector.New(102.89, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(102.89, 48.29),
        location + scale * vector.New(102.41, 48.57666666666666),
        location + scale * vector.New(101.87333333333333, 48.72), location + scale * vector.New(101.28, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 48.93),
        location + scale * vector.New(121.11666666666666, 48.92999999999999),
        location + scale * vector.New(118.83999999999999, 48.199999999999996),
        location + scale * vector.New(116.96, 46.74), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.96, 46.74),
        location + scale * vector.New(115.07333333333332, 45.279999999999994),
        location + scale * vector.New(113.63333333333333, 43.15666666666666),
        location + scale * vector.New(112.64, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.64, 40.37),
        location + scale * vector.New(111.64666666666666, 37.58333333333333),
        location + scale * vector.New(111.14999999999999, 34.21333333333333),
        location + scale * vector.New(111.15, 30.26), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.15, 30.26),
        location + scale * vector.New(111.14999999999999, 26.326666666666664),
        location + scale * vector.New(111.64999999999999, 22.966666666666665),
        location + scale * vector.New(112.65, 20.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.65, 20.18),
        location + scale * vector.New(113.64999999999999, 17.39333333333333),
        location + scale * vector.New(115.09333333333333, 15.263333333333332),
        location + scale * vector.New(116.98, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.98, 13.79),
        location + scale * vector.New(118.87333333333333, 12.316666666666666),
        location + scale * vector.New(121.14333333333333, 11.58), location + scale * vector.New(123.79, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 11.58),
        location + scale * vector.New(126.44333333333333, 11.58),
        location + scale * vector.New(128.7133333333333, 12.316666666666666), location + scale * vector.New(130.6, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.6, 13.79),
        location + scale * vector.New(132.48666666666668, 15.263333333333332),
        location + scale * vector.New(133.93, 17.39333333333333), location + scale * vector.New(134.93, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(134.93, 20.18),
        location + scale * vector.New(135.93, 22.966666666666665),
        location + scale * vector.New(136.43, 26.326666666666664), location + scale * vector.New(136.43, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(136.43, 30.26),
        location + scale * vector.New(136.43, 34.21333333333333),
        location + scale * vector.New(135.93333333333334, 37.58333333333333),
        location + scale * vector.New(134.94, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(134.94, 40.37),
        location + scale * vector.New(133.94666666666666, 43.15666666666666),
        location + scale * vector.New(132.51, 45.279999999999994), location + scale * vector.New(130.63, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.63, 46.74),
        location + scale * vector.New(128.75, 48.199999999999996),
        location + scale * vector.New(126.47, 48.92999999999999), location + scale * vector.New(123.79, 48.93), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 45.03),
        location + scale * vector.New(126.44333333333333, 45.03),
        location + scale * vector.New(128.50333333333333, 43.75), location + scale * vector.New(129.97, 41.19), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(129.97, 41.19),
        location + scale * vector.New(131.43666666666664, 38.63666666666666),
        location + scale * vector.New(132.16999999999996, 34.99333333333333),
        location + scale * vector.New(132.17, 30.26), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(132.17, 30.26),
        location + scale * vector.New(132.16999999999996, 27.106666666666666),
        location + scale * vector.New(131.83666666666664, 24.423333333333332),
        location + scale * vector.New(131.17, 22.21), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(131.17, 22.21),
        location + scale * vector.New(130.50333333333333, 19.996666666666666),
        location + scale * vector.New(129.54333333333332, 18.31), location + scale * vector.New(128.29, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(128.29, 17.15),
        location + scale * vector.New(127.04333333333332, 15.989999999999998),
        location + scale * vector.New(125.54333333333334, 15.41), location + scale * vector.New(123.79, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 15.41),
        location + scale * vector.New(121.16333333333333, 15.41),
        location + scale * vector.New(119.10999999999999, 16.703333333333333),
        location + scale * vector.New(117.63, 19.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(117.63, 19.29),
        location + scale * vector.New(116.14999999999999, 21.876666666666665),
        location + scale * vector.New(115.41, 25.53333333333333), location + scale * vector.New(115.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.41, 30.26),
        location + scale * vector.New(115.41, 33.406666666666666),
        location + scale * vector.New(115.74333333333333, 36.08), location + scale * vector.New(116.41, 38.28), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.41, 38.28), location + scale * vector.New(117.07, 40.48),
        location + scale * vector.New(118.02333333333333, 42.156666666666666),
        location + scale * vector.New(119.27, 43.31), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.27, 43.31),
        location + scale * vector.New(120.52333333333333, 44.45666666666666),
        location + scale * vector.New(122.03, 45.03), location + scale * vector.New(123.79, 45.03), col, thickness)
end
