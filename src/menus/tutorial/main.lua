function renderTutorialMenu()
    INSTRUCTION_COLOR = vector.New(1, 0.5, 0.5, 1)
    GUIDELINE_COLOR = vector.New(0.5, 0.5, 1, 1)

    imgui.SetNextWindowSize(vector.New(600, 500), imgui_cond.Always)
    imgui.PushStyleColor(imgui_col.WindowBg, imgui.GetColorU32(imgui_col.WindowBg, 0) + 4278190080)
    imgui.PushStyleColor(imgui_col.TitleBg, imgui.GetColorU32(imgui_col.TitleBg, 0) + 4278190080)

    startNextWindowNotCollapsed("Tutorial")

    _, opened = imgui.Begin("plumoguSV Tutorial Menu", true, 26)
    local tutorialWindowName = cache.tutorialWindowName or ""

    if (not opened) then
        cache.windows.showTutorialWindow = false
    end

    local navigatorWidth = 200

    local nullFn = function()
        imgui.Text("Select a tutorial menu on the left to view it.")
    end
    local incompleteFn = function()
        imgui.TextWrapped("Sorry, this tutorial is not ready yet. Please come back when a new version comes out.")
    end

    local tree = {
        ["For Beginners"] = {
            ["Start Here"] = showStartingTutorial,
            ["Placing Basic SVs"] = {
                ["Your First Effect"] = showYourFirstEffectTutorial,
                ["Your Second Effect"] = showYourSecondEffectTutorial,
                ["Working With Shapes"] = showWorkingWithShapesTutorial,
                ["Editing/Removing SVs"] = showEditingRemovingSVTutorial,
                ["Stills and Displacement"] = showStillsAndDisplacementTutorial,
                ["Composite Effects"] = incompleteFn,
            },
            ["Adding Effects"] = {},
        },
        ["Helpful Info"] = {
            ["Plugin Efficiency Tips"] = {
                ["Hotkeys"] = showHotkeyTutorial,
            },
            ["The Math Behind SV"] = {
                ["What IS msx?"] = incompleteFn,
                ["The calculus of SV"] = incompleteFn,
                ["Why do we call them shapes?"] = incompleteFn,
                ["Analogies to Physics"] = incompleteFn,
            }
        }
    }

    imgui.Columns(2)
    imgui.SetColumnWidth(0, 200)
    imgui.SetColumnWidth(1, 400)

    imgui.BeginChild("Tutorial Navigator")

    function renderBranch(branch, branchName)
        for text, data in pairs(branch) do
            local leafName = table.concat({ branchName, ".", text })
            if (type(data) == "table") then
                if (imgui.TreeNode(text)) then
                    renderBranch(data, leafName)
                    imgui.TreePop()
                end
            else
                if (imgui.GetCursorPosX() < 10) then imgui.SetCursorPosX(10) end
                imgui.Selectable(text)
                if (imgui.IsItemClicked()) then
                    tutorialWindowName = leafName
                    cache.tutorialWindowName = tutorialWindowName
                end
            end
        end
    end

    for text, data in pairs(tree) do
        imgui.SeparatorText(text)
        renderBranch(data, text)
    end

    imgui.EndChild()
    imgui.NextColumn()

    imgui.BeginChild("Tutorial Data", vector.New(380, 500), imgui_child_flags
        .AlwaysUseWindowPadding)

    imgui.SetCursorPosY(0)

    function ForceHeight(h)
        imgui.SetCursorPosY(h)
        imgui.TextColored(vctr4(0), "penis")
    end

    if (game.keyCount ~= 4) then
        imgui.SeparatorText("This tutorial does not support this key mode.")
        imgui.Text("Please go to a 4K map to continue.")
        goto dontRenderTutorial
    end

    if (cache.tutorialWindowQueue) then
        tutorialWindowName = cache.tutorialWindowQueue
        cache.tutorialWindowQueue = nil
    end

    if (not truthy(tutorialWindowName:len())) then
        nullFn()
        goto dontRenderTutorial
    end

    table.nestedValue(tree, tutorialWindowName:split("."))()

    ::dontRenderTutorial::
    imgui.EndChild()

    imgui.Columns(1)
    imgui.End()

    imgui.PopStyleColor(2)
end
