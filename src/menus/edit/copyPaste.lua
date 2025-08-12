function copyNPasteMenu()
    local menuVars = getMenuVars("copy")

    _, menuVars.copyTable[1] = imgui.Checkbox("Copy Lines", menuVars.copyTable[1])
    KeepSameLine()
    _, menuVars.copyTable[2] = imgui.Checkbox("Copy SVs", menuVars.copyTable[2])
    _, menuVars.copyTable[3] = imgui.Checkbox("Copy SSFs", menuVars.copyTable[3])
    imgui.SameLine(0, SAMELINE_SPACING + 3.5)
    _, menuVars.copyTable[4] = imgui.Checkbox("Copy Bookmarks", menuVars.copyTable[4])

    AddSeparator()
    local _ = BasicInputInt(menuVars, "curSlot", "Current slot", { 1, 999 })
    if #menuVars.copied.lines < menuVars.curSlot then
        local newCopied = table.duplicate(menuVars.copied)
        while #newCopied.lines < menuVars.curSlot do
            table.insert(newCopied.lines, {})
            table.insert(newCopied.SVs, {})
            table.insert(newCopied.SSFs, {})
            table.insert(newCopied.BMs, {})
        end
        menuVars.copied = newCopied
    end
    AddSeparator()

    local copiedItemCount = #menuVars.copied.lines[menuVars.curSlot] + #menuVars.copied.SVs[menuVars.curSlot] +
        #menuVars.copied.SSFs[menuVars.curSlot] + #menuVars.copied.BMs[menuVars.curSlot]

    if (copiedItemCount == 0) then
        simpleActionMenu("Copy items between selected notes", 2, copyItems, menuVars)
    else
        FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearCopiedItems, menuVars)
    end

    if copiedItemCount == 0 then
        cache.saveTable("copyMenu", menuVars)
        return
    end

    AddSeparator()

    _, menuVars.tryAlign = imgui.Checkbox("Try to fix misalignments", menuVars.tryAlign)
    cache.saveTable("copyMenu", menuVars)

    simpleActionMenu("Paste items at selected notes", 1, pasteItems, menuVars)
end
