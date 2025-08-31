function saveSettingPropertiesButton(settingVars, label)
    local saveButtonClicked = imgui.Button("Save##setting" .. label)
    imgui.Separator()
    if (not saveButtonClicked) then return end
    label = label:charAt(1):lower() .. label:sub(2)
    if (not globalVars.defaultProperties) then globalVars.defaultProperties = {} end
    if (not globalVars.defaultProperties.settings) then globalVars.defaultProperties.settings = {} end
    globalVars.defaultProperties.settings[label] = settingVars
    loadDefaultProperties(globalVars.defaultProperties)
    write(globalVars)

    print("i!",
        'Default setting properties for submenu "' ..
        label .. '" have been set. Changes will be shown on the next plugin refresh.')
end

function saveMenuPropertiesButton(menuVars, label)
    local saveButtonClicked = imgui.Button("Save##menu" .. label)
    imgui.Separator()
    if (not saveButtonClicked) then return end
    label = label:charAt(1):lower() .. label:sub(2)
    if (not globalVars.defaultProperties) then globalVars.defaultProperties = {} end
    if (not globalVars.defaultProperties.menu) then globalVars.defaultProperties.menu = {} end
    globalVars.defaultProperties.menu[label] = menuVars
    loadDefaultProperties(globalVars.defaultProperties)
    write(globalVars)

    print("i!",
        'Default menu properties for menu "' ..
        label .. '" have been set. Changes will be shown on the next plugin refresh.')
end

