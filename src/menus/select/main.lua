SELECT_TOOLS = {
    "Alternating",
    "By Snap",
    "Chord Size",
    "Note Type",
    "Bookmark",
}

function selectTab()
    chooseSelectTool()
    AddSeparator()
    local toolName = SELECT_TOOLS[globalVars.selectTypeIndex]
    if toolName == "Alternating" then selectAlternatingMenu() end
    if toolName == "By Snap" then selectBySnapMenu() end
    if toolName == "Bookmark" then selectBookmarkMenu() end
    if toolName == "Chord Size" then selectChordSizeMenu() end
    if toolName == "Note Type" then selectNoteTypeMenu() end
end
