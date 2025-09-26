function toggleUseEndOffsets()
    globalVars.useEndTimeOffsets = not globalVars.useEndTimeOffsets
    if (globalVars.useEndTimeOffsets) then
        print("s",
            "LN ends are now considered as their own offsets. To change this, press " .. globalVars.hotkeyList[11] .. ".")
    else
        print("e",
            "LN ends are now no longer considered as their own offsets. To change this, press " ..
            globalVars.hotkeyList[11] .. ".")
    end
    write(globalVars)
end
