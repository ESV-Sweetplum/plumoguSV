function toggleUseEndOffsets()
    globalVars.useEndTimeOffsets = not globalVars.useEndTimeOffsets
    if (globalVars.useEndTimeOffsets) then
        print("s",
            "LN ends are now considered as their own offsets. To change this, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_end_offset] .. ".")
    else
        print("e",
            "LN ends are now no longer considered as their own offsets. To change this, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_end_offset] .. ".")
    end
    write(globalVars)
end
