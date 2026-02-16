---@diagnostic disable: redefined-local
function showPatchNotesWindow()
    startNextWindowNotCollapsed('plumoguSV Patch Notes')
    _, patchNotesOpened = imgui.Begin('plumoguSV Patch Notes', true, imgui_window_flags.NoResize)
    imgui.SetWindowSize('plumoguSV Patch Notes', vector.New(500, 400))
    imgui.PushStyleColor(imgui_col.Separator, color.int.white - color.int.alphaMask * 200)

    local minorUpdateLeftColor = color.vrgbaToUint(color.hslaToRgba(math.sin(state.UnixTime / 500) * 60 + 300, 1, 0.7, 1))
    local minorUpdateRightColor = color.vrgbaToUint(color.hslaToRgba(-math.sin(state.UnixTime / 500) * 60 + 300, 1, 0.7,
        1))

    local majorUpdateLeftColor = color.vrgbaToUint(color.hslaToRgba((state.UnixTime % 3600) / 10, 1, 0.7, 1))
    local majorUpdateRightColor = color.vrgbaToUint(color.hslaToRgba(360 - (state.UnixTime % 3600) / 10, 1, 0.7, 1))

    local minHeight = imgui.GetWindowPos().y
    local maxHeight = minHeight + 400

    if (not patchNotesOpened) then
        cache.windows.showPatchNotesWindow = false
    end

    showPatchNotesV210(minorUpdateLeftColor, minorUpdateRightColor)
    showPatchNotesV202(color.int.white)
    showPatchNotesV201(color.int.white)
    showPatchNotesV200(majorUpdateLeftColor, majorUpdateRightColor)
    showPatchNotesV112(color.int.white)
    showPatchNotesV111(color.int.white)
    showPatchNotesV110(minorUpdateLeftColor, minorUpdateRightColor)
    showPatchNotesV101(color.int.white)
    showPatchNotesV100(majorUpdateLeftColor, majorUpdateRightColor)

    imgui.PopStyleColor()
    imgui.End()
end

function showPatchNotesElement(version, logoFunction, logoWidth, colorData, bugFixes, newFeatures)
    AddPadding()
    imgui.BeginChild(version .. 'Bezier', vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    local minHeight = imgui.GetWindowPos().y
    local maxHeight = minHeight + 400

    if (topLeft.y - maxHeight > 0) then goto skipLogoRender end
    if (topLeft.y - minHeight < -50) then goto skipLogoRender end
    do
        local leftColor, rightColor
        if (type(colorData) == 'table') then
            logoFunction(ctx, topLeft + vector.New(243, 17), 1, 1)
            leftColor, rightColor = colorData[1], colorData[2]
        else
            logoFunction(ctx, topLeft + vector.New(243, 17), 1, colorData, 1)
            leftColor, rightColor = colorData, colorData
        end

        ctx.AddRectFilledMultiColor(topLeft + vector.New(0, 25), topLeft + vector.New(243 - logoWidth / 2 - 10, 28),
            leftColor,
            rightColor, rightColor, leftColor)
        ctx.AddRectFilledMultiColor(topLeft + vector.New(243 + logoWidth / 2 + 10, 25), topLeft + vector.New(486, 28),
            rightColor,
            leftColor, leftColor, rightColor)
    end
    ::skipLogoRender::
    imgui.EndChild()
    imgui.SeparatorText('Bug Fixes / Minor Changes')
    for _, v in ipairs(bugFixes) do
        imgui.BulletText(v)
    end
    imgui.SeparatorText('New Features')
    for _, v in ipairs(newFeatures) do
        imgui.BulletText(v)
    end
end
