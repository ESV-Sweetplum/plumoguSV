CREATE_TYPES = { -- general categories of SVs to place
    "Standard",
    "Special",
    "Still",
    "Vibrato",
}

function createSVTab()
    if (globalVars.advancedMode) then chooseCurrentScrollGroup() end
    local changedTool = chooseCreateTool()
    local placeType = CREATE_TYPES[globalVars.placeTypeIndex]

    if changedTool then state.SetValue("global.placeTypeIndex", globalVars.placeTypeIndex) end

    if placeType == "Standard" then placeStandardSVMenu() end
    if placeType == "Special" then placeSpecialSVMenu() end
    if placeType == "Still" then placeStillSVMenu() end
    if placeType == "Vibrato" then placeVibratoSVMenu(false) end
end

function chooseCreateTool()
    local tooltipList = {
        "Place standard shapes.",
        "Non-standard effects.",
        "Still shapes keep notes normal distance/spacing apart.",
        "Make notes vibrate or appear to duplicate."
    }

    imgui.AlignTextToFramePadding()
    imgui.Text(("  Type:  "):obfuscate())
    KeepSameLine()
    local oldPlaceTypeIndex = globalVars.placeTypeIndex
    globalVars.placeTypeIndex = Combo("##placeType", CREATE_TYPES, oldPlaceTypeIndex, nil, nil, tooltipList)

    HoverToolTip(tooltipList[globalVars.placeTypeIndex])

    return oldPlaceTypeIndex ~= globalVars.placeTypeIndex
end
