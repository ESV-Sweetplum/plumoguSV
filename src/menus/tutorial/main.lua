function renderTutorialMenu()
    imgui.SetNextWindowSize(vector.New(600, 500), imgui_cond.Always)
    _, opened = imgui.Begin("plumoguSV Tutorial Menu", true, 26)

    local tutorialWindowName = state.GetValue("tutorialWindowName", "")

    if (not opened) then
        state.SetValue("showTutorialWindow", false)
    end

    local navigatorWidth = 200

    imgui.Columns(2)
    imgui.SetColumnWidth(0, navigatorWidth)
    imgui.SetColumnWidth(1, 600 - navigatorWidth)

    imgui.BeginChild("Tutorial Navigator")

    imgui.SeparatorText("For Beginners")

    if (imgui.TreeNode("Placing SVs")) then
        imgui.Selectable("Your First Effect")
        if (imgui.IsItemClicked()) then
            tutorialWindowName = "Your First Effect"
        end
        imgui.TreePop()
    end
    if (imgui.TreeNode("Removing SVs")) then
        imgui.TreePop()
    end
    if (imgui.TreeNode("Adding Effects")) then
        imgui.TreePop()
    end
    if (imgui.TreeNode("Vibrato")) then
        imgui.TreePop()
    end

    imgui.EndChild()
    imgui.NextColumn()

    imgui.BeginChild("Tutorial Data", vector.New(600 - navigatorWidth - 20, 500), imgui_child_flags
        .AlwaysUseWindowPadding)

    local importantColor = vector.New(1, 0.5, 0.5, 1)

    function ForceHeight(h)
        imgui.SetCursorPosY(h)
        imgui.TextColored(vector4(0), "penis")
    end

    if (tutorialWindowName == "Your First Effect") then
        imgui.SeparatorText("Making your first SV effect")
        imgui.TextWrapped(
            "At the absolute basics of SV are the pulse effects, effects that highlight significant parts of the song, such as a repeating drum. We will apply a very basic stutter SV effect on the drum beat (assuming your song has that), like so:")
        imgui.Dummy(vector.New(0, 10))
        imgui.SetCursorPosX(55)
        imgui.BeginChild("Your First Effect Stutter Example", vector.New(270, 150), imgui_child_flags.Border)
        function distanceFn(t)
            if (t < 0.05) then
                return 800 * t
            elseif (t < 0.25) then
                return 50 * t + 38
            else
                return 200 * t
            end
        end

        local simulationDuration = 500
        local simulationTime = state.UnixTime % simulationDuration
        local progress = simulationTime / simulationDuration
        local ctx = imgui.GetWindowDrawList()
        local topLeft = imgui.GetWindowPos()
        local dim = imgui.GetWindowSize()

        local colTbl = { { 1, 2 }, { 3 }, { 4 }, { 3 } }

        for i = 1, 4 do
            for _, col in ipairs(colTbl[i]) do
                local height = distanceFn(math.wrap(progress + 0.25, 0, 1)) + 200 - i * 50
                if (height > 150) then
                    height = height - 200
                end
                local notePos = vector.New((col - 1) * 60 + 20, height)
                local noteSize = vector.New(50, 20)

                ctx.AddRectFilledMultiColor(topLeft + notePos, topLeft + notePos + noteSize, rgbaToUint(255, 0, 0, 100),
                    rgbaToUint(255, 0, 0, 100), rgbaToUint(255, 0, 200, 255), rgbaToUint(255, 0, 200, 255))
            end
        end
        imgui.EndChild()
        imgui.Dummy(vector.New(0, 10))
        imgui.TextWrapped(
            'To implement this effect, we will need to create some SV. Head to the CREATE tab in your plugin, and locate the dropdown with the word "TYPE" next to it.')
        imgui.TextColored(importantColor,
            'Select "SPECIAL" under the "TYPE" dropdown. The tutorial will\ncontinue when you\'ve done so. In the future, all tutorials will go to\nthe next step when the instructions in RED TEXT are completed.')
        if (globalVars.placeTypeIndex == 2) then
            imgui.TextColored(importantColor,
                'Now, under the "SPECIAL" tab, make sure "STUTTER" is selected.')
            local menuVars = getMenuVars("placeSpecial")
            if (menuVars.svTypeIndex ~= 1) then goto endTutorial end
            local settingVars = getSettingVars("Stutter", "Special")
            imgui.Dummy(vector.New(0, 10))
            imgui.TextWrapped(
                "We want to edit the value of the first SV, and the second SV will be updated accordingly. Note that the default SV for a map is 1x, so we will leave average SV on 1x.")
            imgui.TextColored(importantColor,
                'Set the SV value to 4.00x by clicking on the input and inputting "4".')
            ForceHeight(490)
            if (settingVars.startSV ~= 4) then goto endTutorial end
            ForceHeight(450)
            imgui.Dummy(vector.New(0, 10))
            imgui.TextWrapped(
                'At any time, you can see what your SVs will look like in the "SV INFO" window. Looking inside, we notice one of our SVs is negative. This is because of the relatively large SV we just put in, 4. To counter this, we have two options; either let the second SV be negative, or change how long the first SV lasts. Try playing around with the "Duration" slider.')
            imgui.TextColored(importantColor,
                "Set the duration to be 20%%. Either drag the slider along,\nor hold Ctrl and click to edit the slider directly.")
            ForceHeight(620)
            if (settingVars.stutterDuration ~= 20) then goto endTutorial end
            ForceHeight(580)
            imgui.TextColored(vector4(0), "penis")
            imgui.TextWrapped(
                'If you want, you can change some of the other settings; try seeing what happens when you increase the stutter count. However, for the sake of this tutorial, you are done.')
            imgui.TextColored(importantColor,
                'Now, select a note representing a strong sound, and\nthe note after it. Either hit the "T" button, or click\nthe "Place SVs between selected notes" button.')
            ForceHeight(730)
        end
        ::endTutorial::
    end
    imgui.EndChild()

    imgui.Columns(1)
    imgui.End()

    state.SetValue("tutorialWindowName", tutorialWindowName)
end
