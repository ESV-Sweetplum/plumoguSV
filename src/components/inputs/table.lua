---Alias of `imgui.BeginTable` with some extra features.
---@param str_id string
---@param columnCount integer
---@param tableFlags ImGuiTableFlags
---@param columnNames string[]
---@param columnFlags (ImGuiTableColumnFlags | [ImGuiTableColumnFlags, number])[]
---@param showHeaderRow? boolean
function InitializeTable(str_id, columnCount, tableFlags, columnNames, columnFlags, showHeaderRow)
    imgui.BeginTable(str_id, columnCount, tableFlags)

    for i = 1, columnCount do
        local name = columnNames[i]
        local flags = columnFlags[i]
        if (type(flags) == 'table') then
            imgui.TableSetupColumn(name, flags[1], flags[2])
        else
            imgui.TableSetupColumn(name, flags)
        end
    end

    if (showHeaderRow) then imgui.TableHeadersRow() end
end
