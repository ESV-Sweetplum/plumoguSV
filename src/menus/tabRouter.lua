TAB_MENUS = { -- names of the tab menus
    'Info',
    'Select',
    'Create',
    'Edit',
    'Delete',
}

---Creates a menu tab.
---@param tabName string
function createMenuTab(tabName)
    imgui.SetWindowFontScale(0.9)
    if not imgui.BeginTabItem(tabName) then return end
    imgui.SetWindowFontScale(1)
    AddPadding()
    if tabName == 'Info' then infoTab() end
    if tabName == 'Select' then selectTab() end
    if tabName == 'Create' then createSVTab() end
    if tabName == 'Edit' then editSVTab() end
    if tabName == 'Delete' then deleteTab() end
    imgui.EndTabItem()
end
