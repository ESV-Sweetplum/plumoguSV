function selectByTimingGroupMenu()
    local menuVars = getMenuVars("selectByTimingGroup")
    imgui.AlignTextToFramePadding()
    imgui.Text("Select in:")
    KeepSameLine()

    local groups = { "$Default", "$Global" }
    local cols = { map.TimingGroups["$Default"].ColorRgb or "86,253,110", map.TimingGroups["$Global"].ColorRgb or
    "255,255,255" }
    local hiddenGroups = {}
    for tgId, tg in pairs(map.TimingGroups) do
        if string.find(tgId, "%$") then goto cont end
        if (globalVars.hideAutomatic and string.find(tgId, "automate_")) then
            table.insert(hiddenGroups,
                tgId)
        end
        table.insert(groups, tgId)
        table.insert(cols, tg.ColorRgb or "255,255,255")
        ::cont::
    end
    local prevIndex = table.indexOf(groups, menuVars.designatedTimingGroup)
    imgui.PushItemWidth(155)
    local newIndex = Combo("##changingScrollGroup", groups, prevIndex, cols, hiddenGroups)
    imgui.PopItemWidth()
    imgui.Dummy(vector.New(0, 2))

    menuVars.designatedTimingGroup = groups[newIndex]

    simpleActionMenu(table.concat({ "Select notes in ", menuVars.designatedTimingGroup }), 2, selectByTimingGroup,
        menuVars)

    cache.saveTable("selectByTimingGroupMenu", menuVars)
end
