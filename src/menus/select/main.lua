SELECT_TOOLS = {
    "Alternating",
    "Bookmark",
    "By Snap",
    "By Timing Group",
    "Chord Size",
    "Note Type",
}

function selectTab()
    local changedTool = chooseSelectTool()
    AddSeparator()
    if (changedTool) then state.SetValue("global.selectTypeIndex", globalVars.selectTypeIndex) end
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
    local oldSelectTypeIndex = globalVars.selectTypeIndex
    globalVars.selectTypeIndex = Combo("##selecttool", SELECT_TOOLS, oldSelectTypeIndex, nil, nil, tooltipList)

    HoverToolTip(tooltipList[globalVars.selectTypeIndex])
    return oldSelectTypeIndex ~= globalVars.selectTypeIndex
end
