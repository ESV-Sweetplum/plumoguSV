EDIT_SV_TOOLS = { -- tools for editing SVs
    "Add Teleport",
    "Align Timing Lines",
    "Change Groups",
    "Convert SV <-> SSF",
    "Copy & Paste",
    "Direct SV",
    "Displace Note",
    "Displace View",
    "Duplicate Holistic",
    "Dynamic Scale",
    "Fix LN Ends",
    "Flicker",
    "Layer Snaps",
    "Measure",
    "Merge",
    "Reverse Scroll",
    "Scale (Displace)",
    "Scale (Multiply)",
    "Swap Notes",
    "Vertical Shift"
}

function editSVTab()
    if (globalVars.advancedMode) then chooseCurrentScrollGroup() end
    chooseEditTool()
    AddSeparator()
    local toolName = EDIT_SV_TOOLS[globalVars.editToolIndex]
    if toolName == "Add Teleport" then addTeleportMenu() end
    if toolName == "Align Timing Lines" then alignTimingLinesMenu() end
    if toolName == "Change Groups" then changeGroupsMenu() end
    if toolName == "Convert SV <-> SSF" then convertSVSSFMenu() end
    if toolName == "Copy & Paste" then copyNPasteMenu() end
    if toolName == "Direct SV" then directSVMenu() end
    if toolName == "Displace Note" then displaceNoteMenu() end
    if toolName == "Displace View" then displaceViewMenu() end
    if toolName == "Duplicate Holistic" then duplicateHolisticMenu() end
    if toolName == "Dynamic Scale" then dynamicScaleMenu() end
    if toolName == "Fix LN Ends" then fixLNEndsMenu() end
    if toolName == "Flicker" then flickerMenu() end
    if toolName == "Layer Snaps" then layerSnapMenu() end
    if toolName == "Measure" then measureMenu() end
    if toolName == "Merge" then mergeMenu() end
    if toolName == "Reverse Scroll" then reverseScrollMenu() end
    if toolName == "Scale (Displace)" then scaleDisplaceMenu() end
    if toolName == "Scale (Multiply)" then scaleMultiplyMenu() end
    if toolName == "Swap Notes" then swapNotesMenu() end
    if toolName == "Vertical Shift" then verticalShiftMenu() end
end

function chooseEditTool()
    imgui.AlignTextToFramePadding()
    imgui.Text("  Current Tool:")
    KeepSameLine()
    globalVars.editToolIndex = Combo("##edittool", EDIT_SV_TOOLS, globalVars.editToolIndex)

    local svTool = EDIT_SV_TOOLS[globalVars.editToolIndex]
    if svTool == "Add Teleport" then ToolTip("Add a large teleport SV to move far away") end
    if svTool == "Align Timing Lines" then ToolTip("Create timing lines at notes to avoid desync") end
    if svTool == "Change Timing Group" then ToolTip("Moves SVs and SSFs to a designated timing group.") end
    if svTool == "Convert SV <-> SSF" then ToolTip("Convert multipliers between SV/SSF") end
    if svTool == "Copy & Paste" then ToolTip("Copy SVs and SSFs and paste them somewhere else") end
    if svTool == "Direct SV" then ToolTip("Directly update SVs within your selection") end
    if svTool == "Displace Note" then ToolTip("Move where notes are hit on the screen") end
    if svTool == "Displace View" then ToolTip("Temporarily displace the playfield view") end
    if svTool == "Duplicate Holistic" then ToolTip("Copy everything in a section and paste it somewhere else") end
    if svTool == "Dynamic Scale" then ToolTip("Dynamically scale SVs across notes") end
    if svTool == "Fix LN Ends" then ToolTip("Fix flipped LN ends") end
    if svTool == "Flicker" then ToolTip("Flash notes on and off the screen") end
    if svTool == "Layer Snaps" then ToolTip("Transfer snap colors into layers, to be loaded later") end
    if svTool == "Measure" then ToolTip("Get stats about SVs in a section") end
    if svTool == "Merge" then ToolTip("Combine SVs that overlap") end
    if svTool == "Reverse Scroll" then ToolTip("Reverse the scroll direction using SVs") end
    if svTool == "Scale (Multiply)" then ToolTip("Scale SV values by multiplying") end
    if svTool == "Scale (Displace)" then ToolTip("Scale SV values by adding teleport SVs") end
    if svTool == "Swap Notes" then ToolTip("Swap positions of notes using SVs") end
    if svTool == "Vertical Shift" then ToolTip("Adds a constant value to SVs in a range") end
end
