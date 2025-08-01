function renderPresetMenu(menuLabel, menuVars, settingVars)
    local newPresetName = state.GetValue("newPresetName", "")
    imgui.AlignTextToFramePadding()
    imgui.Text("New Preset Name:")
    KeepSameLine()
    imgui.PushItemWidth(90)
    _, newPresetName = imgui.InputText("##PresetName", newPresetName, 4096)
    imgui.PopItemWidth()
    imgui.SameLine()
    if (imgui.Button("Save") and newPresetName:len() > 0) then
        preset = {}
        preset.name = newPresetName
        newPresetName = ""
        preset.data = table.stringify({ menuVars = menuVars, settingVars = settingVars })
        preset.type = menuLabel
        if (menuLabel == "Standard" or menuLabel == "Still") then
            preset.menu = STANDARD_SVS[menuVars.svTypeIndex]
        end
        if (menuLabel == "Special") then
            preset.menu = SPECIAL_SVS[menuVars.svTypeIndex]
        end
        if (menuLabel == "Vibrato") then
            preset.menu = VIBRATO_SVS[menuVars.svTypeIndex]
        end
        table.insert(globalVars.presets, preset)
        write(globalVars)
    end

    state.SetValue("newPresetName", newPresetName)
    imgui.Columns(3)

    imgui.Text("Name")
    imgui.NextColumn()
    imgui.Text("Menu")
    imgui.NextColumn()
    imgui.Text("Actions")
    imgui.NextColumn()

    imgui.Separator()
    for idx, preset in pairs(globalVars.presets) do
        imgui.AlignTextToFramePadding()
        imgui.Text(preset.name)
        imgui.NextColumn()
        imgui.AlignTextToFramePadding()
        imgui.Text(table.concat({ preset.type:shorten(), " > ", removeTrailingTag(preset.menu):sub(1, 3) }))
        imgui.NextColumn()
        if (imgui.Button("Select##Preset" .. idx)) then
            local data = table.parse(preset.data)
            globalVars.placeTypeIndex = table.indexOf(CREATE_TYPES, preset.menu)
            saveVariables(preset.menu .. preset.type .. "Settings", data.settingVars)
            saveVariables("place" .. preset.type .. "Menu", data.menuVars)
            globalVars.showPresetMenu = false
        end
        KeepSameLine()
        if (imgui.Button("X##Preset" .. idx)) then
            table.remove(globalVars.presets, idx)
            write(globalVars)
        end
    end

    imgui.SetColumnWidth(0, 90)
    imgui.SetColumnWidth(1, 73)
    imgui.SetColumnWidth(2, 95)

    imgui.Columns(1)
end
