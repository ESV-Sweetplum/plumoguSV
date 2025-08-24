CREATE_TYPES = { -- general categories of SVs to place
    "Standard",
    "Special",
    "Still",
    "Vibrato",
}

function createSVTab()
    if (globalVars.advancedMode) then chooseCurrentScrollGroup() end
    chooseCreateTool()
    local placeType = CREATE_TYPES[globalVars.placeTypeIndex]
    if placeType == "Standard" then placeStandardSVMenu() end
    if placeType == "Special" then placeSpecialSVMenu() end
    if placeType == "Still" then placeStillSVMenu() end
    if placeType == "Vibrato" then placeVibratoSVMenu(false) end
end

function chooseCreateTool()
    imgui.AlignTextToFramePadding()
    imgui.Text("  Type:  ")
    KeepSameLine()
    globalVars.placeTypeIndex = Combo("##placeType", CREATE_TYPES, globalVars.placeTypeIndex)
    local placeType = CREATE_TYPES[globalVars.placeTypeIndex]
    if placeType == "Still" then ToolTip("Still keeps notes normal distance/spacing apart") end
end
