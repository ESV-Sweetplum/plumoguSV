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
        local tabs = { "Your First Effect", "Your Second Effect", "Working With Shapes", "Composite Effects",
            "Stills and Displacement" }
        for _, t in pairs(tabs) do
            imgui.Selectable(t)
            if (imgui.IsItemClicked()) then
                tutorialWindowName = t
            end
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
    if (imgui.TreeNode("Recreating Popular Effects")) then
        imgui.TreePop()
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
    if (not truthy(tutorialWindowName:len())) then
        imgui.SeparatorText("Select a tutorial menu on the left to view it.")
    end
    if (tutorialWindowName == "Your First Effect") then
        showYourFirstEffectTutorial()
    end
    if (tutorialWindowName == "Your Second Effect") then
        showYourSecondEffectTutorial()
    end
    if (tutorialWindowName == "Working With Shapes") then
        showWorkingWithShapesTutorial()
    end
    ::dontRenderTutorial::
    imgui.EndChild()

    imgui.Columns(1)
    imgui.End()

    state.SetValue("tutorialWindowName", tutorialWindowName)
end
