TAB_MENUS = { -- names of the tab menus
    "Info",
    "Select",
    "Create",
    "Edit",
    "Delete"
}

---Creates a menu tab.
---@param tabName string
function createMenuTab(tabName)
    if not imgui.BeginTabItem(tabName) then return end
    AddPadding()
    if tabName == "Info" then
        infoTab()
    else
        state.SetValue("showSettingsWindow", false)
    end
    if tabName == "Select" then selectTab() end
    if tabName == "Create" then createSVTab() end
    if tabName == "Edit" then editSVTab() end
    if tabName == "Delete" then deleteTab() end
    imgui.EndTabItem()
end
