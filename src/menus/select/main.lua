SELECT_TOOLS = {
    "Alternating",
    "Bookmark",
    "By Snap",
    "By Timing Group",
    "Chord Size",
    "Note Type",
}

function selectTab()
    chooseSelectTool()
    AddSeparator()
    local toolName = SELECT_TOOLS[globalVars.selectTypeIndex]
    if toolName == "Alternating" then selectAlternatingMenu() end
    if toolName == "Bookmark" then selectBookmarkMenu() end
    if toolName == "By Snap" then selectBySnapMenu() end
    if toolName == "By Timing Group" then selectByTimingGroupMenu() end
    if toolName == "Chord Size" then selectChordSizeMenu() end
    if toolName == "Note Type" then selectNoteTypeMenu() end
end

function chooseSelectTool()
    local tooltipList = {
        "Skip over notes then select one, and repeat.",
        "Jump to a bookmark.",
        "Select all notes with a certain snap color.",
        "Select all notes within a certain timing group.",
        "Select all notes with a certain chord size.",
        "Select rice/ln notes."
    }
    imgui.AlignTextToFramePadding()
    imgui.Text("Current Type:")
    KeepSameLine()
    globalVars.selectTypeIndex = Combo("##selecttool", SELECT_TOOLS, globalVars.selectTypeIndex, nil, nil, tooltipList)

    HoverToolTip(tooltipList[globalVars.selectTypeIndex])

    local selectTool = SELECT_TOOLS[globalVars.selectTypeIndex]
end
