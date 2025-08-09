function renderTutorialMenu()
    imgui.SetNextWindowSize(vector.New(600, 500), imgui_cond.Always)
    _, opened = imgui.Begin("plumoguSV Tutorial Menu", true, imgui_window_flags.NoResize)

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

    imgui.BeginChild("Tutorial Data")
    imgui.EndChild()

    imgui.Columns(1)

    imgui.End()
end
