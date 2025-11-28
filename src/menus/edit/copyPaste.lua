function copyNPasteMenu()
    local menuVars = getMenuVars("copyPaste")

    local copiedItemCount = copyNPasteSettingsMenu(menuVars, true)

    cache.saveTable("copyPasteMenu", menuVars)

    if (copiedItemCount == 0) then return end

    simpleActionMenu("Paste items at selected notes", 1, pasteItems, menuVars)
end

function copyNPasteSettingsMenu(menuVars, actionable)
    _, menuVars.copyLines = imgui.Checkbox("Copy Lines", menuVars.copyLines)
    KeepSameLine()
    _, menuVars.copySVs = imgui.Checkbox("Copy SVs", menuVars.copySVs)
    _, menuVars.copySSFs = imgui.Checkbox("Copy SSFs", menuVars.copySSFs)
    imgui.SameLine(0, SAMELINE_SPACING + 3.5)
    _, menuVars.copyBMs = imgui.Checkbox("Copy Bookmarks", menuVars.copyBMs)
    AddSeparator()
    if actionable then BasicInputInt(menuVars, "curSlot", "Current slot", { 1, 999 }) end
    if (actionable and #menuVars.copied.lines < menuVars.curSlot) then
        local newCopied = table.duplicate(menuVars.copied)
        while #newCopied.lines < menuVars.curSlot do
            table.insert(newCopied.lines, {})
            table.insert(newCopied.SVs, {})
            table.insert(newCopied.SSFs, {})
            table.insert(newCopied.BMs, {})
        end
        menuVars.copied = newCopied
    end
    if (actionable) then AddSeparator() end

    local copiedItemCount = #menuVars.copied.lines[menuVars.curSlot] + #menuVars.copied.SVs[menuVars.curSlot] +
        #menuVars.copied.SSFs[menuVars.curSlot] + #menuVars.copied.BMs[menuVars.curSlot]

    if (actionable) then
        if (copiedItemCount == 0) then
            simpleActionMenu("Copy items between selected notes", 2, copyItems, menuVars)
        else
            FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearCopiedItems, menuVars)
        end
    end

    if (copiedItemCount == 0 and actionable) then return copiedItemCount end

    if (actionable) then AddSeparator() end

    _, menuVars.tryAlign = imgui.Checkbox("Try to fix misalignments", menuVars.tryAlign)
    imgui.PushItemWidth(100)
    _, menuVars.alignWindow = imgui.SliderInt("Alignment window (ms)", menuVars.alignWindow, 1, 10)
    imgui.PopItemWidth()

    return copiedItemCount
end
