function renderTutorialMenu()
    imgui.SetNextWindowSize(vector.New(600, 500), imgui_cond.Always)
    _, opened = imgui.Begin("plumoguSV Tutorial Menu", true, 26)

    local tutorialWindowName = state.GetValue("tutorialWindowName", "")

    if (not opened) then
        state.SetValue("showTutorialWindow", false)
    end

    local navigatorWidth = 200

    local nullFn = function() end
    local tutorialFn = state.GetValue("tutorialFn", nullFn)

    local tree = {
        ["For Beginners"] = {
            ["Placing SVs"] = {
                ["Your First Effect"] = showYourFirstEffectTutorial,
                ["Your Second Effect"] = showYourSecondEffectTutorial,
                ["Working With Shapes"] = showWorkingWithShapesTutorial,
                ["Editing/Removing SVs"] = nullFn,
                ["Composite Effects"] = nullFn,
                ["Stills and Displacement"] = nullFn,
            },
            ["Adding Effects"] = {},
            ["Vibrato"] = {},
            ["Deconstructing Effects"] = {
                ["Preface"] = nullFn,
                ["PK Rave"] = nullFn
            }
        },
        ["Helpful Info"] = {
            ["The Math Behind SV"] = {
                ["Preface"] = nullFn,
                ["What IS msx?"] = nullFn,
                ["The calculus of SV"] = nullFn,
                ["Why do we call them shapes?"] = nullFn,
            }
        }
    }

    imgui.Columns(2)
    imgui.SetColumnWidth(0, 200)
    imgui.SetColumnWidth(1, 400)

    imgui.BeginChild("Tutorial Navigator")

    function renderBranch(branch)
        for text, data in pairs(branch) do
            if (type(data) == "table") then
                if (imgui.TreeNode(text)) then
                    renderBranch(data)
                    imgui.TreePop()
                end
            else
                imgui.Selectable(text)
                if (imgui.IsItemClicked()) then
                    tutorialWindowName = text
                    tutorialFn = data
                end
            end
        end
    end

    for text, data in pairs(tree) do
        imgui.SeparatorText(text)
        renderBranch(data)
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

    tutorialFn()

    ::dontRenderTutorial::
    imgui.EndChild()

    imgui.Columns(1)
    imgui.End()

    state.SetValue("tutorialWindowName", tutorialWindowName)
    state.SetValue("tutorialFn", tutorialFn)
end
