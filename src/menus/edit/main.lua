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
    local tooltipList = {
        "Add a large teleport SV to move far away.",
        "Create timing lines at notes to avoid desync.",
        "Moves SVs and SSFs to a designated timing group.",
        "Convert multipliers between SV/SSF.",
        "Copy SVs and SSFs and paste them somewhere else.",
        "Directly update SVs within your selection.",
        "Move where notes are hit on the screen.",
        "Temporarily displace the playfield view.",
        "Copy everything in a section and paste it somewhere else.",
        "Dynamically scale SVs across notes.",
        "Fix flipped LN ends.",
        "Flash notes on and off the screen.",
        "Transfer snap colors into layers, to be loaded later.",
        "Get stats about SVs in a section.",
        "Combine SVs that overlap.",
        "Reverse the scroll direction using SVs.",
        "Scale SV values by multiplying.",
        "Scale SV values by adding teleport SVs.",
        "Swap positions of notes using SVs.",
        "Adds a constant value to SVs in a range.",
    }

    imgui.AlignTextToFramePadding()
    imgui.Text("  Current Tool:")
    KeepSameLine()
    globalVars.editToolIndex = Combo("##edittool", EDIT_SV_TOOLS, globalVars.editToolIndex, {}, {}, tooltipList)

    ToolTip(tooltipList[globalVars.editToolIndex])

    local svTool = EDIT_SV_TOOLS[globalVars.editToolIndex]
end
