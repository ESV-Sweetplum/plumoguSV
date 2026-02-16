function saveSettingPropertiesButton(settingVars, label)
    local saveButtonClicked = imgui.Button('Save##setting' .. label)
    imgui.Separator()
    if (not saveButtonClicked) then return end
    label = label:identify()
    if (not globalVars.defaultProperties) then globalVars.defaultProperties = {} end
    if (not globalVars.defaultProperties.settings) then globalVars.defaultProperties.settings = {} end
    globalVars.defaultProperties.settings[label] = settingVars
    loadDefaultProperties(globalVars.defaultProperties)
    write(globalVars)

    print('s!',
        'Default setting properties for submenu "' ..
        label .. '" have been set. Changes will be shown on the next plugin refresh.')
end

function saveMenuPropertiesButton(menuVars, label)
    local saveButtonClicked = imgui.Button('Save##menu' .. label)
    imgui.Separator()
    if (not saveButtonClicked) then return end
    label = label:identify()
    if (not globalVars.defaultProperties) then globalVars.defaultProperties = {} end
    if (not globalVars.defaultProperties.menu) then globalVars.defaultProperties.menu = {} end
    globalVars.defaultProperties.menu[label] = menuVars
    loadDefaultProperties(globalVars.defaultProperties)
    write(globalVars)

    print('s!',
        'Default menu properties for menu "' ..
        label .. '" have been set. Changes will be shown on the next plugin refresh.')
end

