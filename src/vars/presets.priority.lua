function setPresets(presetList)
    globalVars.presets = {}
    for _, preset in pairs(presetList) do
        local presetIsvalid, presetData = checkPresetValidity(preset)
        if (not presetIsvalid) then goto nextPreset end
        table.insert(globalVars.presets,
            { name = preset.name, type = preset.type, menu = preset.menu, data = presetData })
        ::nextPreset::
    end
end

function checkPresetValidity(preset)
    if (not table.contains(CREATE_TYPES, preset.type)) then return false, nil end
    local validMenus = {}
    if (preset.type == "Standard" or preset.type == "Still") then
        validMenus = table.duplicate(STANDARD_SVS)
    end
    if (preset.type == "Special") then
        validMenus = table.duplicate(SPECIAL_SVS)
    end
    if (preset.type == "Vibrato") then
        validMenus = table.duplicate(VIBRATO_SVS)
    end
    if (not isTruthy(validMenus)) then return false, nil end
    if (not table.includes(validMenus, preset.menu)) then return false, nil end

    local realType = "place" .. preset.type

    return true, preset.data
end
