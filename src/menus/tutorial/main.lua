function renderTutorialMenu()
    imgui.SetNextWindowSize(vector.New(600, 500), imgui_cond.Always)
    _, opened = imgui.Begin("plumoguSV Tutorial Menu", true, 26)

    local tutorialWindowName = state.GetValue("tutorialWindowName", "")

    if (not opened) then
        state.SetValue("showTutorialWindow", false)
    end

    local navigatorWidth = 200

    imgui.Columns(2)
    imgui.SetColumnWidth(0, 200)
    imgui.SetColumnWidth(1, 400)

    imgui.BeginChild("Tutorial Navigator")

    imgui.SeparatorText("For Beginners")

    if (imgui.TreeNode("Placing SVs")) then
        local tabs = { "Your First Effect", "Your Second Effect", "Working With Shapes", "Editing/Removing SVs",
            "Composite Effects",
            "Stills and Displacement" }
        for _, t in pairs(tabs) do
            imgui.Selectable(t)
            if (imgui.IsItemClicked()) then
                tutorialWindowName = t
            end
        end
        imgui.TreePop()
    end
    if (imgui.TreeNode("Adding Effects")) then
        imgui.TreePop()
    end
    if (imgui.TreeNode("Vibrato")) then
        imgui.TreePop()
    end
    if (imgui.TreeNode("Deconstructing Effects")) then
        local tabs = { "Preface", "PK Rave" }
        imgui.TreePop()
    end

    imgui.SeparatorText("Helpful Info")
    if (imgui.TreeNode("The Math Behind SV")) then
        local tabs = { "Preface", "What IS msx?", "The calculus of SV", "Why do we call them shapes?" }
    end

    imgui.EndChild()
    imgui.NextColumn()

    imgui.BeginChild("Tutorial Data", vector.New(380, 500), imgui_child_flags
        .AlwaysUseWindowPadding)

    function ForceHeight(h)
        imgui.SetCursorPosY(h)
        imgui.TextColored(vector4(0), "penis")
    end

    if (map.GetKeyCount(false) ~= 4) then
        imgui.SeparatorText("This tutorial does not support this key mode.")
        imgui.Text("Please go to a 4K map to continue.")
        goto dontRenderTutorial
    end

    if (state.GetValue("tutorialWindowQueue", nil)) then
        tutorialWindowName = state.GetValue("tutorialWindowQueue")
        state.SetValue("tutorialWindowQueue", nil)
    end

    if (not truthy(tutorialWindowName:len())) then
        imgui.SeparatorText("Select a tutorial menu on the left to view it.")
    end

    windowMap = {
        ["Your First Effect"] = showYourFirstEffectTutorial,
        ["Your Second Effect"] = showYourSecondEffectTutorial,
        ["Working With Shapes"] = showWorkingWithShapesTutorial
    }

    (windowMap[tutorialWindowName] or function() end)() -- Render Window

    ::dontRenderTutorial::
    imgui.EndChild()

    imgui.Columns(1)
    imgui.End()

    state.SetValue("tutorialWindowName", tutorialWindowName)
end
