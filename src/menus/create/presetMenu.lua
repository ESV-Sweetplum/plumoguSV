function renderPresetMenu(menuLabel, menuVars, settingVars)
    local presetVars = {
        newPresetName = '',
        importPresetName = '',
        editModeEnabled = false,
        importingPreset = false,
    }

    cache.load('vars/menu/preset', presetVars)

    imgui.SetCursorPosX(26)
    presetVars.editModeEnabled = RadioButtons('', presetVars.editModeEnabled, { 'Select Mode', 'Edit Mode' },
        { false, true },
        { 'Allows you to select/delete presets.',
            'Allows you to setup preset shortcuts.' })
    AddSeparator()
    if (not presetVars.editModeEnabled) then
        imgui.AlignTextToFramePadding()
        imgui.Text('New Preset Name:')
        KeepSameLine()
        imgui.PushItemWidth(90)
        _, presetVars.newPresetName = imgui.InputTextWithHint('##PresetName', 'e.g. Jump', presetVars.newPresetName, 4096)
        imgui.PopItemWidth()
        imgui.SameLine()
        local saveButtonClicked = imgui.Button('Save')
        HoverToolTip('Saves the current menu as a preset.')
        if (saveButtonClicked and presetVars.newPresetName:len() == 0) then
            print('e!', 'Please enter a name for your new preset.')
        elseif (saveButtonClicked and presetVars.newPresetName:len() > 0) then
            preset = {}
            preset.name = presetVars.newPresetName
            presetVars.newPresetName = ''
            preset.data = table.stringify({ menuVars = menuVars, settingVars = settingVars })
            preset.type = menuLabel
            preset.flags = {
                enabled = false,
                combo = #globalVars.presets <= 8 and 'Ctrl+Shift+' .. (#globalVars.presets + 1) or 'NONE',
            }
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
    else
        local importedPresetName = presetVars.importPresetName
        imgui.AlignTextToFramePadding()
        imgui.Text('Import Preset:')
        KeepSameLine()
        imgui.PushItemWidth(103)
        _, importedPresetName = imgui.InputTextWithHint('##CustomPreset', 'Exported Str.', importedPresetName,
            MAX_IMPORT_CHARACTER_LIMIT)
        imgui.PopItemWidth()
        imgui.SameLine()
        if (imgui.Button('Import##CustomPreset')) then
            local parsedTable = table.parse(importedPresetName)
            if (table.includes(table.property(globalVars.presets, 'name'), parsedTable.name)) then
                print('e!',
                    'A preset with this name already exists. Please remove it or change the name in the import string.')
            else
                table.insert(globalVars.presets, parsedTable)
                importedPresetName = ''
                write(globalVars)
            end
        end
    end

    AddPadding()

    if (not presetVars.editModeEnabled) then
        InitializeTable('Preset Columns', 3, 1920,
            { '  Name##Preset', ' Menu##Preset', ' Actions##Preset' }, {
                { imgui_table_column_flags.WidthFixed, 80 },
                { imgui_table_column_flags.WidthFixed, 60 },
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
                cache.save(preset.menu .. preset.type .. 'Settings', data.settingVars)
                cache.save('place' .. preset.type .. 'Menu', data.menuVars)
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
        end

        imgui.EndTable()
    else
        InitializeTable('Preset Columns', 2, 1920,
            { '  Name##Preset', ' Flags##Preset' }, {
                { imgui_table_column_flags.WidthFixed, 80 },
                { imgui_table_column_flags.WidthFixed, 148 },
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
            preset.flags.enabled = truthy(preset.flags.enabled)
            local oldEnabled = preset.flags.enabled
            BasicCheckbox(preset.flags, 'enabled', 'CMB:##PresetEditEnabled' .. idx)
            HoverToolTip('If enabled, the key combo next to this button will trigger the preset.')
            KeepSameLine()
            imgui.SetNextItemWidth(100)
            _, preset.flags.combo = imgui.InputText('##PresetEditCombo' .. idx, preset.flags.combo, 4096)
            if (imgui.IsItemDeactivatedAfterEdit() or preset.flags.enabled ~= oldEnabled) then
                write(globalVars)
            end
            imgui.PopID()
        end

        imgui.EndTable()
    end

    cache.save('vars/menu/preset', presetVars)
end