function showDefaultPropertiesSettings()
    local standardFnList = {
        linearSettingsMenu,
        exponentialSettingsMenu,
        bezierSettingsMenu,
        hermiteSettingsMenu,
        sinusoidalSettingsMenu,
        circularSettingsMenu,
        randomSettingsMenu,
        customSettingsMenu,
        chinchillaSettingsMenu,
        comboSettingsMenu,
        codeSettingsMenu,
    }

    local specialFnList = {
        stutterSettingsMenu,
        teleportStutterSettingsMenu,
        nil,
        automateSVSettingsMenu,
        penisSettingsMenu,
    }

    local editFnList = {
        addTeleportSettingsMenu,
        changeGroupsSettingsMenu,
        completeDuplicateSettingsMenu,
        convertSVSSFSettingsMenu,
        copyNPasteSettingsMenu,
        nil,
        displaceNoteSettingsMenu,
        displaceViewSettingsMenu,
        nil,
        flickerSettingsMenu,
        nil,
        nil,
        nil,
        reverseScrollSettingsMenu,
        scaleDisplaceSettingsMenu,
        scaleMultiplySettingsMenu,
        splitSettingsMenu,
        nil,
        verticalShiftSettingsMenu,
    }

    imgui.SeparatorText('Create Tab Settings')

    if (imgui.CollapsingHeader('General Standard Settings')) then
        local menuVars = getMenuVars('placeStandard', 'Property')

        chooseStandardSVType(menuVars, false)
        AddSeparator()
        chooseInterlace(menuVars)

        saveMenuPropertiesButton(menuVars, 'placeStandard')
        cache.saveTable('placeStandardPropertyMenu', menuVars)
    end
    if (imgui.CollapsingHeader('General Special Settings')) then
        local menuVars = getMenuVars('placeSpecial', 'Property')

        chooseSpecialSVType(menuVars)

        saveMenuPropertiesButton(menuVars, 'placeSpecial')
        cache.saveTable('placeSpecialPropertyMenu', menuVars)
    end
    if (imgui.CollapsingHeader('General Still Settings')) then
        local menuVars = getMenuVars('placeStill', 'Property')

        chooseStandardSVType(menuVars, false)
        AddSeparator()
        menuVars.noteSpacing = ComputableInputFloat('Note Spacing', menuVars.noteSpacing, 2, 'x')
        menuVars.stillBehavior = Combo('Still Behavior', STILL_BEHAVIOR_TYPES, menuVars.stillBehavior)
        chooseStillType(menuVars)
        chooseInterlace(menuVars)

        saveMenuPropertiesButton(menuVars, 'placeStill')
        cache.saveTable('placeStillPropertyMenu', menuVars)
    end
    if (imgui.CollapsingHeader('General Vibrato Settings')) then
        local menuVars = getMenuVars('placeVibrato', 'Property')

        chooseVibratoSVType(menuVars)
        AddSeparator()
        imgui.Text('Vibrato Settings:')
        menuVars.vibratoMode = Combo('Vibrato Mode', VIBRATO_TYPES, menuVars.vibratoMode)
        chooseVibratoQuality(menuVars)
        if (menuVars.vibratoMode ~= 2) then
            chooseVibratoSides(menuVars)
        end

        saveMenuPropertiesButton(menuVars, 'placeVibrato')
        cache.saveTable('placeVibratoPropertyMenu', menuVars)
    end

    imgui.SeparatorText('Edit Tab Settings')

    local editTabDict = table.map(EDIT_SV_TOOLS, function(element, idx)
        return { label = element, fn = editFnList[idx] }
    end)

    for _, tbl in pairs(editTabDict) do
        local label = tbl.label
        if (not tbl.fn) then goto continue end
        if (imgui.CollapsingHeader(label .. ' Settings')) then
            local menuVars = getMenuVars(label, 'Property')
            tbl.fn(menuVars)
            saveMenuPropertiesButton(menuVars, label)
            cache.saveTable(label .. 'PropertyMenu', menuVars)
        end
        ::continue::
    end

    imgui.SeparatorText('Delete Tab Settings')

    if (imgui.CollapsingHeader('Delete Menu Settings')) then
        local menuVars = getMenuVars('delete', 'Property')

        _, menuVars.deleteTable[1] = imgui.Checkbox('Delete Lines', menuVars.deleteTable[1])
        KeepSameLine()
        _, menuVars.deleteTable[2] = imgui.Checkbox('Delete SVs', menuVars.deleteTable[2])
        _, menuVars.deleteTable[3] = imgui.Checkbox('Delete SSFs', menuVars.deleteTable[3])
        imgui.SameLine(0, SAMELINE_SPACING + 3.5)
        _, menuVars.deleteTable[4] = imgui.Checkbox('Delete Bookmarks', menuVars.deleteTable[4])

        saveMenuPropertiesButton(menuVars, 'delete')
        cache.saveTable('deletePropertyMenu', menuVars)
    end

    imgui.SeparatorText('Select Tab Settings')

    -- local selectTabDict = table.map(SELECT_TOOLS, function(element, idx)
    --     return { label = element, fn = selectFnList[idx] }
    -- end)

    -- for _, tbl in pairs(selectFnList) do
    --     local label = tbl.label
    --     if (not tbl.fn) then goto continue end
    --     if (imgui.CollapsingHeader(label .. " Settings")) then
    --         local menuVars = getMenuVars(label, "Property")
    --         tbl.fn(menuVars)
    --         saveMenuPropertiesButton(menuVars, label)
    --         cache.saveTable(label .. "PropertyMenu", menuVars)
    --     end
    --     ::continue::
    -- end

    if (imgui.CollapsingHeader('Select Alternating Settings')) then
        local menuVars = getMenuVars('selectAlternating', 'Property')

        BasicInputInt(menuVars, 'every', 'Every __ notes', { 1, MAX_SV_POINTS })
        BasicInputInt(menuVars, 'offset', 'From note #__', { 1, menuVars.every })

        saveMenuPropertiesButton(menuVars, 'selectAlternating')
        cache.saveTable('selectAlternatingPropertyMenu', menuVars)
    end
    if (imgui.CollapsingHeader('Select By Snap Settings')) then
        local menuVars = getMenuVars('selectBySnap', 'Property')

        BasicInputInt(menuVars, 'snap', 'Snap', { 1, 100 })

        saveMenuPropertiesButton(menuVars, 'selectBySnap')
        cache.saveTable('selectBySnapPropertyMenu', menuVars)
    end
    if (imgui.CollapsingHeader('Select Chord Size Settings')) then
        local menuVars = getMenuVars('selectChordSize', 'Property')

        for idx = 1, game.keyCount do
            local varLabel = 'select' .. idx
            local label = table.concat({ 'Size ' .. idx .. ' Chord' })
            _, menuVars[varLabel] = imgui.Checkbox(label, menuVars[varLabel])
            if (idx % 2 == 1) then KeepSameLine() end
        end

        saveMenuPropertiesButton(menuVars, 'selectChordSize')
        cache.saveTable('selectChordSizePropertyMenu', menuVars)
    end
    if (imgui.CollapsingHeader('Select Note Type Settings')) then
        local menuVars = getMenuVars('selectNoteType', 'Property')

        _, menuVars.rice = imgui.Checkbox('Select Rice Notes', menuVars.rice)
        KeepSameLine()
        _, menuVars.ln = imgui.Checkbox('Select LNs', menuVars.ln)

        saveMenuPropertiesButton(menuVars, 'selectNoteType')
        cache.saveTable('selectNoteTypePropertyMenu', menuVars)
    end

    imgui.SeparatorText('Standard/Still Settings')

    local standardMenuDict = table.map(STANDARD_SVS, function(element, idx)
        return { label = element, fn = standardFnList[idx] }
    end)

    for _, tbl in pairs(standardMenuDict) do
        local label = tbl.label
        if (imgui.CollapsingHeader(label .. ' Settings')) then
            local settingVars = getSettingVars(label, 'Property')
            tbl.fn(settingVars, false, false, 'Property')
            saveSettingPropertiesButton(settingVars, label)
            cache.saveTable(label .. 'PropertySettings', settingVars)
        end
    end

    imgui.SeparatorText('Special Settings')

    local specialMenuDict = table.map(SPECIAL_SVS, function(element, idx)
        return { label = element, fn = specialFnList[idx] }
    end)

    for _, tbl in pairs(specialMenuDict) do
        local label = tbl.label
        if (not tbl.fn) then goto continue end
        if (imgui.CollapsingHeader(label .. ' Settings')) then
            local settingVars = getSettingVars(label, 'Property')
            tbl.fn(settingVars)
            saveSettingPropertiesButton(settingVars, label)
            cache.saveTable(label .. 'PropertySettings', settingVars)
        end
        ::continue::
    end

    imgui.SeparatorText('SV Vibrato Settings')

    if (imgui.CollapsingHeader('Linear Vibrato SV Settings')) then
        local settingVars = getSettingVars('LinearVibratoSV', 'Property')

        SwappableNegatableInputFloat2(settingVars, 'startMsx', 'endMsx', 'Start/End', ' msx', 0, 0.875)

        saveSettingPropertiesButton(settingVars, 'LinearVibratoSV')
        cache.saveTable('LinearVibratoSVPropertySettings', settingVars)
    end
    if (imgui.CollapsingHeader('Polynomial Vibrato SV Settings')) then
        local settingVars = getSettingVars('PolynomialVibratoSV', 'Property')

        SwappableNegatableInputFloat2(settingVars, 'startMsx', 'endMsx', 'Bounds##Vibrato', ' msx', 0, 0.875)

        saveSettingPropertiesButton(settingVars, 'PolynomialVibratoSV')
        cache.saveTable('PolynomialVibratoSVPropertySettings', settingVars)
    end
    if (imgui.CollapsingHeader('Exponential Vibrato SV Settings')) then
        local settingVars = getSettingVars('ExponentialVibratoSV', 'Property')

        SwappableNegatableInputFloat2(settingVars, 'startMsx', 'endMsx', 'Start/End', ' msx', 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)

        saveSettingPropertiesButton(settingVars, 'ExponentialVibratoSV')
        cache.saveTable('ExponentialVibratoSVPropertySettings', settingVars)
    end
    if (imgui.CollapsingHeader('Sinusoidal Vibrato SV Settings')) then
        local settingVars = getSettingVars('SinusoidalVibratoSV', 'Property')

        SwappableNegatableInputFloat2(settingVars, 'startMsx', 'endMsx', 'Start/End', ' msx', 0, 0.875)
        chooseMsxVerticalShift(settingVars, 0)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)

        saveSettingPropertiesButton(settingVars, 'SinusoidalVibratoSV')
        cache.saveTable('SinusoidalVibratoSVPropertySettings', settingVars)
    end
    if (imgui.CollapsingHeader('Sigmoidal Vibrato SV Settings')) then
        local settingVars = getSettingVars('SigmoidalVibratoSV', 'Property')

        SwappableNegatableInputFloat2(settingVars, 'startMsx', 'endMsx', 'Start/End', ' msx', 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)

        saveSettingPropertiesButton(settingVars, 'SigmoidalVibratoSV')
        cache.saveTable('SigmoidalVibratoSVPropertySettings', settingVars)
    end

    imgui.SeparatorText('SSF Vibrato Settings')

    if (imgui.CollapsingHeader('Linear Vibrato SSF Settings')) then
        local settingVars = getSettingVars('LinearVibratoSSF', 'Property')

        SwappableNegatableInputFloat2(settingVars, 'lowerStart', 'lowerEnd', 'Lower S/E SSFs', 'x')
        SwappableNegatableInputFloat2(settingVars, 'higherStart', 'higherEnd', 'Higher S/E SSFs', 'x')

        saveSettingPropertiesButton(settingVars, 'LinearVibratoSSF')
        cache.saveTable('LinearVibratoSSFPropertySettings', settingVars)
    end
    if (imgui.CollapsingHeader('Exponential Vibrato SSF Settings')) then
        local settingVars = getSettingVars('ExponentialVibratoSSF', 'Property')

        SwappableNegatableInputFloat2(settingVars, 'lowerStart', 'lowerEnd', 'Lower S/E SSFs', 'x')
        SwappableNegatableInputFloat2(settingVars, 'higherStart', 'higherEnd', 'Higher S/E SSFs', 'x')
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)

        saveSettingPropertiesButton(settingVars, 'ExponentialVibratoSSF')
        cache.saveTable('ExponentialVibratoSSFPropertySettings', settingVars)
    end
    if (imgui.CollapsingHeader('Sinusoidal Vibrato SSF Settings')) then
        local settingVars = getSettingVars('SinusoidalVibratoSSF', 'Property')

        SwappableNegatableInputFloat2(settingVars, 'lowerStart', 'lowerEnd', 'Lower S/E SSFs', 'x')
        SwappableNegatableInputFloat2(settingVars, 'higherStart', 'higherEnd', 'Higher S/E SSFs', 'x')
        chooseConstantShift(settingVars)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)

        saveSettingPropertiesButton(settingVars, 'SinusoidalVibratoSSF')
        cache.saveTable('SinusoidalVibratoSSFPropertySettings', settingVars)
    end
    if (imgui.CollapsingHeader('Sigmoidal Vibrato SSF Settings')) then
        local settingVars = getSettingVars('SigmoidalVibratoSSF', 'Property')

        SwappableNegatableInputFloat2(settingVars, 'lowerStart', 'lowerEnd', 'Lower S/E SSFs', 'x')
        SwappableNegatableInputFloat2(settingVars, 'higherStart', 'higherEnd', 'Higher S/E SSFs', 'x')
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)

        saveSettingPropertiesButton(settingVars, 'SigmoidalVibratoSSF')
        cache.saveTable('SigmoidalVibratoSSFPropertySettings', settingVars)
    end
end
