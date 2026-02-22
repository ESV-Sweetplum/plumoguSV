function deleteTab()
    if (globalVars.advancedMode) then chooseCurrentScrollGroup() end

    local menuVars = getMenuVars('delete')
    if (globalVars.simultaneousDeleteModes) then
        _, menuVars.deleteTable[1] = imgui.Checkbox('Delete Lines', menuVars.deleteTable[1])
        KeepSameLine()
        _, menuVars.deleteTable[2] = imgui.Checkbox('Delete SVs', menuVars.deleteTable[2])
        _, menuVars.deleteTable[3] = imgui.Checkbox('Delete SSFs', menuVars.deleteTable[3])
        imgui.SameLine(0, SAMELINE_SPACING + 3.5)
        _, menuVars.deleteTable[4] = imgui.Checkbox('Delete Bookmarks', menuVars.deleteTable[4])

        cache.saveTable('deleteMenu', menuVars)

        for i = 1, 4 do
            if (menuVars.deleteTable[i]) then
                simpleActionMenu('Delete items between selected notes', 2, deleteItems, menuVars)
                return
            end
        end
    else
        local enoughSelectedNotes = checkEnoughSelectedNotes(2)
        if (not enoughSelectedNotes) then
            imgui.Text('Select 2 or more notes to specify deletion.')
            return
        end
        if (imgui.Button('Delete Lines', HALF_ACTION_BUTTON_SIZE)) then
            deleteItems({ deleteTable = { true, false, false, false } })
        end
        KeepSameLine()
        if (imgui.Button('Delete SVs', HALF_ACTION_BUTTON_SIZE)) then
            deleteItems({ deleteTable = { false, true, false, false } })
        end
        if (imgui.Button('Delete SSFs', HALF_ACTION_BUTTON_SIZE)) then
            deleteItems({ deleteTable = { false, false, true, false } })
        end
        KeepSameLine()
        if (imgui.Button('Delete Bookmarks', HALF_ACTION_BUTTON_SIZE)) then
            deleteItems({ deleteTable = { false, false, false, true } })
        end
    end
end
