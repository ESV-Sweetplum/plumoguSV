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
    imgui.AlignTextToFramePadding()
    imgui.Text("Current Type:")
    KeepSameLine()
    globalVars.selectTypeIndex = Combo("##selecttool", SELECT_TOOLS, globalVars.selectTypeIndex)

    local selectTool = SELECT_TOOLS[globalVars.selectTypeIndex]
    if selectTool == "Alternating" then ToolTip("Skip over notes then select one, and repeat") end
    if selectTool == "By Snap" then ToolTip("Select all notes with a certain snap color") end
    if selectTool == "Bookmark" then ToolTip("Jump to a bookmark") end
    if selectTool == "Chord Size" then ToolTip("Select all notes with a certain chord size") end
    if selectTool == "Note Type" then ToolTip("Select rice/ln notes") end
end