function showDefaultPropertiesSettings()
    imgui.SeparatorText("Create Tab Settings")

    if (imgui.CollapsingHeader("General Standard Settings")) then
        local menuVars = getMenuVars("placeStandard", "Property")

        chooseStandardSVType(menuVars, false)
        AddSeparator()
        chooseInterlace(menuVars)

        saveMenuPropertiesButton(menuVars, "placeStandard")
        cache.saveTable("placeStandardPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("General Special Settings")) then
        local menuVars = getMenuVars("placeSpecial", "Property")

        chooseSpecialSVType(menuVars)

        saveMenuPropertiesButton(menuVars, "placeSpecial")
        cache.saveTable("placeSpecialPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("General Still Settings")) then
        local menuVars = getMenuVars("placeStill", "Property")

        chooseStandardSVType(menuVars, false)
        AddSeparator()
        menuVars.noteSpacing = ComputableInputFloat("Note Spacing", menuVars.noteSpacing, 2, "x")
        menuVars.stillBehavior = Combo("Still Behavior", STILL_BEHAVIOR_TYPES, menuVars.stillBehavior)
        chooseStillType(menuVars)
        chooseInterlace(menuVars)

        saveMenuPropertiesButton(menuVars, "placeStill")
        cache.saveTable("placeStillPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("General Vibrato Settings")) then
        local menuVars = getMenuVars("placeVibrato", "Property")

        chooseVibratoSVType(menuVars)
        AddSeparator()
        imgui.Text("Vibrato Settings:")
        menuVars.vibratoMode = Combo("Vibrato Mode", VIBRATO_TYPES, menuVars.vibratoMode)
        chooseVibratoQuality(menuVars)
        if (menuVars.vibratoMode ~= 2) then
            chooseVibratoSides(menuVars)
        end

        saveMenuPropertiesButton(menuVars, "placeVibrato")
        cache.saveTable("placeVibratoPropertyMenu", menuVars)
    end

    imgui.SeparatorText("Edit Tab Settings")

    if (imgui.CollapsingHeader("Add Teleport Settings")) then
        local menuVars = getMenuVars("addTeleport", "Property")

        chooseDistance(menuVars)
        BasicCheckbox(menuVars, "teleportBeforeHand", "Add teleport before note")

        saveMenuPropertiesButton(menuVars, "addTeleport")
        cache.saveTable("addTeleportPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Change Group Settings")) then
        local menuVars = getMenuVars("changeGroups", "Property")

        _, menuVars.changeSVs = imgui.Checkbox("Change SVs?", menuVars.changeSVs)
        KeepSameLine()
        _, menuVars.changeSSFs = imgui.Checkbox("Change SSFs?", menuVars.changeSSFs)

        menuVars.clone = RadioButtons("Mode: ", menuVars.clone, { "Clone", "Move" }, { true, false })

        saveMenuPropertiesButton(menuVars, "changeGroups")
        cache.saveTable("changeGroupsPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Convert SV <-> SSF Settings")) then
        local menuVars = getMenuVars("convertSVSSF", "Property")

        chooseConvertSVSSFDirection(menuVars)

        saveMenuPropertiesButton(menuVars, "convertSVSSF")
        cache.saveTable("convertSVSSFPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Copy Settings")) then
        local menuVars = getMenuVars("copy", "Property")

        _, menuVars.copyTable[1] = imgui.Checkbox("Copy Lines", menuVars.copyTable[1])
        KeepSameLine()
        _, menuVars.copyTable[2] = imgui.Checkbox("Copy SVs", menuVars.copyTable[2])
        _, menuVars.copyTable[3] = imgui.Checkbox("Copy SSFs", menuVars.copyTable[3])
        imgui.SameLine(0, SAMELINE_SPACING + 3.5)
        _, menuVars.copyTable[4] = imgui.Checkbox("Copy Bookmarks", menuVars.copyTable[4])

        _, menuVars.tryAlign = imgui.Checkbox("Try to fix misalignments", menuVars.tryAlign)
        imgui.PushItemWidth(100)
        _, menuVars.alignWindow = imgui.SliderInt("Alignment window (ms)", menuVars.alignWindow, 1, 10)
        imgui.PopItemWidth()

        saveMenuPropertiesButton(menuVars, "copy")
        cache.saveTable("copyPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Displace Note Settings")) then
        local menuVars = getMenuVars("displaceNote", "Property")

        chooseVaryingDistance(menuVars)
        BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")

        saveMenuPropertiesButton(menuVars, "displaceNote")
        cache.saveTable("displaceNotePropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Displace View Settings")) then
        local menuVars = getMenuVars("displaceView", "Property")

        chooseDistance(menuVars)

        saveMenuPropertiesButton(menuVars, "displaceView")
        cache.saveTable("displaceViewPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Flicker Settings")) then
        local menuVars = getMenuVars("flicker", "Property")

        menuVars.flickerTypeIndex = Combo("Flicker Type", FLICKER_TYPES, menuVars.flickerTypeIndex)
        chooseVaryingDistance(menuVars)
        BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")
        BasicInputInt(menuVars, "numFlickers", "Flickers", { 1, 9999 })
        if (globalVars.advancedMode) then chooseFlickerPosition(menuVars) end

        saveMenuPropertiesButton(menuVars, "flicker")
        cache.saveTable("flickerPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Reverse Scroll Settings")) then
        local menuVars = getMenuVars("reverseScroll", "Property")

        chooseDistance(menuVars)
        HelpMarker("Height at which reverse scroll notes are hit")

        saveMenuPropertiesButton(menuVars, "reverseScroll")
        cache.saveTable("reverseScrollPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Scale (Displace) Settings")) then
        local menuVars = getMenuVars("scaleDisplace", "Property")

        menuVars.scaleSpotIndex = Combo("Displace Spot", DISPLACE_SCALE_SPOTS, menuVars.scaleSpotIndex)
        chooseScaleType(menuVars)

        saveMenuPropertiesButton(menuVars, "scaleDisplace")
        cache.saveTable("scaleDisplacePropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Scale (Multiply) Settings")) then
        local menuVars = getMenuVars("scaleMultiply", "Property")

        chooseScaleType(menuVars)

        saveMenuPropertiesButton(menuVars, "scaleMultiply")
        cache.saveTable("scaleMultiplyPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Vertical Shift Settings")) then
        local menuVars = getMenuVars("verticalShift", "Property")

        chooseConstantShift(menuVars, 0)

        saveMenuPropertiesButton(menuVars, "verticalShift")
        cache.saveTable("verticalShiftPropertyMenu", menuVars)
    end

    imgui.SeparatorText("Delete Tab Settings")

    if (imgui.CollapsingHeader("Delete Menu Settings")) then
        local menuVars = getMenuVars("delete", "Property")

        _, menuVars.deleteTable[1] = imgui.Checkbox("Delete Lines", menuVars.deleteTable[1])
        KeepSameLine()
        _, menuVars.deleteTable[2] = imgui.Checkbox("Delete SVs", menuVars.deleteTable[2])
        _, menuVars.deleteTable[3] = imgui.Checkbox("Delete SSFs", menuVars.deleteTable[3])
        imgui.SameLine(0, SAMELINE_SPACING + 3.5)
        _, menuVars.deleteTable[4] = imgui.Checkbox("Delete Bookmarks", menuVars.deleteTable[4])

        saveMenuPropertiesButton(menuVars, "delete")
        cache.saveTable("deletePropertyMenu", menuVars)
    end

    imgui.SeparatorText("Select Tab Settings")

    if (imgui.CollapsingHeader("Select Alternating Settings")) then
        local menuVars = getMenuVars("selectAlternating", "Property")

        BasicInputInt(menuVars, "every", "Every __ notes", { 1, MAX_SV_POINTS })
        BasicInputInt(menuVars, "offset", "From note #__", { 1, menuVars.every })

        saveMenuPropertiesButton(menuVars, "selectAlternating")
        cache.saveTable("selectAlternatingPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Select By Snap Settings")) then
        local menuVars = getMenuVars("selectBySnap", "Property")

        BasicInputInt(menuVars, "snap", "Snap", { 1, 100 })

        saveMenuPropertiesButton(menuVars, "selectBySnap")
        cache.saveTable("selectBySnapPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Select Chord Size Settings")) then
        local menuVars = getMenuVars("selectChordSize", "Property")

        for idx = 1, game.keyCount do
            local varLabel = "select" .. idx
            local label = table.concat({ "Size " .. idx .. " Chord" })
            _, menuVars[varLabel] = imgui.Checkbox(label, menuVars[varLabel])
            if (idx % 2 == 1) then KeepSameLine() end
        end

        saveMenuPropertiesButton(menuVars, "selectChordSize")
        cache.saveTable("selectChordSizePropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Select Note Type Settings")) then
        local menuVars = getMenuVars("selectNoteType", "Property")

        _, menuVars.rice = imgui.Checkbox("Select Rice Notes", menuVars.rice)
        KeepSameLine()
        _, menuVars.ln = imgui.Checkbox("Select LNs", menuVars.ln)

        saveMenuPropertiesButton(menuVars, "selectNoteType")
        cache.saveTable("selectNoteTypePropertyMenu", menuVars)
    end

    imgui.SeparatorText("Standard/Still Settings")

    if (imgui.CollapsingHeader("Linear Settings")) then
        local settingVars = getSettingVars("Linear", "Property")

        linearSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Linear")
        cache.saveTable("LinearPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Exponential Settings")) then
        local settingVars = getSettingVars("Exponential", "Property")

        exponentialSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Exponential")
        cache.saveTable("ExponentialPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Bezier Settings")) then
        local settingVars = getSettingVars("Bezier", "Property")

        bezierSettingsMenu(settingVars, false, false, "Property")

        saveSettingPropertiesButton(settingVars, "Bezier")
        cache.saveTable("BezierPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Hermite Settings")) then
        local settingVars = getSettingVars("Hermite", "Property")

        hermiteSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Hermite")
        cache.saveTable("HermitePropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sinusoidal Settings")) then
        local settingVars = getSettingVars("Sinusoidal", "Property")

        sinusoidalSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Sinusoidal")
        cache.saveTable("SinusoidalPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Circular Settings")) then
        local settingVars = getSettingVars("Circular", "Property")

        circularSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Circular")
        cache.saveTable("CircularPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Random Settings")) then
        local settingVars = getSettingVars("Random", "Property")

        randomSettingsMenu(settingVars, false, false, true)

        saveSettingPropertiesButton(settingVars, "Random")
        cache.saveTable("RandomPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Chinchilla Settings")) then
        local settingVars = getSettingVars("Chinchilla", "Property")

        chinchillaSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Chinchilla")
        cache.saveTable("ChinchillaPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Code Settings")) then
        local settingVars = getSettingVars("Code", "Property")

        codeSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Code")
        cache.saveTable("CodePropertySettings", settingVars)
    end

    imgui.SeparatorText("Special Settings")

    if (imgui.CollapsingHeader("Stutter Settings")) then
        local settingVars = getSettingVars("Stutter", "Property")

        stutterSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Stutter")
        cache.saveTable("StutterPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Teleport Stutter Settings")) then
        local settingVars = getSettingVars("TeleportStutter", "Property")

        teleportStutterSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "TeleportStutter")
        cache.saveTable("TeleportStutterPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Automate Settings")) then
        local settingVars = getSettingVars("Automate", "Property")

        automateSVSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Automate")
        cache.saveTable("AutomatePropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Penis Settings")) then
        local settingVars = getSettingVars("Penis", "Property")

        penisSettingsMenu(settingVars)

        saveSettingPropertiesButton(settingVars, "Penis")
        cache.saveTable("PenisPropertySettings", settingVars)
    end

    imgui.SeparatorText("SV Vibrato Settings")

    if (imgui.CollapsingHeader("Linear Vibrato SV Settings")) then
        local settingVars = getSettingVars("LinearVibratoSV", "Property")

        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)

        saveSettingPropertiesButton(settingVars, "LinearVibratoSV")
        cache.saveTable("LinearVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Polynomial Vibrato SV Settings")) then
        local settingVars = getSettingVars("PolynomialVibratoSV", "Property")

        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Bounds##Vibrato", " msx", 0, 0.875)

        saveSettingPropertiesButton(settingVars, "PolynomialVibratoSV")
        cache.saveTable("PolynomialVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Exponential Vibrato SV Settings")) then
        local settingVars = getSettingVars("ExponentialVibratoSV", "Property")

        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)

        saveSettingPropertiesButton(settingVars, "ExponentialVibratoSV")
        cache.saveTable("ExponentialVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sinusoidal Vibrato SV Settings")) then
        local settingVars = getSettingVars("SinusoidalVibratoSV", "Property")

        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        chooseMsxVerticalShift(settingVars, 0)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)

        saveSettingPropertiesButton(settingVars, "SinusoidalVibratoSV")
        cache.saveTable("SinusoidalVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sigmoidal Vibrato SV Settings")) then
        local settingVars = getSettingVars("SigmoidalVibratoSV", "Property")

        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)

        saveSettingPropertiesButton(settingVars, "SigmoidalVibratoSV")
        cache.saveTable("SigmoidalVibratoSVPropertySettings", settingVars)
    end

    imgui.SeparatorText("SSF Vibrato Settings")

    if (imgui.CollapsingHeader("Linear Vibrato SSF Settings")) then
        local settingVars = getSettingVars("LinearVibratoSSF", "Property")

        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")

        saveSettingPropertiesButton(settingVars, "LinearVibratoSSF")
        cache.saveTable("LinearVibratoSSFPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Exponential Vibrato SSF Settings")) then
        local settingVars = getSettingVars("ExponentialVibratoSSF", "Property")

        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)

        saveSettingPropertiesButton(settingVars, "ExponentialVibratoSSF")
        cache.saveTable("ExponentialVibratoSSFPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sinusoidal Vibrato SSF Settings")) then
        local settingVars = getSettingVars("SinusoidalVibratoSSF", "Property")

        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        chooseConstantShift(settingVars)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)

        saveSettingPropertiesButton(settingVars, "SinusoidalVibratoSSF")
        cache.saveTable("SinusoidalVibratoSSFPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sigmoidal Vibrato SSF Settings")) then
        local settingVars = getSettingVars("SigmoidalVibratoSSF", "Property")

        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)

        saveSettingPropertiesButton(settingVars, "SigmoidalVibratoSSF")
        cache.saveTable("SigmoidalVibratoSSFPropertySettings", settingVars)
    end
end
