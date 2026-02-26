function renderPresetMenu(menuLabel, menuVars, settingVars)
    local newPresetName = state.GetValue('newPresetName', '')
    imgui.AlignTextToFramePadding()
    imgui.Text('New Preset Name:')
    KeepSameLine()
    imgui.PushItemWidth(90)
    _, newPresetName = imgui.InputText('##PresetName', newPresetName, 4096)
    imgui.PopItemWidth()
    imgui.SameLine()
    if (imgui.Button('Save') and newPresetName:len() > 0) then
        preset = {}
        preset.name = newPresetName
        newPresetName = ''
        preset.data = json.serialize({ menuVars = menuVars, settingVars = settingVars })
        preset.type = menuLabel
        if (menuLabel == 'Standard' or menuLabel == 'Still') then
            preset.menu = STANDARD_SVS[menuVars.svTypeIndex]
        end
        if (menuLabel == 'Special') then
            preset.menu = SPECIAL_SVS[menuVars.svTypeIndex]
        end
        if (menuLabel == 'Vibrato') then
            preset.menu = VIBRATO_SVS[menuVars.svTypeIndex]
        end
        table.insert(globalVars.presets, preset)
        write(globalVars)
    end
    state.SetValue('newPresetName', newPresetName)

    AddSeparator()

    local importCustomPreset = state.GetValue('importCustomPreset', '')
    imgui.AlignTextToFramePadding()
    imgui.Text('Import Preset:')
    KeepSameLine()
    imgui.PushItemWidth(103)
    _, importCustomPreset = imgui.InputText('##CustomPreset', importCustomPreset, MAX_IMPORT_CHARACTER_LIMIT)
    state.SetValue('importCustomPreset', importCustomPreset)
    imgui.PopItemWidth()
    imgui.SameLine()
    if (imgui.Button('Import##CustomPreset')) then
        local parsedTable = json.parse(importCustomPreset)
        if (table.includes(table.property(globalVars.presets, 'name'), parsedTable.name)) then
            print('e!',
                'A preset with this name already exists. Please remove it or change the name in the import string.')
        else
            table.insert(globalVars.presets, parsedTable)
            importCustomPreset = ''
            write(globalVars)
        end
    end

    AddSeparator()

    imgui.Columns(3)

    imgui.SetColumnWidth(0, 90)
    imgui.SetColumnWidth(1, 73)
    imgui.SetColumnWidth(2, 95)

    imgui.Text('Name')
    imgui.NextColumn()
    imgui.Text('Menu')
    imgui.NextColumn()
    imgui.Text('Actions')
    imgui.NextColumn()

    imgui.Separator()
    for idx, preset in pairs(globalVars.presets) do
        imgui.AlignTextToFramePadding()
        imgui.Text(preset.name)
        imgui.NextColumn()
        imgui.AlignTextToFramePadding()
        imgui.Text(table.concat({ preset.type:shorten(), ' > ', removeTrailingTag(preset.menu):sub(1, 3) }))
        imgui.NextColumn()
        if (imgui.Button('Select##Preset' .. idx)) then
            local data = json.parse(preset.data)
            globalVars.placeTypeIndex = table.indexOf(CREATE_TYPES, preset.type)
            cache.saveTable(preset.menu .. preset.type .. 'Settings', data.settingVars)
            cache.saveTable('place' .. preset.type .. 'Menu', data.menuVars)
            globalVars.showPresetMenu = false
        end
        if (imgui.IsItemClicked('Right')) then
            imgui.SetClipboardText(json.serialize(preset))
            print('i!', 'Exported preset to your clipboard.')
        end
        HoverToolTip('Left-click to select this preset. Right-click to copy this preset to your clipboard.')
        KeepSameLine()
        if (imgui.Button('X##Preset' .. idx)) then
            table.remove(globalVars.presets, idx)
            write(globalVars)
        end
        imgui.NextColumn()
    end

    imgui.Columns(1)
end
