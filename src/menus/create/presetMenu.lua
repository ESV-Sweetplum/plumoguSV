function renderPresetMenu(menuLabel, menuVars, settingVars)
    local newPresetName = state.GetValue('newPresetName', '')
    imgui.AlignTextToFramePadding()
    imgui.Text('New Preset Name:')
    KeepSameLine()
    imgui.PushItemWidth(90)
    _, newPresetName = imgui.InputText('##PresetName', newPresetName, 4096)
    imgui.PopItemWidth()
    imgui.SameLine()
    local saveButtonClicked = imgui.Button('Save')
    if (saveButtonClicked and newPresetName:len() == 0) then
        print('e!', 'Please enter a name for your new preset.')
    end
    if (saveButtonClicked and newPresetName:len() > 0) then
        preset = {}
        preset.name = newPresetName
        newPresetName = ''
        preset.data = table.stringify({ menuVars = menuVars, settingVars = settingVars })
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
        print('i!', 'Saved preset "' .. preset.name .. '".')
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
        local parsedTable = table.parse(importCustomPreset)
        if (table.includes(table.property(globalVars.presets, 'name'), parsedTable.name)) then
            print('e!',
                'A preset with this name already exists. Please remove it or change the name in the import string.')
        else
            table.insert(globalVars.presets, parsedTable)
            importCustomPreset = ''
            write(globalVars)
        end
    end

    AddPadding()

    InitializeTable('Preset Columns', 3, imgui_table_flags.BordersInner,
        { '  Name##Preset', ' Menu##Preset', ' Actions##Preset' }, {
            { imgui_table_column_flags.WidthFixed, 80 },
            { imgui_table_column_flags.WidthFixed, 63 },
            { imgui_table_column_flags.WidthFixed, 85 },
        }, true)

    for idx, preset in pairs(globalVars.presets) do
        imgui.PushID(idx)
        imgui.TableNextRow(0, 34)
        imgui.TableSetColumnIndex(0)
        imgui.AlignTextToFramePadding()
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 2)
        imgui.Text('  ' .. preset.name)
        imgui.TableSetColumnIndex(1)
        imgui.AlignTextToFramePadding()
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 3.4)
        imgui.Text(table.concat({ '  ', preset.type:shorten(), ' > ', preset.menu:removeTrailingTag():sub(1, 3) }))
        imgui.TableSetColumnIndex(2)
        imgui.SetCursorPosX(imgui.GetCursorPosX() + 2)
        imgui.SetCursorPosY(imgui.GetCursorPosY() + 3.4)
        if (imgui.Button('Select##Preset' .. idx)) then
            local data = table.parse(preset.data)
            globalVars.placeTypeIndex = table.indexOf(CREATE_TYPES, preset.type)
            cache.saveTable(preset.menu .. preset.type .. 'Settings', data.settingVars)
            cache.saveTable('place' .. preset.type .. 'Menu', data.menuVars)
            globalVars.showPresetMenu = false
            return true
        end
        if (imgui.IsItemClicked('Right')) then
            imgui.SetClipboardText(table.stringify(preset))
            print('i!', 'Exported preset to your clipboard.')
        end
        HoverToolTip('Left-click to select this preset. Right-click to copy this preset to your clipboard.')
        KeepSameLine()
        if (imgui.Button('X##Preset' .. idx)) then
            print('e!', 'Deleted preset "' .. globalVars.presets[idx].name .. '".')
            table.remove(globalVars.presets, idx)
            write(globalVars)
        end
        imgui.PopID()
        imgui.NextColumn()
    end

    imgui.EndTable()
end
