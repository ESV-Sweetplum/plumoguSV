function changeNoteLockMode()
    local mode = cache.noteLockMode or 0

    mode = (mode + 1) % 4
    if (mode == 0) then
        print("s", "Notes have been unlocked.")
    end
    if (mode == 1) then
        print("e",
            "Notes have been fully locked. To change the lock mode, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. ".")
    end
    if (mode == 2) then
        print("w",
            "Notes can no longer be placed, only moved. To change the lock mode, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. ".")
    end
    if (mode == 3) then
        print("w",
            "Notes can no longer be moved, only placed and deleted. To change the lock mode, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. ".")
    end

    cache.noteLockMode = mode
end

function initializeNoteLockMode()
    cache.noteLockMode = 0

    listen(function(action, type, fromLua)
        if (fromLua) then return end
        local actionIndex = tonumber(action.Type) ---@cast actionIndex EditorActionType
        local mode = cache.noteLockMode or 0
        if (mode == 1) then -- No note modification at all
            if (actionIndex > 9) then return end
            actions.Undo()
        end
        if (mode == 2) then -- Only place and delete notes
            local allowedIndices = { 0, 1, 3, 4, 8, 9 }
            if (not table.contains(allowedIndices, actionIndex)) then return end
            actions.Undo()
        end
        if (mode == 3) then -- Only move notes
            local allowedIndices = { 2, 5, 6, 7 }
            if (not table.contains(allowedIndices, actionIndex)) then return end
            actions.Undo()
        end
    end)
end
