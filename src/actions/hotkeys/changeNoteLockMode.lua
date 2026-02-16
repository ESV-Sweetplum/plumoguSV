function changeNoteLockMode()
    local mode = cache.noteLockMode or 0

    mode = (mode + 1) % 4
    if mode == 0 then
        print('s', 'Notes have been unlocked.')
    end
    if mode == 1 then
        print('e',
            'Notes have been fully locked. To change the lock mode, press ' ..
            globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. '.')
    end
    if mode == 2 then
        print('w',
            'Notes can no longer be placed, only moved. To change the lock mode, press ' ..
            globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. '.')
    end
    if mode == 3 then
        print('w',
            'Notes can no longer be moved, only placed and deleted. To change the lock mode, press ' ..
            globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. '.')
    end

    cache.noteLockMode = mode
end

function initializeNoteLockMode()
    cache.noteLockMode = 0

    listen(function(action, type, fromLua)
        if fromLua then return end
        local actionIndex = tonumber(action.Type) ---@cast actionIndex EditorActionType
        local mode = cache.noteLockMode or 0
        if mode == 1 then -- No note modification at all
            if actionIndex >= action_type.CreateLayer then return end
            actions.Undo()
        end
        if mode == 2 then -- Only place and delete notes
            local allowedActions = {
                action_type.PlaceHitObject,
                action_type.RemoveHitObject,
                action_type.PlaceHitObjectBatch,
                action_type.RemoveHitObjectBatch,
                action_type.AddHitsound,
                action_type.RemoveHitsound,
            }
            if (not table.contains(allowedActions, actionIndex)) then return end
            actions.Undo()
        end
        if mode == 3 then -- Only move notes
            local allowedActions = {
                action_type.ResizeLongNote,
                action_type.FlipHitObjects,
                action_type.SwapLanes,
                action_type.MoveHitObjects,
            }
            if (not table.contains(allowedActions, actionIndex)) then return end
            actions.Undo()
        end
    end)
end
