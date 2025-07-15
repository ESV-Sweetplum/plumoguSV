function changeGroupsMenu()
    local menuVars = getMenuVars("changeGroups")
    imgui.AlignTextToFramePadding()
    imgui.Text("  Move to: ")
    keepSameLine()

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
    local newIndex = combo("##changingScrollGroup", groups, prevIndex, cols, hiddenGroups)
    imgui.PopItemWidth()
    imgui.Dummy(vector.New(0, 2))

    menuVars.designatedTimingGroup = groups[newIndex]

    _, menuVars.changeSVs = imgui.Checkbox("Change SVs?", menuVars.changeSVs)
    keepSameLine()
    _, menuVars.changeSSFs = imgui.Checkbox("Change SSFs?", menuVars.changeSSFs)

    addSeparator()

    simpleActionMenu("Move items to " .. menuVars.designatedTimingGroup, 2, changeGroups, menuVars)
end
