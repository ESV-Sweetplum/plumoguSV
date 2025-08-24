SELECT_TOOLS = {
    "Alternating",
    "Bookmark",
    "By Snap",
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
    if toolName == "Chord Size" then selectChordSizeMenu() end
    if toolName == "Note Type" then selectNoteTypeMenu() end
end

function chooseSelectTool()
    local tooltipList = {
        "Skip over notes then select one, and repeat.",
        "Select all notes with a certain snap color.",
        "Jump to a bookmark.",
        "Select all notes with a certain chord size.",
        "Select rice/ln notes."
    }
    imgui.AlignTextToFramePadding()
    imgui.Text("Current Type:")
    KeepSameLine()
    globalVars.selectTypeIndex = Combo("##selecttool", SELECT_TOOLS, globalVars.selectTypeIndex, {}, {}, tooltipList)

    ToolTip(tooltipList[globalVars.selectTypeIndex])

    local selectTool = SELECT_TOOLS[globalVars.selectTypeIndex]
end
